import bdx_work_shop, re, os, json

class MCCmd2Bdx:
    """# MCCmd To Bdx
    Author: SuperScript
    Use Package: bdx_work_shop by 2401PT
    """

    class CmdArrays:
        def __init__(self, arr = None):
            if arr:
                self.array = arr
            else:
                self.array: list = []

        def append(self, cmd: str, cb_mode = bdx_work_shop.canvas.Canvas.MODE_CHAIN_CB, delay = 0, conditional = False, needRedstone = False):
            self.array.append([cmd, cb_mode, delay, conditional, needRedstone])

        def to_fmt_array(self):
            return [{
                'cb_mode': cb_mode,
                'cb_name': '',
                'command': cmd,
                'tick_delay': delay,
                'conditional': conditional,
                'needRedstone': needRedstone
            } for cmd, cb_mode, delay, conditional, needRedstone in self.array
            ]

    def __init__(self):
        "初始化画布与笔刷， 移动到初始位置"
        self.canvas = bdx_work_shop.canvas.Canvas()
        self.canvas.move_to(0, 0, 0)

    def facing_to_dir(self, _dir: int) -> tuple:
        """因为需要方块放置的坐标和朝向，
        按照bdx文件的方块放置方法，就需要给出移动一步吼的坐标"""
        cv = self.canvas
        return [
            (0, -1, 0),
            (0, 1, 0),
            (0, 0, -1),
            (0, 0, 1),
            (-1, 0, 0),
            (1, 0, 0)
        ][_dir]

    def opposite(_dir):
        """给出该朝向ID的反方向ID"""
        match _dir:
            case 0: return 1
            case 1: return 0
            case 2: return 3
            case 3: return 2
            case 4: return 5
            case 5: return 4

    def next(self, _dir):
        cv = self.canvas
        match _dir:
            case cv.FACE_ZPP: return cv.FACE_XPP
            case cv.FACE_XPP: return cv.FACE_ZPP
            case cv.FACE_ZNN: return cv.FACE_XPP
            case cv.FACE_XNN: return cv.FACE_ZPP

    def put_cmd_block(
        self,
        xDir: int,
        yDir: int,
        zDir: int,
        cmd: str,
        facing,
        cb_mode =
        bdx_work_shop.canvas.Canvas.MODE_CHAIN_CB, 
        delay = 0,
        conditional = False
    ):
        assert type(xDir) == type(yDir) == type(zDir) == int
        self.canvas.place_command_block_with_data(
            xDir, 
            yDir, 
            zDir,
            None, 
            facing,
            cb_mode, 
            cmd,
            '',
            delay,
            conditional = conditional
        )

    def dump(self, file_path = "test.bdx"):
        ir = self.canvas.done()
        bdx_work_shop.canvas.irio.dump_ir_to_bdx(ir, file_path, need_sign=False, author="SuperBdxSpawner")

    def input_cmds_array(
        self, 
        cmd_array: CmdArrays, 
        x_expand = bdx_work_shop.canvas.Canvas.FACE_WEST, 
        z_expand = bdx_work_shop.canvas.Canvas.FACE_NORTH,
        max_xscale = 4,
        auto_cond = True
    ):
        "2D自动排列命令方块， 但是已弃用"
        # @SuperScript: 还是太粗糙了...
        curr_pos = (0, 0, 0)
        cv = self.canvas
        current_num = 0
        x_dir = x_expand
        facing = x_expand
        assert x_expand in [cv.FACE_EAST, cv.FACE_SOUTH, cv.FACE_WEST, cv.FACE_NORTH], "错误的朝向!"
        assert z_expand != x_expand, "错误的扩展朝向!"
        if not auto_cond:
            for cmd, mode, delay, conditional in cmd_array.array:
                    current_num += 1
                    if current_num % max_xscale == 0 and current_num // max_xscale:
                        facing = z_expand

                    elif current_num % max_xscale == 1 and current_num // max_xscale:
                        x_dir = MCCmd2Bdx.opposite(x_dir)
                        facing = x_dir

                    now_x, now_y, now_z = curr_pos
                    self.put_cmd_block(
                        now_x,
                        now_y,
                        now_z,
                        cmd,
                        facing,
                        mode,
                        delay,
                        conditional
                    )
                    dx, dy, dz = self.facing_to_dir(facing)
                    curr_pos = (now_x+dx, now_y+dy, now_z+dz)
            print("Place cbs done!")

    def snake_folding_cmds(
        self,
        cmd_array: CmdArrays, 
        x_expand = bdx_work_shop.canvas.Canvas.FACE_WEST, 
        z_expand = bdx_work_shop.canvas.Canvas.FACE_NORTH,
        max_xscale = 30,
        max_zscale = 60,
        initx = None,
        inity = None,
        initz = None
    ):
        self.canvas.snake_folding_cmds(
            initx,
            inity,
            initz,
            self.facing_to_dir(x_expand),
            self.facing_to_dir(z_expand),
            (0, 1, 0),
            max_xscale,
            max_zscale,
            None,
            cmd_array.to_fmt_array()
        )
        return self

