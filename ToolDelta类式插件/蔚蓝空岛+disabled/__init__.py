from time import sleep
from dataclasses import dataclass
from random import randint
from tooldelta import (
    Plugin,
    game_utils,
    Utils,
    TYPE_CHECKING,
    Print,
    Chat,
    Player,
    plugin_entry,
)

from tooldelta.utils import chatbar_lock_list


@dataclass
class BuyThing:
    need_name: list[str]
    need_items: dict[str, int]
    give_name: list[str]
    give_items: dict[str, int]


M_LIST = [
    BuyThing(
        ["6x木棍", "1x线"], {"stick": 6, "string": 1}, ["1x筛子"], {"scaffolding": 1}
    ),
    BuyThing(["1x圆石"], {"cobblestone": 1}, ["1x砂砾"], {"gravel": 1}),
    BuyThing(["1x砂砾"], {"gravel": 1}, ["1x沙子"], {"sand": 1}),
    BuyThing(
        ["2x钻石"],
        {"diamond": 2},
        ["1x滴水石锥(可用于生成岩浆)"],
        {"pointed_dripstone": 1},
    ),
]


class SkyblueSkyblock(Plugin):
    def __init__(self, frame):
        super().__init__(frame)
        self.ListenPreload(self.on_def)
        self.ListenPlayerJoin(self.on_player_join)
        self.ListenChat(self.on_player_message)

    name = "定制-蔚蓝空岛全系统"
    author = "SuperScript"
    version = (0, 0, 1)

    def on_def(self):
        self.chatbar = self.GetPluginAPI("聊天栏菜单")
        self.waitMsg = self.GetPluginAPI("基本插件功能库").waitMsg
        if TYPE_CHECKING:
            from 前置_基本插件功能库 import BasicFunctionLib
            from 前置_聊天栏菜单 import ChatbarMenu

            self.chatbar = self.get_typecheck_plugin_api(ChatbarMenu)
            self.waitMsg = self.get_typecheck_plugin_api(BasicFunctionLib).waitMsg
        self.chatbar.add_trigger(["兑换"], None, "兑换空岛初始物品", self.on_buy)
        self.frame.add_console_cmd_trigger(
            ["rcl"], "[玩家名]", "强制解锁聊天线程", self.unlock_thread
        )

    def on_buy(self, player: str, _):
        self.game_ctrl.say_to(player, "§7====§a资源§e兑换中心§7====")
        if not M_LIST:
            self.game_ctrl.say_to(player, "§6暂无任何兑换物")
            return
        for i, s in enumerate(M_LIST):
            self.game_ctrl.say_to(
                player,
                f" §7[§f{i + 1}§7] {' + '.join(s.need_name)} -> {' + '.join(s.give_name)}",
            )
        self.game_ctrl.say_to(player, "§7输入序号选择兑换选项:")
        r = Utils.try_int(self.waitMsg(player))
        if r is None or r not in range(1, len(M_LIST) + 1):
            self.game_ctrl.say_to(player, "§c错误的序号， 已退出")
            return
        section = M_LIST[r - 1]
        self.game_ctrl.say_to(player, "§7输入兑换的数量:")
        r = Utils.try_int(self.waitMsg(player))
        if r is None or r <= 0:
            self.game_ctrl.say_to(player, "§c错误的输入， 已退出")
            return
        rnd_score = randint(-1000, 1000)
        self.game_ctrl.sendcmd_with_resp(
            f"/scoreboard players set {player} st:cache1 {rnd_score}"
        )
        for material, count in section.need_items.items():
            if (
                game_utils.getItem(f"@a[scores={{st:cache1={rnd_score}}}]", material)
                < count * r
            ):
                self.game_ctrl.say_to(player, "§c物品数量不足")
                return
        rnd_score = randint(-1000, 1000)
        self.game_ctrl.sendcmd_with_resp(
            f"/scoreboard players set {player} st:cache1 {rnd_score}"
        )
        for needing, count in section.need_items.items():
            self.game_ctrl.sendwocmd(
                f"clear @a[scores={{st:cache1={rnd_score}}}] {needing} 0 {count * r}"
            )
        for giving, count in section.give_items.items():
            self.game_ctrl.sendwocmd(
                f"give @a[scores={{st:cache1={rnd_score}}}] {giving} {count * r}"
            )
        self.game_ctrl.say_to(player, f"§a已兑换物品 (x{r})")

    def on_player_message(self, chat: Chat):
        player = chat.player.name
        msg = chat.msg

        if (
            "岩浆" in msg
            and "黑曜石" in msg
            and "变" in msg
            and (
                msg.find("岩浆") < msg.find("变") < msg.find("黑曜石")
                or msg.find("黑曜石") < msg.find("变成") < msg.find("岩浆")
            )
        ) or (
            "点燃" in msg and "黑曜石" in msg and msg.find("点燃") < msg.find("黑曜石")
        ):
            if msg.count("不") % 2:
                self.game_ctrl.say_to(player, "§c神金， 你到底要不要消除黑曜石啊？！")
                self.game_ctrl.say_to(
                    f"@a[name=!{player}]", f"§6{player} §7不知道在发什么电..."
                )
                return
            if not self.game_ctrl.sendcmd_with_resp(
                f"execute as {player} at @s run testforblock ~~-1~ obsidian"
            ).SuccessCount:
                self.game_ctrl.say_to(player, "§c请你在一块黑曜石上站着！")
                self.game_ctrl.say_to(
                    f"@a[name=!{player}]",
                    f"§6{player} §7正在请求格拉默铁骑点燃它的黑曜石， 但是发现自己没有站在黑曜石上..",
                )
            elif game_utils.getItem(player, "bucket") < 1:
                self.game_ctrl.say_to(player, "§c你背包里为什么连一个桶也没有...")
                self.game_ctrl.say_to(
                    f"@a[name=!{player}]",
                    f"§6{player} §7正在请求格拉默铁骑点燃它的黑曜石， 但是背包里没有桶..",
                )
            else:
                self.game_ctrl.sendwocmd(f"/clear {player} bucket 0 1")
                self.game_ctrl.sendwocmd(f"/give {player} lava_bucket 1")
                self.game_ctrl.sendwocmd(
                    f"/execute as {player} at @s run setblock ~~-1~ air"
                )
                self.game_ctrl.say_to(
                    player,
                    "§a已经让铁骑点燃黑曜石了！ 请检查你的背包，里面一定有一个岩浆桶。",
                )
                self.game_ctrl.say_to(
                    f"@a[name=!{player}]",
                    f"§6{player} §7正在请求格拉默铁骑点燃它的黑曜石， 而且成功了！",
                )

    def unlock_thread(self, args: list[str]):
        if len(args) < 1:
            Print.print_err("需要1个参数")
            return
        p = args[0]
        if p in chatbar_lock_list:
            chatbar_lock_list.remove(p)
            Print.print_suc(f"已强制解锁 {p} 的线程锁")

    @Utils.thread_func("检测玩家背包是否充满")
    def on_player_join(self, playerf: Player):
        player = playerf.name
        Print.print_inf(f"正在对玩家 {player} 进行刷物检测..")
        while not game_utils.getTarget(f"@a[name={player}]"):
            sleep(0.2)
        if player in game_utils.getTarget("@a[tag=bag.full,m=!1]"):
            self.game_ctrl.say_to("@a", f"§c玩家 §6{player} §c疑似进行刷物， 已踢出")
            self.game_ctrl.sendwocmd(
                f'/kick @a[name="{player}"] §c您似乎正在进行刷物\n§b申诉请加入 223216881 蔚蓝空域®交流群'
            )
        if "星星吃主人" in player:
            self.game_ctrl.sendwocmd(f"kick {player} §c违规游戏")
        Print.print_inf(f"对玩家 {player} 进行刷物检测结束.")
        if player[0] in "1234567890":
            self.game_ctrl.sendwocmd(
                f'/kick "{player}" 您的昵称不适合插件执行指令， 无法游玩'
            )


entry = plugin_entry(SkyblueSkyblock)
