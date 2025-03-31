import os
import json
import random
from tooldelta import (
    Plugin,
    TYPE_CHECKING,
    game_utils,
    utils,
    plugin_entry,
    InternalBroadcast,
)

from tooldelta.internal.launch_cli.neo_libs.neo_conn import CommandBlockPlaceOption


class SkyblockShop(Plugin):
    name = "空岛商店"
    author = "SuperScript"
    version = (0, 0, 1)

    def __init__(self, frame):
        super().__init__(frame)
        self.make_data_path()
        os.makedirs(os.path.join(self.data_path, "商店信息"), exist_ok=True)
        os.makedirs(os.path.join(self.data_path, "玩家信息"), exist_ok=True)
        self.ListenPreload(self.on_def)
        self.ListenActive(self.on_inject)
        self.ListenInternalBroadcast("群服互通/链接群消息", self.data_recv)

    def on_def(self):
        self.skyblock = self.GetPluginAPI("空岛系统")
        self.chatbar = self.GetPluginAPI("聊天栏菜单")
        self.cb2bot = self.GetPluginAPI("Cb2Bot通信")
        self.qlink = self.GetPluginAPI("群服互通", (0, 0, 1), False)
        if TYPE_CHECKING:
            from 空岛系统 import SkyBlock
            from 前置_聊天栏菜单 import ChatbarMenu
            from 前置_Cb2Bot通信 import TellrawCb2Bot

            self.skyblock = self.get_typecheck_plugin_api(SkyBlock)
            self.chatbar = self.get_typecheck_plugin_api(ChatbarMenu)
            self.cb2bot = self.get_typecheck_plugin_api(TellrawCb2Bot)
        self.cb2bot.regist_message_cb("shop.buy", self.on_buy_by_cb)
        self.cb2bot.regist_message_cb("shop.onstaff", self.on_onstaff_by_cb)
        self.cb2bot.regist_message_cb("shop.offstaff", self.on_offstaff_by_cb)

    def on_inject(self):
        self.chatbar.add_trigger([".shop"], None, "查看空岛商店帮助", self.on_menu)

    def get_player_path(self, name: str):
        return os.path.join(self.data_path, "玩家信息", name + ".json")

    def get_shop_path(self, name: str):
        return os.path.join(self.data_path, "商店信息", name + ".json")

    def on_menu(self, player: str, args: list[str]):
        if args == []:
            helps = [
                ".shop new §7§o创建一个空岛商店",
                ".shop leave §7§o离开当前空岛商店",
                ".shop on §7§o上架商品并绑定靶子",
                ".shop off §7§o下架一个商品并解绑靶子",
                ".shop cbin §7§o设置一个商品绑定命令方块",
                ".shop cbout §7§o删除一个商品绑定命令方块",
                ".shop take §7§o提取余额",
            ]
            self.game_ctrl.say_to(player, "\n§r".join(helps))
        elif args[0] == "new":
            self.on_create_shop(player)
        elif args[0] == "on":
            self.on_upload_good(player)
        elif args[0] == "cbin":
            self.on_place_cb_buy(player)
        elif args[0] == "cbout":
            self.on_remove_cb_buy(player)
        elif args[0] == "off":
            self.on_remove_good(player)
        elif args[0] == "take":
            self.on_take(player)
        else:
            self.game_ctrl.say_to(player, "§c无效命令， 输入 .shop 获取帮助")

    def get_shop_data(self, shop_name):
        return utils.tempjson.load_and_read(self.get_shop_path(shop_name), False)

    def get_player_data(self, player):
        return utils.tempjson.load_and_read(self.get_player_path(player), False)

    def set_player_data(self, player, dat):
        utils.tempjson.load_and_write(self.get_player_path(player), dat, False)

    def set_shop_data(self, shop, dat):
        utils.tempjson.load_and_write(self.get_shop_path(shop), dat, False)

    def on_place_cb_buy(self, player: str):
        gc = self.game_ctrl
        player_poss = game_utils.getPosXYZ(player)
        if not game_utils.isCmdSuccess(
            f"execute as {player} at @s run testforblock ~~-1~ target"
        ):
            gc.say_to(player, "§c需要站在靶子方块上才可绑定")
            return
        pdata = self.get_player_data(player)
        if pdata is None:
            gc.say_to(player, "§c你还没有创建一个商店")
            return
        sdata = self.get_shop_data(pdata["OwnShop"])
        if sdata is None:
            gc.say_to(player, "§c商店ID搜索错误")
            return
        if len(sdata["CBs"]) >= sdata["CBLimit"]:
            gc.say_to(player, "§c命令方块放置数达上限")
            return
        x, y, z = player_poss
        if sdata["Slots"] == []:
            gc.say_to(player, "§c你还还没有任何一件已上架商品供绑定")
            return
        gc.say_to(player, "§6请选择一个商品以设置命令方块：")
        for i, slot in enumerate(sdata["Slots"]):
            gc.say_to(player, f" §7[§f{i + 1}§7] {slot['Name']}")
        gc.say_to(player, "§6输入序号以选择：")
        resp = utils.try_int(game_utils.waitMsg(player))
        if resp is None or resp - 1 not in range(len(sdata["Slots"])):
            gc.say_to(player, "§c输入不在范围内")
            return
        slot_select = sdata["Slots"][resp - 1]
        good_name = slot_select["Name"]
        pos_str = f"{int(x)} {int(y)} {int(z)}"
        gc.say_to(player, "§6请选择命令方块的类型：")
        gc.say_to(player, "  1.出售命令方块 §7触发后使最近的玩家购买该商品")
        gc.say_to(player, "  2.补货命令方块 §7触发后设置该商品状态为§a有货")
        gc.say_to(player, "  3.售空命令方块 §7触发后设置该商品状态为§c售空")
        gc.say_to(player, "  其他 §7退出菜单")
        match game_utils.waitMsg(player):
            case "1":
                buydata = json.dumps(
                    {
                        "rawtext": [
                            {"text": "shop.buy"},
                            {"selector": "@p[r=5]"},
                            {"text": pdata["OwnShop"]},
                            {"text": good_name},
                        ]
                    },
                    ensure_ascii=False,
                )
                cmd = f"tellraw @a[tag=robot] {buydata}"
            case "2":
                buydata = json.dumps(
                    {
                        "rawtext": [
                            {"text": "shop.onstaff"},
                            {"text": pdata["OwnShop"]},
                            {"text": good_name},
                        ]
                    },
                    ensure_ascii=False,
                )
                cmd = f"tellraw @a[tag=robot] {buydata}"
            case "3":
                buydata = json.dumps(
                    {
                        "rawtext": [
                            {"text": "shop.offstaff"},
                            {"text": pdata["OwnShop"]},
                            {"text": good_name},
                        ]
                    },
                    ensure_ascii=False,
                )
                cmd = f"tellraw @a[tag=robot] {buydata}"
            case _:
                gc.say_to(player, "6已退出.")
                return
        self.frame.launcher.omega.place_command_block(
            CommandBlockPlaceOption(
                int(x), int(y - 1), int(z), NeedRedStone=True, Command=cmd
            )
        )
        sdata["CBs"].append(pos_str)
        self.set_shop_data(pdata["OwnShop"], sdata)
        gc.say_to(player, "§a命令方块设置完成")
        self.game_ctrl.sendcmd("tp 123456 200 123456")

    def on_remove_cb_buy(self, player: str):
        gc = self.game_ctrl
        player_poss = game_utils.getPosXYZ(player)
        pdata = self.get_player_data(player)
        if pdata is None:
            gc.say_to(player, "§c你还没有创建一个商店")
            return
        sdata = self.get_shop_data(pdata["OwnShop"])
        if sdata is None:
            gc.say_to(player, "§c商店ID搜索错误")
            return
        x, y, z = player_poss
        pos_str = f"{int(x)} {int(y)} {int(z)}"
        if pos_str not in sdata["CBs"]:
            gc.say_to(player, "§c你未在此绑定过命令方块")
            return
        self.game_ctrl.sendwocmd(f"/setblock {int(x)} {int(y - 1)} {int(z)} target")
        sdata["CBs"].remove(pos_str)
        self.set_shop_data(pdata["OwnShop"], sdata)
        gc.say_to(player, "§a命令方块解绑完成")

    def on_take(self, player: str):
        gc = self.game_ctrl
        pdata = self.get_player_data(player)
        if pdata is None:
            gc.say_to(player, "§c你还没有创建一个商店")
            return
        sdata = self.get_shop_data(pdata["OwnShop"])
        if sdata is None:
            gc.say_to(player, "§c商店ID搜索错误")
            return
        profit = sdata["Profit"]
        if profit > 0:
            self.game_ctrl.say_to(player, f"§a已取走收益： §e{profit}金币")
            self.game_ctrl.sendwocmd(
                f"scoreboard players add @a[name={player}] money {profit}"
            )
            self.set_shop_data(pdata["OwnShop"], sdata)
            sdata["Profit"] = 0
        else:
            self.game_ctrl.say_to(player, "§6暂未获得任何收益")

    def on_upload_good(self, player: str):
        gc = self.game_ctrl
        x, y, z = game_utils.getPosXYZ(player)
        pdata = self.get_player_data(player)
        if pdata is None:
            gc.say_to(player, "§c你还没有创建一个商店")
            return
        sdata = self.get_shop_data(pdata["OwnShop"])
        if sdata is None:
            gc.say_to(player, "§c商店ID搜索错误")
            return
        if not game_utils.isCmdSuccess(
            f"execute as {player} at @s run testforblock ~~-1~ target"
        ):
            gc.say_to(player, "§c需要站在靶子方块上才可绑定")
            return
        if len(sdata["Slots"]) >= sdata["MaxSlots"]:
            gc.say_to(player, "商店槽位已满")
            return
        gc.say_to(player, "§6请输入该商品的§e显示名§6：")
        while 1:
            show_name = game_utils.waitMsg(player)
            if show_name is None:
                gc.say_to(player, "§c输入超时， 已退出")
                return
            if show_name == "***":
                gc.say_to(player, "§c检测到输入了敏感词， 请重新输入")
            else:
                break
        gc.say_to(player, "§6请输入该商品的§e价格§6：")
        price1 = 1
        while 1:
            price = game_utils.waitMsg(player)
            if price is None:
                gc.say_to(player, "§c输入超时， 已退出")
                return
            price = utils.try_int(price)
            if price is None or price not in range(1, 9999999):
                gc.say_to(player, "§c价格不正确， 请重新输入")
            else:
                price1 = price
                break
        sdata["Slots"].append(self.make_bounding_data(show_name, [x, y, z], price1))
        self.set_shop_data(pdata["OwnShop"], sdata)
        gc.say_to(player, "§a商品已上架！")

    def on_remove_good(self, player: str):
        gc = self.game_ctrl
        pdata = self.get_player_data(player)
        if pdata is None:
            gc.say_to(player, "§c你还没有创建一个商店")
            return
        sdata = self.get_shop_data(pdata["OwnShop"])
        if sdata is None:
            gc.say_to(player, "§c商店ID搜索错误")
            return
        gc.say_to(player, "§6请选择一个商品以下架：")
        for i, slot in enumerate(sdata["Slots"]):
            gc.say_to(player, f" §7[§f{i + 1}§7] {slot['Name']}")
        gc.say_to(player, "§6输入序号以选择：")
        resp = utils.try_int(game_utils.waitMsg(player))
        if resp is None or resp - 1 not in range(len(sdata["Slots"])):
            gc.say_to(player, "§c输入不在范围内")
            return
        slot_select = sdata["Slots"][resp - 1]
        sdata["Slots"].remove(slot_select)
        self.set_shop_data(pdata["OwnShop"], sdata)
        gc.say_to(player, "§a已下架商品")

    def on_buy_by_cb(self, cb_datas_seq):
        who_buy, shop_name, buy_what = cb_datas_seq
        curr_money = game_utils.getScore("money", who_buy)
        shop_dat = self.get_shop_data(shop_name)
        if shop_dat is None:
            self.game_ctrl.say_to(who_buy, "§c商店已不存在")
            return
        for slot in shop_dat["Slots"]:
            if slot["Name"] == buy_what:
                slot_select = slot
                break
        else:
            self.game_ctrl.say_to(who_buy, "§c商品不存在或已下架")
            return
        if slot_select["Status"] != 1:
            self.game_ctrl.say_to(who_buy, "§c商品已售空")
            return
        price = slot_select["Price"]
        if price > curr_money:
            self.game_ctrl.say_to(who_buy, f"§6余额不足 §f({curr_money}§f/§e{price}§f)")
            return
        if not self.game_ctrl.sendcmd_with_resp(
            f"scoreboard players remove @a[name={who_buy}] money {price}"
        ):
            self.game_ctrl.say_to(who_buy, "§c扣除金币失败， 无法购买， 请联系管理员")
            return
        shop_dat["Profit"] += round(price * 0.98)
        self.game_ctrl.player_actionbar(
            who_buy,
            f"§a购买§f{slot_select['Name']}§r§a成功， 请等待商品响应\n§a余额： §e{curr_money - price}金币 §a(价格： §e{price}金币§a)",
        )
        x, y, z = slot_select["Pos"]
        self.game_ctrl.sendwocmd(
            f"execute as {who_buy} at @s run playsound random.levelup @s"
        )
        if shop_dat["Owner"] in self.game_ctrl.allplayers:
            self.game_ctrl.say_to(
                shop_dat["Owner"],
                f"§a• §e{who_buy} §a刚刚买走了你的一个 §f{slot_select['Name']}",
            )
        self.set_shop_data(shop_name, shop_dat)
        self.game_ctrl.sendwocmd(f"summon snowball {int(x)} {int(y)} {int(z)}")

    def on_onstaff_by_cb(self, cb_datas_seq):
        shop_name, good_name = cb_datas_seq
        if (shop_dat := self.get_shop_data(shop_name)) is None:
            self.game_ctrl.say_to("@a", f"§c自动补货：商店 {shop_name} 已不存在")
            return
        for slot in shop_dat["Slots"]:
            if slot["Name"] == good_name:
                break
        else:
            self.game_ctrl.say_to("@a", f"§c自动补货： 商品 {good_name} 不存在")
            return
        for slot in shop_dat["Slots"]:
            if slot["Name"] == good_name:
                slot["Status"] = 1
                self.game_ctrl.say_to(
                    "@a", f"§6商店 §e{shop_name} §6的 §f{good_name} §6已§a补货"
                )
        self.set_shop_data(shop_name, shop_dat)

    def on_offstaff_by_cb(self, cb_datas_seq):
        shop_name, good_name = cb_datas_seq
        if (shop_dat := self.get_shop_data(shop_name)) is None:
            self.game_ctrl.say_to("@a", f"§c自动售空： 商店 {shop_name} 已不存在")
            return
        for slot in shop_dat["Slots"]:
            if slot["Name"] == good_name:
                break
        else:
            self.game_ctrl.say_to("@a", f"§c自动补货： 商品 {good_name} 不存在")
            return
        for slot in shop_dat["Slots"]:
            if slot["Name"] == good_name:
                slot["Status"] = 0
                self.game_ctrl.say_to(
                    "@a", f"§6商店 §e{shop_name} §6的 §f{good_name} §6已§c售空"
                )
        self.set_shop_data(shop_name, shop_dat)

    def on_create_shop(self, player: str):
        gc = self.game_ctrl
        island_uid = self.skyblock.get_player_island_uid(player)
        f = self.get_player_data(player)
        if f is not None:
            gc.say_to(player, "§c你已经拥有了一个空岛商店")
            return
        rnd = random.randint(65, 130)
        self.game_ctrl.sendcmd_with_resp(
            f"scoreboard players set {player} st:cache1 {rnd}"
        )
        if game_utils.getItem(f"@a[scores={{st:cache1={rnd}}}]", "paper", 618) < 1:
            gc.say_to(player, "§c创建商店需要商店券")
            return
        self.game_ctrl.sendwocmd("scoreboard players reset * st:cache1")
        if island_uid is None:
            gc.say_to(player, "§c你还没有创建一个空岛， 无法创建商店")
        gc.say_to(player, "§6请输入你的§a商店名字§6:")
        while 1:
            shop_name = game_utils.waitMsg(player, 60)
            if shop_name is None:
                gc.say_to(player, "§c输入超时， 已退出")
                return
            if not shop_name.encode("utf-8").isalpha():
                gc.say_to(player, "§c商店名暂时只能是纯英文， 请重新输入：")
            elif self.get_shop_data(shop_name) is not None:
                gc.say_to(player, "§c已有同名商店， 请重新输入：")
            else:
                break
        x, y, z = game_utils.getPosXYZ(player)
        pos = None
        self.set_shop_data(shop_name, self.init_shop(player, shop_name, pos))
        self.set_player_data(player, self.init_player(player, shop_name))
        gc.sendwocmd(f"clear {player} paper 618 1")
        gc.say_to(player, "§a已经创建商店！")

    def data_recv(self, data: InternalBroadcast):
        msg = data.data["消息"]
        if msg.startswith("商店查询"):
            msgs = msg.split()
            if len(msgs) == 2:
                sname = msgs[1]
                result = self.get_shop_data(sname)
                if result is None:
                    result1 = self.get_player_data(sname)
                    if result1 is None:
                        self.qlink.sendmsg(
                            self.qlink.linked_group, "商店名或店主名不存在"
                        )
                        return True
                    else:
                        result = self.get_shop_data(result1["OwnShop"])
                msg_seq = [
                    f"{result['Owner']} 的空岛商店信息：",
                    f" ★ 店主： {result['Owner']}",
                    " ▣ 商品：\n"
                    + "\n".join(
                        f" - {i['Name']}  {i['Price']}金币" for i in result["Slots"]
                    ),
                    f" ▨ 商品数： {len(result['Slots'])}/{result['MaxSlots']}   ▧ 命令方块数： {len(result['CBs'])}/{result['CBLimit']}",
                ]
                self.qlink.sendmsg(self.qlink.linked_group, "\n".join(msg_seq))
            return True
        return False

    def init_shop(self, player: str, name: str, pos):
        return {
            "Name": name,
            "Owner": player,
            "Description": "",
            "MaxSlots": 10,
            "Slots": [],
            "Pos": pos,
            "Profit": 0,
            "CBLimit": 20,
            "CBs": [],
        }

    def init_player(self, player: str, own_shop: str):
        return {"OwnShop": own_shop}

    def make_bounding_data(self, name: str, pos: list[float], price: int):
        return {"Name": name, "Pos": pos, "Price": price, "Status": 0}


entry = plugin_entry(SkyblockShop, "空岛商店")
