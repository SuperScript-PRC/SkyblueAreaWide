import re
from dataclasses import dataclass, field
from collections.abc import Callable
from tooldelta import InternalBroadcast, Plugin, TYPE_CHECKING, game_utils, utils, plugin_entry

color_repl = re.compile("§.")


@dataclass
class JEI_item:
    name: str
    _make_from: list["JEI_recipe"] = field(default_factory=list)
    _can_make: list["JEI_recipe"] = field(default_factory=list)
    _descriptions: "list[JEI_description]" = field(default_factory=list)


@dataclass
class JEI_slotitem:
    item: JEI_item
    count: int


@dataclass
class JEI_crafter:
    name: str
    show_cb: Callable[[list[JEI_slotitem | None], list[JEI_slotitem | None]], str]

    def __hash__(self) -> int:
        return id(self)


@dataclass
class JEI_recipe:
    crafter: JEI_crafter
    use_items: list[JEI_slotitem | None]
    out_items: list[JEI_slotitem | None]


@dataclass
class JEI_description:
    item: JEI_item
    description: str


class JEIItemSearcher(Plugin):
    name = "JEI物品查询器"
    author = "SuperScript"
    version = (0, 0, 1)
    JEI_item = JEI_item
    JEI_slotitem = JEI_slotitem
    JEI_crafter = JEI_crafter
    JEI_recipe = JEI_recipe
    JEI_description = JEI_description

    def __init__(self, f):
        super().__init__(f)
        self.items: dict[str, JEI_item] = {}
        self.crafters: dict[str, JEI_crafter] = {}
        self.recipes: dict[JEI_crafter, list[JEI_recipe]] = {}
        self.ListenPreload(self.on_def)
        self.ListenActive(self.on_inject)
        self.ListenInternalBroadcast("群服互通/链接群消息", self.recvqq)

    def on_def(self):
        self.chatbar = self.GetPluginAPI("聊天栏菜单")
        self.qqlink = self.GetPluginAPI("群服互通")
        if TYPE_CHECKING:
            from 前置_聊天栏菜单 import ChatbarMenu

            self.chatbar = self.get_typecheck_plugin_api(ChatbarMenu)

    def on_inject(self):
        self.chatbar.add_trigger(
            ["查询", "jei"],
            "[物品名]",
            "查询物品或特殊配方",
            self.on_check_item,
            lambda x: x == 1,
        )
        self.add_description(
            JEI_description(
                JEI_item("jei物品查询器"),
                "JEI物品查询器可以帮助你查询各种服内特殊物品的制作/使用和介绍。",
            )
        )


    def recvqq(self, data: InternalBroadcast):
        self.qq_recv(data.data)
        return False

    @utils.thread_func("qq接收")
    def qq_recv(self, data):
        self.linked_group = self.qqlink.linked_group
        qqid = data["QQ号"]
        msg = data["消息"]
        if msg.startswith("jei"):
            jdata = msg.split()
            if len(jdata) != 2:
                return
        else:
            return
        search_name = jdata[1]
        if search_name in self.crafters.keys():
            # 搜寻配方
            res = self.crafters[search_name]
        elif search_name in self.items.keys():
            # 搜寻物品
            res = self.items[search_name]
        else:
            res_list: list[JEI_crafter | JEI_item | JEI_description] = []
            for c_name, v in self.crafters.items():
                # 搜寻配方
                if search_name in c_name.lower():
                    res_list.append(v)
            for i_name, v in self.items.items():
                # 搜寻物品
                if search_name in i_name.lower():
                    res_list.append(v)
            if res_list == []:
                self.qqlink.sendmsg(
                    self.qqlink.linked_group,
                    f"[CQ:at,qq={qqid}] 暂未查询到任何有关物品或配方",
                )
                return
            retu = ["查询到的结果如下："]
            for i, j in enumerate(res_list):
                if isinstance(j, JEI_item):
                    retu.append(f"  [{i + 1}] {j.name}")
                elif isinstance(j, JEI_crafter):
                    retu.append(f"  [{i + 1}] {j.name}")
            self.qqlink.sendmsg(
                self.linked_group,
                "\n".join(retu) + f"\n[CQ:at,qq={qqid}] 请输入选项序号：",
            )
            res_choice = utils.try_int(self.qqlink.waitMsg(qqid))
            if res_choice is None or res_choice not in range(1, len(res_list) + 1):
                self.qqlink.sendmsg(
                    self.linked_group, f"[CQ:at,qq={qqid}] 无效选项， 已退出"
                )
                return
            res = res_list[res_choice - 1]
        if isinstance(res, JEI_item):
            retu = []
            if res._make_from:
                retu.append(f"{res.name}的获取方法 >")
                for i in res._make_from:
                    retu.append(f" ■ {i.crafter.name}")
                    retu.append(
                        "  "
                        + color_repl.sub(
                            "", i.crafter.show_cb(i.use_items, i.out_items)
                        ).replace("\n", "\n  "),
                    )
            if res._can_make:
                retu.append(f"{res.name}的用途 >")
                for i in res._can_make:
                    retu.append(f" ■ {i.crafter.name}")
                    retu.append(
                        "  "
                        + color_repl.sub(
                            "", i.crafter.show_cb(i.use_items, i.out_items)
                        ).replace("\n", "\n  "),
                    )
            if res._descriptions:
                retu.append(f"{res.name}的描述 >")
                for i in res._descriptions:
                    retu.append(i.description)
            self.qqlink.sendmsg(self.linked_group, color_repl.sub("", "\n".join(retu)))
        elif isinstance(res, JEI_crafter):
            retu = []
            retu.append(f"{res.name}的配方表 >")
            for i in self.recipes[res]:
                retu.append(i.crafter.show_cb(i.use_items, i.out_items))
            self.qqlink.sendmsg(self.linked_group, color_repl.sub("", "\n".join(retu)))

    def get_item_by_name(self, name: str, count: int):
        result = self.items.get(name)
        if result is None:
            item = JEI_item(name)
            self.items[name] = item
            return JEI_slotitem(item, count)
        else:
            return JEI_slotitem(result, count)

    def add_recipe(self, recipe: JEI_recipe):
        for use_item in recipe.use_items:
            if use_item:
                use_item.item._can_make.append(recipe)
                if use_item.item.name not in self.items.keys():
                    self.items[use_item.item.name] = use_item.item
        for out_item in recipe.out_items:
            if out_item:
                out_item.item._make_from.append(recipe)
                if out_item.item.name not in self.items.keys():
                    self.items[out_item.item.name] = out_item.item
        if self.recipes.get(recipe.crafter) is None:
            self.recipes[recipe.crafter] = []
        self.recipes[recipe.crafter].append(recipe)
        if recipe.crafter.name not in self.crafters.keys():
            self.crafters[recipe.crafter.name] = recipe.crafter

    def add_description(self, desc: JEI_description):
        if desc.item.name not in self.items.keys():
            self.items[desc.item.name] = desc.item
        desc.item._descriptions.append(desc)

    def on_check_item(self, player: str, args: list[str]):
        search_name = args[0]
        if search_name in self.crafters.keys():
            # 搜寻配方
            res = self.crafters[search_name]
        elif search_name in self.items.keys():
            # 搜寻物品
            res = self.items[search_name]
        else:
            res_list: list[JEI_crafter | JEI_item | JEI_description] = []
            for c_name, v in self.crafters.items():
                # 搜寻配方
                if search_name in c_name.lower():
                    res_list.append(v)
            for i_name, v in self.items.items():
                # 搜寻物品
                if search_name in i_name.lower():
                    res_list.append(v)
            if res_list == []:
                self.game_ctrl.say_to(player, "§c暂未查询到任何有关物品或配方")
                return
            self.game_ctrl.say_to(player, "§7查询到的结果§f如下：")
            for i, j in enumerate(res_list):
                if isinstance(j, JEI_item):
                    self.game_ctrl.say_to(player, f"  §7[§f{i + 1}§7] §f{j.name}")
                elif isinstance(j, JEI_crafter):
                    self.game_ctrl.say_to(player, f"  §7[§f{i + 1}§7] §6{j.name}")
            self.game_ctrl.say_to(player, "§7请输入§f选项序号：")
            res_choice = utils.try_int(game_utils.waitMsg(player))
            if res_choice is None or res_choice not in range(1, len(res_list) + 1):
                self.game_ctrl.say_to(player, "§c无效选项， 已退出")
                return
            res = res_list[res_choice - 1]
        if isinstance(res, JEI_item):
            if res._make_from:
                self.game_ctrl.say_to(player, f"§f{res.name}§a的获取方法 >")
                for i in res._make_from:
                    self.game_ctrl.say_to(player, f" §q■ §f{i.crafter.name}§7")
                    self.game_ctrl.say_to(
                        player,
                        "  "
                        + i.crafter.show_cb(i.use_items, i.out_items).replace(
                            "\n", "\n  "
                        ),
                    )
            if res._can_make:
                self.game_ctrl.say_to(player, f"§f{res.name}§6的用途 >")
                for i in res._can_make:
                    self.game_ctrl.say_to(player, f" §s■ §f{i.crafter.name}§7")
                    self.game_ctrl.say_to(
                        player,
                        "  "
                        + i.crafter.show_cb(i.use_items, i.out_items).replace(
                            "\n", "\n  "
                        ),
                    )
            if res._descriptions:
                self.game_ctrl.say_to(player, f"§f{res.name}§d的描述 >")
                for i in res._descriptions:
                    self.game_ctrl.say_to(player, i.description)
        elif isinstance(res, JEI_crafter):
            self.game_ctrl.say_to(player, f"§f{res.name}§7的配方表 >")
            for i in self.recipes[res]:
                self.game_ctrl.say_to(
                    player, i.crafter.show_cb(i.use_items, i.out_items)
                )


entry = plugin_entry(JEIItemSearcher, "jei")
