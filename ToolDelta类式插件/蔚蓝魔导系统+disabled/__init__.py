from tooldelta import Plugin, TYPE_CHECKING, plugin_entry


class SkyblueTechMaster(Plugin):
    def __init__(self, frame):
        super().__init__(frame)
        self.ListenPreload(self.on_def)

    name = "蔚蓝科技-SkyblueTech"
    author = "SuperScript"
    version = (0, 0, 1)

    def on_def(self):
        self.jei = self.GetPluginAPI("jei")
        if TYPE_CHECKING:
            from JEI物品查询器 import JEIItemSearcher

            self.jei = self.get_typecheck_plugin_api(JEIItemSearcher)
        self.add_recipes()

    def add_recipes(self):
        jei = self.jei
        add_recipe = jei.add_recipe
        add_description = jei.add_description
        getitem = jei.get_item_by_name
        Recipe = jei.JEI_recipe
        Machine = jei.JEI_crafter
        Description = jei.JEI_description

        def _zmt_cb(_i, _o):
            if len(_i) > 1:
                return (
                    _i[0].item.name
                    + f" §l§b——♤◑——§d[§e{_i[1].count}§d魔力]§l§b——> §r§d"
                    + _o[0].item.name
                )
            else:
                return _i[0].item.name + f" §l§b——♤◑——> §r§d{_o[0].count}魔力"

        zmt = Machine("储能魔台", _zmt_cb)
        for i, c, o in (
            ("燧石", 50, "打火石核心"),
            ("红石块", 150, "祭坛红石"),
            ("铁镐", 100, "魔法铁镐"),
            ("紫水晶母岩", 200, "校频魔导水晶"),
            ("地狱岩", 5000, "烈焰粉"),
            ("紫水晶", 50, "魔力"),
        ):
            if o != "魔力":
                add_recipe(
                    Recipe(zmt, [getitem(i, 1), getitem("魔力", c)], [getitem(o, 1)])
                )
            else:
                add_recipe(Recipe(zmt, [getitem(i, 1)], [getitem("魔力", c)]))
        add_description(
            Description(
                getitem("望远镜", 1).item,
                "用于查看储能魔台剩余魔力，需要在储能魔台附近10格内使用",
            )
        )
        add_description(
            Description(
                getitem("刷子", 1).item,
                "用于开启(手持向上拉动视角)或关闭(手持向下拉动视角)魔力散逸模式(详情概念请看魔导书)与制作人偶",
            )
        )
        add_description(
            Description(
                getitem("魔力", 1).item,
                "魔法支线中的重要能源，主要用于驱动魔法台与合成魔力特殊物品，手持紫水晶站在储能魔台五格以内可消耗紫水晶为其充能，1水晶=50魔力",
            )
        )
        add_description(
            Description(
                getitem("人偶", 1).item,
                "用刷子长按已经放置过的盔甲架获得，破坏后需要重复以上步骤获得",
            )
        )
        add_description(
            Description(
                getitem("烈焰魔台", 1).item,
                "攻击型魔台-可攻击周围亡灵生物\n*为什么不去主城的教程区看看呢",
            )
        )
        add_description(
            Description(
                getitem("红石祭坛", 1).item,
                "传送型魔台-可以传送玩家/召唤生物\n*为什么不去主城的教程区看看呢",
            )
        )
        add_description(
            Description(
                getitem("魔力导入器", 1).item,
                "功能型魔台-用于将魔力转入自身储存\n*为什么不去主城的教程区看看呢",
            )
        )
        add_description(
            Description(
                getitem("献祭台", 1).item,
                "功能型魔台-可以改变玩家魔力散逸时的主动技能/被动技能，手持献祭过后，同样的物品可以触发主动技能",
            )
        )
        add_description(
            Description(
                getitem("储能魔台", 1).item,
                "功能型魔台-用于储存物魔力和合成物品",
            )
        )
        add_description(
            Description(
                getitem("炼金锅", 1).item,
                "功能型魔台-用于提炼或改变物品",
            )
        )

        def _ljg_cb(_i, _o):
            # 根据传入内容返回显示内容的函数
            return f"{_i[0].item.name} §c--§l¤§r§c-->\n " + "\n ".join(
                f"§7- §f{i.item.name} §7({i.count}%%)" for i in _o
            )

        ljg = Machine("炼金锅", _ljg_cb)
        add_recipe(
            Recipe(
                ljg,
                [getitem("紫水晶块", 1)],
                [
                    getitem("紫水晶碎片", 75),
                    getitem("粘液球", 10),
                    getitem("垂根", 10),
                    getitem("青蛙卵", 5),
                ],
            )
        )
        add_recipe(
            Recipe(
                ljg,
                [getitem("泥巴", 1)],
                [
                    getitem("兰花", 6),
                    getitem("绒球葱", 6),
                    getitem("蒲公英", 6),
                    getitem("虞美人", 6),
                    getitem("粉红色花瓣", 6),
                    getitem("橙色郁金香", 6),
                    getitem("白色郁金香", 6),
                    getitem("红色郁金香", 6),
                    getitem("凋零玫瑰", 6),
                    getitem("滨菊", 6),
                    getitem("矢车菊", 6),
                    getitem("铃兰", 6),
                    getitem("发光墨囊", 6),
                    getitem("丁香", 2),
                    getitem("玫瑰丛", 2),
                    getitem("向日葵", 2),
                    getitem("牡丹", 2),
                    getitem("可可豆", 2),
                ],
            )
        )
        add_recipe(
            Recipe(
                ljg,
                [getitem("蘑菇煲", 1)],
                [
                    getitem("抗火神秘炖菜", 25),
                    getitem("生命回复神秘炖菜炖菜", 25),
                    getitem("凋零神秘炖菜", 25),
                    getitem("中毒神秘炖菜", 25),
                ],
            )
        )


entry = plugin_entry(SkyblueTechMaster)
