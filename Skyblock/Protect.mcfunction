# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 空岛保护
#
# #(循环)#{5}
title @a[tag=is.kick] title §c空岛保护
# #(连锁)#[1]
setblock ~~~1 minecraft:chain_command_block 3
s
setblock ~~~-1 air
title @a[tag=is.kick] subtitle §c你无法进入该空岛
kill @a[tag=is.kick]
tag @a[tag=is.kick] remove is.kick