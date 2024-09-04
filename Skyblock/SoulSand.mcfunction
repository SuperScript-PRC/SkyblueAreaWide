# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 筛灵魂沙 (断链模式)
#
# #(循环)#{10}
# 检测
execute as @a[tag=!robot] at @s if block ~~-0.5~ minecraft:soul_sand if block ~~-1.5~ minecraft:scaffolding run tag @s add is.soulsand
# #(连锁)[1]
setblock ~~~1 minecraft:chain_command_block ["facing_direction"=3]
say "THIS IS EMPTY"
setblock ~~~-1 air
execute as @e[tag=is.soulsand] run scoreboard players random @s is:random 1 100
execute as @e[tag=is.soulsand,scores={is:random=1..7}] at @s run structure load 掉落物地狱疣 ~~~
execute as @e[tag=is.soulsand,scores={is:random=8..10}] at @s run structure load 掉落物绯红菌岩 ~~~
execute as @e[tag=is.soulsand,scores={is:random=11..14}] at @s run structure load 掉落物绯红菌 ~~~
execute as @e[tag=is.soulsand,scores={is:random=15..18}] at @s run structure load 掉落物诡异真菌 ~~~
execute as @e[tag=is.soulsand] at @s run setblock ~~-0.5~ air 0 destroy
execute as @e[tag=is.soulsand] at @s run kill @e[y=~-0.8,r=1,name=灵魂沙]
tag @a remove is.soulsand