import random
from dataclasses import dataclass
from tooldelta import (
    Plugin,
    cfg,
    TYPE_CHECKING,
    Utils,
    game_utils,
    Print,
    plugin_entry,
)


@dataclass
class ItemData:
    name: str
    id: str
    count: int
    data: int = 0

    def str(self, prefix: str):
        return f"§f{self.count}x{prefix}{self.name}"


@dataclass
class Recipe:
    needs: list[ItemData]
    gives: list[ItemData]

    def __repr__(self):
        return f"{'§7+'.join(i.str('§f') for i in self.needs)} §f-> {'§7+'.join(i.str('§b') for i in self.gives)}"


class CustomCrafting(Plugin):
    name = "自定义合成兑换"
    author = "SuperScript"
    version = (0, 0, 1)

    def __init__(self, frame) -> None:
        super().__init__(frame)
        CFG_STD = {
            "配方": cfg.AnyKeyValue(
                cfg.JsonList(
                    {
                        "原料": cfg.AnyKeyValue(
                            {"ID": str, "数量": cfg.PInt, "特殊值": int}
                        ),
                        "产物": cfg.AnyKeyValue({"ID": str, "数量": cfg.PInt}),
                    }
                )
            )
        }
        CFG_DEFAULT = {
            "配方": {
                "杂物": [
                    {
                        "原料": {
                            "纸": {
                                "ID": "paper",
                                "数量": 1,
                                "特殊值": 0,
                            },
                            "线": {
                                "ID": "string",
                                "数量": 1,
                                "特殊值": 0,
                            },
                            "绿宝石": {
                                "ID": "emerald",
                                "数量": 1,
                                "特殊值": -0,
                            },
                        },
                        "产物": {"命名牌": {"ID": "name_tag", "数量": 1}},
                    }
                ]
            }
        }
        self.cfg, _ = cfg.get_plugin_config_and_version(
            self.name, CFG_STD, CFG_DEFAULT, self.version
        )
        self.ListenPreload(self.on_def)
        self.ListenActive(self.on_inject)

    def on_def(self):
        self.chatbar = self.GetPluginAPI("聊天栏菜单")
        self.waitMsg = self.GetPluginAPI("基本插件功能库").waitMsg
        self.jei = self.GetPluginAPI("jei")
        if TYPE_CHECKING:
            from 前置_聊天栏菜单 import ChatbarMenu
            from 前置_基本插件功能库 import BasicFunctionLib
            from JEI物品查询器 import JEIItemSearcher

            self.chatbar = self.get_typecheck_plugin_api(ChatbarMenu)
            self.waitMsg = self.get_typecheck_plugin_api(BasicFunctionLib).waitMsg
            self.jei = self.get_typecheck_plugin_api(JEIItemSearcher)

        def _show_cb(_i, _o):
            _i = [i for i in _i if i]
            _o = [i for i in _o if i]
            return (
                "§7+§f".join(f"{i.item.name}§7x§f{i.count}" for i in _i)
                + " -> "
                + "§7+§f".join(f"§b{i.item.name}§7x§f{i.count}" for i in _o)
            )

        JEI_Recipe = self.jei.JEI_recipe
        machine = self.jei.JEI_crafter(".craft指令合成", _show_cb)
        recipes: dict[str, list[Recipe]] = {}
        for k, v in self.cfg["配方"].items():
            if recipes.get(k) is None:
                recipes[k] = []
            for recipe in v:
                gives_list = []
                uses_list = []
                uses = recipe["原料"]
                gives = recipe["产物"]
                for k1, v1 in uses.items():
                    uses_list.append(ItemData(k1, v1["ID"], v1["数量"], v1["特殊值"]))
                for k1, v1 in gives.items():
                    gives_list.append(ItemData(k1, v1["ID"], v1["数量"]))
                recipes[k].append(Recipe(uses_list, gives_list))
                self.jei.add_recipe(
                    JEI_Recipe(
                        machine,
                        [
                            self.jei.get_item_by_name(i, recipe["原料"][i]["数量"])
                            for i in recipe["原料"].keys()
                        ],
                        [
                            self.jei.get_item_by_name(i, recipe["产物"][i]["数量"])
                            for i in recipe["产物"].keys()
                        ],
                    )
                )
        self.recipes = recipes
        Print.print_suc("自定义合成 配方加载完毕")

    def on_inject(self):
        self.chatbar.add_trigger(
            ["合成", "craft"], None, "批量合成特殊物品", self.on_select_recipe
        )

    def on_select_recipe(self, player, _):
        ks = list(self.recipes.keys())
        self.game_ctrl.say_to(player, "§7========§f<§e|§a配方§e|§f>§7========")
        for i, k in enumerate(ks):
            self.game_ctrl.say_to(player, f" §6{i + 1}§f. {k}")
        self.game_ctrl.say_to(player, "§7请输入§f选项序号 §7>")
        resp = Utils.try_int(self.waitMsg(player))
        if resp is None or resp not in range(1, len(ks) + 1):
            self.game_ctrl.say_to(player, "§c输入的序号无效")
            return
        choices = self.recipes[ks[resp - 1]]
        self.game_ctrl.say_to(player, "\n\n\n\n§7========§f<§e|§a配方§e|§f>§7========")
        for i, choice in enumerate(choices):
            self.game_ctrl.say_to(player, f" §6{i + 1}§f. {choice}")
        self.game_ctrl.say_to(player, "§7请输入§f选项序号 §7>")
        resp = Utils.try_int(orig_resp := self.waitMsg(player))
        if resp is None or resp not in range(1, len(choices) + 1):
            self.game_ctrl.say_to(player, f"§c输入的序号无效: {orig_resp}")
            return
        choice = choices[resp - 1]
        max_make = 999
        rnd_score = random.randint(-1000, 1000)
        self.game_ctrl.sendcmd_with_resp(
            f"/scoreboard players set {player} st:cache1 {rnd_score}"
        )
        lacked = []
        for need_item in choice.needs:
            count = game_utils.getItem(
                f"@a[scores={{st:cache1={rnd_score}}}]", need_item.id, need_item.data
            )
            max_make = min(max_make, count // need_item.count)
            if max_make == 0:
                lacked = [need_item.name, count, need_item.count]
                break
        if max_make == 0:
            self.game_ctrl.say_to(
                player,
                f"§6当前材料无法制作该物品： \n缺失 {lacked[0]} §7({lacked[1]}/{lacked[2]})",
            )
            return
        self.game_ctrl.say_to(player, f"§7当前最多可制作§f{max_make}份")
        self.game_ctrl.say_to(player, "§7请输入§f制作的份数 §7>")
        resp = Utils.try_int(self.waitMsg(player))
        if resp is None or resp < 1:
            self.game_ctrl.say_to(player, "§c输入的序号无效")
            return
        max_make = 999
        rnd_score = random.randint(-1000, 1000)
        self.game_ctrl.sendcmd_with_resp(
            f"/scoreboard players set {player} st:cache1 {rnd_score}"
        )
        for need_item in choice.needs:
            count = game_utils.getItem(
                f"@a[scores={{st:cache1={rnd_score}}}]", need_item.id, need_item.data
            )
            max_make = min(max_make, count // need_item.count)
            limit_make = max_make < resp
        make_num = min(resp, max_make)
        if limit_make:
            self.game_ctrl.say_to(
                player, f"§6最大可制作数小于需求制作数， 将使用最大可制作数{make_num}"
            )
        for need_item in choice.needs:
            r = self.game_ctrl.sendcmd_with_resp(
                cmd
                := f"/clear @a[scores={{st:cache1={rnd_score}}}] {need_item.id} {need_item.data} {need_item.count * make_num}"
            )
            if r.SuccessCount != 1:
                self.game_ctrl.say_to(
                    player,
                    f"§c配方合成出现问题， 请通知管理员： {r.OutputMessages[0].Message} (cmd: {cmd}, status: {r.SuccessCount}) ",
                )
                return
        for give_item in choice.gives:
            if give_item.id.startswith("structure:"):
                for i in range(give_item.count * make_num):
                    self.game_ctrl.sendwocmd(
                        f"execute as @a[name={player}] at @s run structure load {give_item.id[10:]} ~~1~"
                    )
            else:
                self.game_ctrl.sendwocmd(
                    f"give @a[name={player}] {give_item.id} {give_item.count * make_num} {give_item.data}"
                )
        self.game_ctrl.say_to(player, "§7[§a√§7] §a制作完成")


entry = plugin_entry(CustomCrafting, "自定义合成兑换")
