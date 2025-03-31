from tooldelta import Plugin, TYPE_CHECKING, plugin_entry

MACHINE_NAMES = [
    "§6未搭建完成",
    "太阳能电池板",
    "打粉机",
    "电炉",
    "熔炼炉",
    "伐木机",
    "火力发电机",
    "种植站",
    "虚空采矿机",
    "压缩机",
    "地热发电机",
    "电力挖石机",
    "感应炉",
    "自动矿筛",
    "电炉",
    "分子重组机",
    "自动动物农场",
]
MACHINE_TYPE = [0, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1]
GENERATOR_TICKS = {1: 1000, 10: 400, 6: 10}


class SkyblueTechMaster(Plugin):
    def __init__(self, frame):
        super().__init__(frame)
        self.ListenPreload(self.on_def)

    name = "蔚蓝科技-SkyblueTech"
    author = "SuperScript"
    version = (0, 0, 1)

    def on_def(self):
        self.last_req_time = 0
        cb2bot = self.GetPluginAPI("Cb2Bot通信")
        self.jei = self.GetPluginAPI("jei")
        if TYPE_CHECKING:
            from 前置_Cb2Bot通信 import TellrawCb2Bot
            from JEI物品查询器 import JEIItemSearcher

            cb2bot = self.get_typecheck_plugin_api(TellrawCb2Bot)
            self.jei = self.get_typecheck_plugin_api(JEIItemSearcher)
        cb2bot.regist_message_cb("st.msg", self.msg_checker)
        cb2bot.regist_message_cb("st.dc_msg", self.battery_msg_checker)
        self.add_recipes()

    def add_recipes(self):
        jei = self.jei
        add_recipe = jei.add_recipe
        add_description = jei.add_description
        getitem = jei.get_item_by_name
        item = jei.JEI_item
        Recipe = jei.JEI_recipe
        Machine = jei.JEI_crafter
        Description = jei.JEI_description

        def _gyl_cb(_i, _o):
            return (
                "§4上层左侧："
                + (f"§f{_i[0].item.name}§7x{_i[0].count}" if _i[0] else "空")
                + "  §4右侧："
                + (f"§f{_i[1].item.name}§7x{_i[1].count}" if _i[1] else "空")
                + "\n§c中层："
                f"§f{_i[2].item.name}§7x{_i[2].count}"
                "\n产出："
                f"§b{_o[0].item.name}§7x{_o[0].count}"
            )

        def _dfj_cb(_i, _o):
            return (
                f"§f{_i[0].item.name}§7x{_i[0].count}"
                " =۞=> "
                f"§b{_o[0].item.name}§7x{_o[0].count}"
            )

        def _rll_cb(_i, _o):
            return (
                f"§f{_i[0].item.name}§7x{_i[0].count}"
                " =۞=> "
                f"§b{_o[0].item.name}§7x{_o[0].count}"
            )

        def _sz_cb(_i, _o):
            return f"{_i[0].item.name} §7--§f░§7--> \n" + "\n".join(
                f"§7 - §b{o.item.name} §7(概率)" for o in _o
            )

        def _dwnc_cb(_i, _o):
            return (
                f"§7(§a{_i[0].item.name}§7) §f{_i[1].item.name} -> §b{_o[0].item.name}"
                + "§7， "
                + "，§b ".join(f"§b{o.item.name} §7(概率)" for o in _o[1:])
            )

        gyl = Machine("感应炉", _gyl_cb)
        dfj = Machine("打粉机", _dfj_cb)
        rll = Machine("熔炼炉", _rll_cb)
        sz = Machine("筛子", _sz_cb)
        dwnc = Machine("自动动物农场", _dwnc_cb)
        for midd, top1, top2, getting, count in (
            ("铁锭", None, "碳粉", "钢锭", 1),
            ("锡锭", "铜锭", "铜锭", "青铜锭", 3),
            ("钢锭", None, "镍锭", "殷钢锭", 2),
            ("铜锭", None, "镍锭", "康铜锭", 2),
            ("金锭", None, "银锭", "琥珀金锭", 2),
            ("琥珀金锭", None, "末影晶体", "谐振合金", 1),
        ):
            add_recipe(
                Recipe(
                    gyl,
                    [
                        getitem(top1, 1) if top1 else None,
                        getitem(top2, 1),
                        getitem(midd, 1),
                    ],
                    [
                        getitem(getting, count),
                    ],
                )
            )
        for into, outcom, count in (
            ("羊毛", "线", 3),
            ("干草块", "青饲料", 2),
            ("木炭", "碳粉", 1),
            ("煤炭", "碳粉", 1),
            ("圆石", "砂砾", 1),
            ("砂砾", "沙子", 1),
            ("铁锭", "铁粉", 1),
            ("铜锭", "铜粉", 1),
            ("金锭", "金粉", 1),
            ("锡锭", "锡粉", 1),
            ("铅锭", "铅粉", 1),
            ("银锭", "银粉", 1),
            ("钴锭", "钴粉", 1),
            ("镍锭", "镍粉", 1),
            ("粗铜", "铜粉", 2),
            ("粗金", "金粉", 2),
            ("粗铁", "铁粉", 2),
        ):
            add_recipe(
                Recipe(
                    dfj,
                    [getitem(into, 1)],
                    [getitem(outcom, count)],
                )
            )
        for into, outcom in (
            ("铁粉", "铁锭"),
            ("铜粉", "铜锭"),
            ("金粉", "金锭"),
            ("锡粉", "锡锭"),
            ("铅粉", "铅锭"),
            ("银粉", "银锭"),
            ("钴粉", "钴锭"),
            ("镍粉", "镍锭"),
        ):
            add_recipe(
                Recipe(
                    rll,
                    [getitem(into, 1)],
                    [getitem(outcom, 1)],
                )
            )
        for into, outcom in (
            ("鸡", ("生鸡肉", "羽毛")),
            ("猪", ("生猪肉",)),
            ("牛", ("生牛肉", "皮革")),
            ("羊", ("生羊肉", "羊毛")),
        ):
            add_recipe(
                Recipe(
                    dwnc,
                    [getitem("青饲料", 1)] + [getitem(i, 1) for i in into],
                    [getitem(i, 1) for i in outcom],
                )
            )
        add_recipe(
            Recipe(
                sz,
                [getitem("砂砾", 1)],
                [
                    getitem(i, 1)
                    for i in (
                        "钻石",
                        "绿宝石",
                        "红石",
                        "青金石",
                        "粗铁",
                        "粗铜",
                        "粗金",
                        "煤炭",
                        "锡粉",
                        "铅粉",
                        "银粉",
                        "镍粉",
                    )
                ],
            )
        )
        add_recipe(
            Recipe(
                sz,
                [getitem("泥巴", 1)],
                [
                    getitem(i, 1)
                    for i in (
                        "小麦种子",
                        "马铃薯",
                        "胡萝卜",
                        "甜浆果",
                        "甜菜种子",
                        "南瓜种子",
                        "西瓜种子",
                        "黏土",
                    )
                ],
            )
        )
        add_recipe(
            Recipe(
                sz,
                [getitem("灵魂沙", 1)],
                [getitem(i, 1) for i in ("诡异真菌", "地狱疣", "绯红菌", "绯红菌岩")],
            )
        )
        add_recipe(
            Recipe(
                sz,
                [getitem("沙子", 1)],
                [getitem(i, 1) for i in ("萤石粉", "海带", "石英")],
            )
        )
        add_recipe(
            Recipe(
                sz,
                [getitem("沙子", 1)],
                [getitem(i, 1) for i in ("萤石粉", "海带", "石英")],
            )
        )
        add_description(
            jei.JEI_description(
                item("SuperScript"),
                "空域正常运行的维护者， 擅长世界功能制作。\n偶尔会出现在一些空岛上。\n曾经把朋克星的§d银狼§f用苏乐达灌倒后拖进空域。\n喜欢被投喂殷钢锭。",
            )
        )
        add_description(
            Description(
                item("银狼"),
                "朋克星上生活的少女， 擅长数据篡改。\n因被用苏乐达灌倒而被毫不知情地拖入空域世界。\n可能会时不时投放一些小奖励。",
            )
        )
        add_description(
            Description(
                item("蔚蓝科技 - RF"),
                "又称红石通量， 是蔚蓝科技的§c能源单位§f。\n通过§c发电机发电§f获得。\n各种机器的运转都需要提供能量。",
            )
        )
        add_description(
            Description(
                item("蔚蓝科技 - 发电机"), "可用于产生RF能源， 维持各种电力机器的运转。"
            )
        )
        add_description(
            Description(
                item("蔚蓝科技 - 电池"),
                "可用于存储RF能源和充当发电机到电力机器的中转站。",
            )
        )
        add_description(
            Description(
                item("蔚蓝科技 - 电力机器"),
                "可以消耗RF能源来制作/处理物品和提供各式各样的功能， 非常强大。\n你可以用这些机器制作一条自动化线路。",
            )
        )
        add_description(
            Description(
                item("蔚蓝科技 - 特殊矿物"),
                "包括锡锭、铅锭等新增的各式各样的矿粉和锭， 是制作科技元件的必要材料。",
            )
        )
        add_description(
            Description(
                item("蔚蓝科技 - 科技元件"),
                "需要将元件放入机器以激活电力机器功能。",
            )
        )
        add_description(
            Description(item("泥巴"), "站在水里， 脚踩泥土方块， 会把泥土转化为泥巴")
        )

    def msgs_parse(self, msgs: list[str]):
        show_to = msgs[0]
        machine_id = int(msgs[1])
        result: dict[str, int] = {}
        kvd = ""
        for i in msgs[2:]:
            if i.endswith(":"):
                kvd = i
            elif i.isnumeric():
                result[kvd] = int(i)
        return show_to, machine_id, result

    def msg_checker(self, msgs: list[str]):
        show_to, machine_id, kws = self.msgs_parse(msgs)
        mech_name = MACHINE_NAMES[machine_id]
        is_generator = MACHINE_TYPE[machine_id] - 1
        if not is_generator:
            storage_rf = kws.get("rf:", 0)
            total_rf = kws.get("srf:", 1)
            power = kws.get("mcp:", 0)
            now_tick = kws.get("mctick:", 0)
            sum_ticks = kws.get("mcstick:", 1)
            prg_bar_1 = self.make_progress_bar(
                30, "f", "8", min(now_tick, sum_ticks), sum_ticks
            )
            prg_bar_2 = self.make_progress_bar(
                30, "c", "4", min(storage_rf, total_rf), total_rf
            )
            energy_d = kws.get("energyd:", 100)
            speed_d = kws.get("speedup:", 1)
            data1 = kws.get("data1:", 0)
            data2 = kws.get("data2:", 0)
            match machine_id:
                case 11:
                    prg_bar_3 = self.make_progress_bar(
                        30, "e", "6", min(data1, 1561), 1561
                    )
                    extra_msgs = f"§s  ▣耐久 {prg_bar_3} {data1}\n"
                case _:
                    extra_msgs = ""
            formatter = (
                f"[§a{machine_id}§f] {mech_name}\n"
                f"§b  ▶功率 §a{power} RF/T\n"
                f"§e  §l⚡§e储电§r {prg_bar_2} §c{min(storage_rf, total_rf)}/{total_rf} RF\n"
                f"§a  ▦进度 {prg_bar_1}\n"
                + extra_msgs
                + f"§d  速度升级 §a{speed_d}%  §d能耗 §a{energy_d}%\n"
                + "§9Skyblue Tech SkyBlock"
            )
            self.game_ctrl.player_actionbar(show_to, formatter)
        else:
            gen_power = kws.get("genrfp:", 0)
            now_tick = kws.get("gen_tick:", 0)
            sum_ticks = GENERATOR_TICKS[machine_id]
            progress_1 = round(30 * now_tick / sum_ticks)
            prg_bar_1 = "§e" + "|" * progress_1 + "§c" + "|" * (30 - progress_1)
            formatter = (
                f"[§a{msgs[1]}§f] {mech_name}\n"
                f"§e  ⚡功率 §a{gen_power} RF/T\n"
                f"§c  ☀燃料 {prg_bar_1}\n"
                "§9Skyblue Tech SkyBlock"
            )
            self.game_ctrl.player_actionbar(show_to, formatter)

    def battery_msg_checker(self, msgs: list[str]):
        if len(msgs) != 4:
            return
        player, _, power, power_up = msgs
        power = int(power)
        power_up = int(power_up)
        prg = round(min(30 * power / power_up, 30))
        prg_bar = "§c" + "|" * prg + "§4" + "|" * (30 - prg)
        self.game_ctrl.player_actionbar(
            player,
            f"§7[§e⚡§7] §f储电盒\n§f§l电量§r {prg_bar} §c{power}/{power_up}RF",
        )

    def make_progress_bar(
        self, length: int, color1: str, color2: str, curr, tota
    ) -> str:
        now_prgs = round(curr / tota * length)
        return "§" + color1 + "|" * now_prgs + "§" + color2 + "|" * (30 - now_prgs)


entry = plugin_entry(SkyblueTechMaster)
