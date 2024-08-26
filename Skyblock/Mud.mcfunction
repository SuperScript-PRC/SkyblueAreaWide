# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 筛泥巴
#
# #(循环)#{10}
execute as @a[tag=!robot] at @s if block ~~~ water if block ~~-1~ dirt run setblock ~~-1~ mud
# #(连锁)
execute as @a[tag=!robot] at @s if block ~~-0.5~ minecraft:mud if block ~~-1.5~ minecraft:scaffolding run tag @s add is.mud
# #[1]
setblock ~~~1 minecraft:chain_command_block ["facing_direction"=3]
say "THIS IS EMPTY"
setblock ~~~-1 air
execute as @e[tag=is.mud] run scoreboard players random @s is:random 1 200
execute as @e[tag=is.mud,scores={is:random=1..15}] at @s run structure load 掉落物小麦种子 ~~~
execute as @e[tag=is.mud,scores={is:random=16..24}] at @s run structure load 掉落物南瓜种子 ~~~
execute as @e[tag=is.mud,scores={is:random=25..33}] at @s run structure load 掉落物西瓜种子 ~~~
execute as @e[tag=is.mud,scores={is:random=14..24}] at @s run structure load 掉落物甜菜种子 ~~~
execute as @e[tag=is.mud,scores={is:random=25..27}] at @s run structure load 掉落物火把花种子 ~~~
execute as @e[tag=is.mud,scores={is:random=28..40}] at @s run structure load 掉落物胡萝卜 ~~~
execute as @e[tag=is.mud,scores={is:random=41..53}] at @s run structure load 掉落物马铃薯 ~~~
execute as @e[tag=is.mud,scores={is:random=54..62}] at @s run structure load 掉落物甜浆果 ~~~
execute as @e[tag=is.mud,scores={is:random=63..83}] at @s run structure load 掉落物黏土 ~~~
execute as @e[tag=is.mud] at @s run setblock ~~-0.5~ air 0 destroy
execute as @e[tag=is.mud] at @s run kill @e[y=~-1,r=1,name=泥巴]
tag @a remove is.mud