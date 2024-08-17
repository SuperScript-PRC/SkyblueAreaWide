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
execute as @e[tag=is.gravel,scores={is:random=13..24}] at @s run structure load 掉落物红石 ~~~
execute as @e[tag=is.gravel,scores={is:random=25..31}] at @s run structure load 掉落物粗金 ~~~
execute as @e[tag=is.gravel,scores={is:random=32..42}] at @s run structure load 掉落物粗铁 ~~~
execute as @e[tag=is.gravel,scores={is:random=43..51}] at @s run structure load 掉落物粗铜 ~~~
execute as @e[tag=is.gravel,scores={is:random=52..66}] at @s run structure load 掉落物煤炭 ~~~
execute as @e[tag=is.gravel,scores={is:random=67..76}] at @s run structure load 掉落物锡粉 ~~~
execute as @e[tag=is.gravel,scores={is:random=77..84}] at @s run structure load 掉落物铅粉 ~~~
execute as @e[tag=is.gravel,scores={is:random=85..89}] at @s run structure load 掉落物银粉 ~~~
execute as @e[tag=is.gravel,scores={is:random=90..95}] at @s run structure load 掉落物镍粉 ~~~
execute as @e[tag=is.gravel] at @s run setblock ~~-1~ air 0 destroy
execute as @e[tag=is.gravel] at @s run kill @e[y=~-1,r=1,name=砂砾]
tag @a remove is.gravel