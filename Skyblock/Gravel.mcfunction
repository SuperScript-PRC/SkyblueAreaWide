# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 筛砂砾 (断链模式)
#
# #(循环)#{10}
# 检测
execute as @a[tag=!robot] at @s if block ~~-1~ minecraft:gravel if block ~~-2~ minecraft:scaffolding run tag @s add is.gravel
# #(连锁)[1]
setblock ~~~1 minecraft:chain_command_block ["facing_direction"=3]
say "THIS IS EMPTY"
setblock ~~~-1 air
execute as @e[tag=is.gravel] run scoreboard players random @s is:random 1 300
execute as @e[tag=is.gravel,scores={is:random=1..3}] at @s run structure load 掉落物钻石 ~~~
execute as @e[tag=is.gravel,scores={is:random=4}] at @s run structure load 掉落物绿宝石 ~~~
execute as @e[tag=is.gravel,scores={is:random=5..12}] at @s run structure load 掉落物青金石 ~~~
execute as @e[tag=is.gravel,scores={is:random=13..20}] at @s run structure load 掉落物红石 ~~~
execute as @e[tag=is.gravel,scores={is:random=21..26}] at @s run structure load 掉落物粗金 ~~~
execute as @e[tag=is.gravel,scores={is:random=27..47}] at @s run structure load 掉落物粗铁 ~~~
execute as @e[tag=is.gravel,scores={is:random=48..60}] at @s run structure load 掉落物粗铜 ~~~
execute as @e[tag=is.gravel,scores={is:random=61..95}] at @s run structure load 掉落物煤炭 ~~~
execute as @e[tag=is.gravel,scores={is:random=96..106}] at @s run structure load 掉落物锡粉 ~~~
execute as @e[tag=is.gravel,scores={is:random=107..113}] at @s run structure load 掉落物铅粉 ~~~
execute as @e[tag=is.gravel,scores={is:random=114..118}] at @s run structure load 掉落物银粉 ~~~
execute as @e[tag=is.gravel,scores={is:random=119..125}] at @s run structure load 掉落物镍粉 ~~~
execute as @e[tag=is.gravel] at @s run setblock ~~-1~ air 0 destroy
execute as @e[tag=is.gravel] at @s run kill @e[y=~-1,r=1,name=砂砾]
execute as @e[tag=is.gravel] at @s run kill @e[y=~-1,r=1,name=燧石]
tag @a remove is.gravel