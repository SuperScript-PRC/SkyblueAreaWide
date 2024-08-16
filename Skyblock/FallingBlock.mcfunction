# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 处理掉到 y=-60 平面上的下落方块
#
# #(循环)#{20}
execute as @e[type=minecraft:falling_block] at @s if entity @s[x=~-1,y=-60,z=~-1,dx=2,dy=30,dz=2] run tellraw @a {"rawtext":[{"text":"§6一个方块落入了虚空..."}]}
# #(连锁)#[1]
execute as @e[type=minecraft:falling_block] at @s if entity @s[x=~-1,y=-60,z=~-1,dx=2,dy=30,dz=2] run kill