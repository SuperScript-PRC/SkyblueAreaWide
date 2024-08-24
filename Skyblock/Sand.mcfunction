# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 筛沙子 (断链模式)
#
# #(循环)#{10}
# 检测
execute as @a[tag=!robot] at @s if block ~~-1~ minecraft:sand ["sand_type":"normal"] if block ~~-2~ minecraft:scaffolding run tag @s add is.sand
# #(连锁)[1]
setblock ~~~1 minecraft:chain_command_block ["facing_direction"=3]
say "THIS IS EMPTY"
setblock ~~~-1 air
execute as @e[tag=is.sand] run scoreboard players random @s is:random 1 100
execute as @e[tag=is.sand,scores={is:random=1..4}] at @s run structure load 掉落物石英 ~~~
execute as @e[tag=is.sand,scores={is:random=5..7}] at @s run structure load 掉落物萤石 ~~~
execute as @e[tag=is.sand,scores={is:random=8..9}] at @s run structure load 掉落物海带 ~~~
execute as @e[tag=is.sand] at @s run setblock ~~-1~ air 0 destroy
execute as @e[tag=is.sand] at @s run kill @e[y=~-1,r=1,name=沙子]
tag @a remove is.sand