class FileParser:
    modeCB = re.compile(r"\((.*)\)")
    modeDelayCB = re.compile(r"{([0-9]*)}")
    modeSituCB = re.compile(r"\[([0-9]*)\]")
    modeRestoneCB = re.compile(r"\$([0-9]*)")
    def __init__(self, path = "test.txt"):
        newFileIIter: list[str] = []
        doubleSY = 0
        cacheText = ""
        # 处理换行问题
        with open(path, "r", encoding="utf-8") as file:
            self.fileIter = file.read().split("\n")
        for fileLine in self.fileIter:
            for text in fileLine:
                if text == '"':
                    doubleSY += 1
            cacheText += fileLine
            if doubleSY % 2 == 0:
                newFileIIter.append(cacheText)
                cacheText = ""
        self.textLines = newFileIIter

    def getBasicData(self):
        canva = bdx_work_shop.canvas.Canvas
        prot = 0
        try:
            dir1 = self.textLines[0].strip("#")
            max_expand = int(self.textLines[1].strip("#"))
            prot = 1
        except:
            try:
                prot = 2
                print("格式1 不可用，将使用格式2")
                rsu = json.loads(self.textLines[0].strip("#").strip())
                dir1 = rsu["初始方向1"]
                dir2 = rsu["初始方向2"]
                max_expand = int(rsu["最大延伸"])
                match dir2:
                    case "x+": dir2 = canva.FACE_XPP
                    case "x-": dir2 = canva.FACE_XNN
                    case "z+": dir2 = canva.FACE_ZPP
                    case "z-": dir2 = canva.FACE_ZNN
                    case _: raise Exception("初始方向1不正确: 必须为 x+/x-/z+/z-")
            except json.JSONDecodeError:
                print("格式2 仍不可用， 你干嘛， 要爆炸了小黑子")
        match dir1:
            case "x+": dir1 = canva.FACE_XPP
            case "x-": dir1 = canva.FACE_XNN
            case "z+": dir1 = canva.FACE_ZPP
            case "z-": dir1 = canva.FACE_ZNN
            case _: raise Exception("初始方向1不正确: 必须为 x+/x-/z+/z-")
        if prot == 1:
            dir2 = MCCmd2Bdx.opposite(dir1)
        return max_expand, dir1, dir2

    def parseCmds(self):
        next_delay = 0
        count_cond = 0
        next_mode = 0
        count_redstone = 0
        canva = bdx_work_shop.canvas.Canvas
        final_arr = MCCmd2Bdx.CmdArrays()
        for cmd in self.textLines[1:]:
            if not cmd.strip():
                continue
            cmd = cmd.replace("\\n", "\n")
            nextDelayMode = False
            conditional = False
            needRedstone = False
            if next_delay:
                nextDelayMode = True
            if "#" in cmd:
                try:
                    if "[" in cmd:
                        # 指定后多少个命令方块都是有条件
                        count_cond = int(self.modeSituCB.findall(cmd)[0])
                    if "{" in cmd:
                        # 指定下一个命令方块的延迟
                        next_delay = int(self.modeDelayCB.findall(cmd)[0])
                    if "(" in cmd:
                        # 指定下一个命令方块的类型
                        next_mode_zh = self.modeCB.findall(cmd)[0]
                        match next_mode_zh:
                            case "脉冲": next_mode = canva.MODE_CB
                            case "连锁": next_mode = canva.MODE_CHAIN_CB
                            case "循环": next_mode = canva.MODE_REPEAT_CB
                            case "": pass
                            case _: pass
                    if "$" in cmd:
                        count_redstone = int(self.modeRestoneCB.findall(cmd)[0])
                except Exception as err:
                    print(f"error crashed: {err}")
                    continue
                if not cmd.startswith("#"):
                    # 忽略 # 以及后面的注释
                    if count_cond:
                        count_cond -= 1
                        conditional = True
                    if count_redstone:
                        count_redstone -= 1
                        needRedstone = True
                    new_cmd = ""
                    for char in cmd:
                        if char == "#":
                            break
                        new_cmd += char
                    final_arr.append(new_cmd, next_mode, delay = next_delay, conditional = conditional, needRedstone = needRedstone)
                    if nextDelayMode:
                        next_delay = 0
            else:
                if count_cond:
                    count_cond -= 1
                    conditional = True
                final_arr.append(cmd, next_mode, delay = next_delay, conditional = conditional, needRedstone = needRedstone)
                if nextDelayMode:
                    next_delay = 0
        return final_arr





def test_bdx(path: str):
    parser = FileParser(path)
    try:
        max_len, first_dir, sec_dir = parser.getBasicData()
    except Exception as err:
        max_len, first_dir, sec_dir  = 20, 5, 3
        print(f"读取文件头属性出现问题: {err}")
    print(f"文件头 parse done! init_facing={first_dir}, max_expand={max_len}")
    arr = parser.parseCmds()
    op = MCCmd2Bdx()
    op.snake_folding_cmds(arr, first_dir, sec_dir, max_len).dump(path.replace("mcfunction", "bdx"))


for now_dir in os.listdir():
    if not os.path.isdir(now_dir):
        continue
    for i in os.listdir(now_dir):
        if i.endswith("mcfunction"):
            print()
            test_bdx(os.path.join(now_dir, i))