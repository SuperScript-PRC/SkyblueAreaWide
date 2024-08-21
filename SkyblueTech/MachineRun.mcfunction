# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 机器运行一次
#
# #(循环)#{4}
tag @e[tag=st.tick_ok] remove st.tick_ok
# #(连锁)
# 判定机器是否可以生产
execute as @e[tag=st.machine,scores={st:mc_tick=1..}] if score @s st:mc_tick > @s st:mc_stick run tag @s add st.tick_ok
# 打粉机
# 配方表
execute as @e[scores={st:mc_type=2,st:runid=1},tag=st.tick_ok] at @s run clone 123457 111 123457 123457 111 123457 ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=2},tag=st.tick_ok] at @s run clone 123458 111 123457 123457 111 123458 ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=3},tag=st.tick_ok] at @s run clone 123457 111 123459 123457 111 123459 ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=4},tag=st.tick_ok] at @s run clone 123457 111 123460 123457 111 123460 ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=5},tag=st.tick_ok] at @s run clone 123457 111 123461 123457 111 123461  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=6},tag=st.tick_ok] at @s run clone 123457 111 123462 123457 111 123462  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=7},tag=st.tick_ok] at @s run clone 123457 111 123463 123457 111 123463  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=8},tag=st.tick_ok] at @s run clone 123457 111 123464 123457 111 123464  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=9},tag=st.tick_ok] at @s run clone 123457 111 123465 123457 111 123465  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=10},tag=st.tick_ok] at @s run clone 123457 111 123466 123457 111 123466  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=11},tag=st.tick_ok] at @s run clone 123457 111 123467 123457 111 123467  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=12},tag=st.tick_ok] at @s run clone 123457 111 123468 123457 111 123468  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=13},tag=st.tick_ok] at @s run clone 123457 111 123469 123457 111 123469  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=14},tag=st.tick_ok] at @s run clone 123457 111 123470 123457 111 123470  ~~-1~
# 收尾
execute as @e[scores={st:mc_type=2,st:runid=1..},tag=st.tick_ok] at @s run particle minecraft:knockback_roar_particle ~~~
execute as @e[scores={st:mc_type=2,st:runid=1..},tag=st.tick_ok] at @s run playsound dig.sand @a[r=20]
execute as @e[scores={st:mc_type=2,st:runid=1..},tag=st.tick_ok] run replaceitem entity @s slot.inventory 0 minecraft:air
# 多功能炉
# 配方表
execute as @e[scores={st:mc_type=4,st:runid=1},tag=st.tick_ok] at @s run clone 123459 111 123457 123459 111 123457 ~~-1~
execute as @e[scores={st:mc_type=4,st:runid=2},tag=st.tick_ok] at @s run clone 123459 111 123458 123459 111 123458 ~~-1~
execute as @e[scores={st:mc_type=4,st:runid=3},tag=st.tick_ok] at @s run clone 123459 111 123459 123459 111 123459 ~~-1~
execute as @e[scores={st:mc_type=4,st:runid=4},tag=st.tick_ok] at @s run clone 123459 111 123460 123459 111 123460 ~~-1~
execute as @e[scores={st:mc_type=4,st:runid=5},tag=st.tick_ok] at @s run clone 123459 111 123461 123459 111 123461 ~~-1~
execute as @e[scores={st:mc_type=4,st:runid=6},tag=st.tick_ok] at @s run clone 123459 111 123462 123459 111 123462 ~~-1~
execute as @e[scores={st:mc_type=4,st:runid=7},tag=st.tick_ok] at @s run clone 123459 111 123463 123459 111 123463 ~~-1~
execute as @e[scores={st:mc_type=4,st:runid=8},tag=st.tick_ok] at @s run clone 123459 111 123464 123459 111 123464 ~~-1~
# 收尾
execute as @e[scores={st:mc_type=4,st:runid=1..},tag=st.tick_ok] at @s run particle minecraft:campfire_smoke_particle ~~3~
execute as @e[scores={st:mc_type=4,st:runid=1..},tag=st.tick_ok] at @s run playsound dig.sand @a[r=20]
execute as @e[scores={st:mc_type=4,st:runid=1..},tag=st.tick_ok] run replaceitem entity @s slot.inventory 0 minecraft:air
# 电力挖石机
execute as @e[scores={st:mc_type=11,st:runid=1},tag=st.tick_ok] at @s if block ~~3~ minecraft:cobblestone run setblock ~~3~ air 0 destroy
execute as @e[scores={st:mc_type=11,st:runid=1},tag=st.tick_ok] at @s run tp @e[y=~3,r=1,name=圆石] @e[r=15,tag=st.collector]
# 感应炉
# 配方表
execute as @e[scores={st:mc_type=12,st:runid=1},tag=st.tick_ok] at @s run clone 123461 111 123457 123461 111 123457 ~~-1~
execute as @e[scores={st:mc_type=12,st:runid=2},tag=st.tick_ok] at @s run clone 123461 111 123458 123461 111 123458 ~~-1~
execute as @e[scores={st:mc_type=12,st:runid=3},tag=st.tick_ok] at @s run clone 123461 111 123459 123461 111 123459 ~~-1~
execute as @e[scores={st:mc_type=12,st:runid=4},tag=st.tick_ok] at @s run clone 123461 111 123460 123461 111 123460 ~~-1~
execute as @e[scores={st:mc_type=12,st:runid=5},tag=st.tick_ok] at @s run clone 123461 111 123461 123461 111 123461 ~~-1~
execute as @e[scores={st:mc_type=12,st:runid=6},tag=st.tick_ok] at @s run clone 123461 111 123462 123461 111 123462 ~~-1~
# 收尾
execute as @e[scores={st:mc_type=12,st:runid=1..},tag=st.tick_ok] at @s run particle minecraft:egg_destroy_emitter ~~~
execute as @e[scores={st:mc_type=12,st:runid=1..},tag=st.tick_ok] at @s run playsound dig.sand @a[r=20]
execute as @e[scores={st:mc_type=12,st:runid=1..},tag=st.tick_ok] run replaceitem entity @s slot.inventory 0 minecraft:air
execute as @e[scores={st:mc_type=12,st:runid=1..},tag=st.tick_ok] at @s run replaceitem entity @e[y=~2,c=1,r=1,type=minecraft:hopper_minecart] slot.inventory 0 minecraft:air
# 电力筛子
execute as @e[scores={st:mc_type=13,st:runid=1..},tag=st.tick_ok] run scoreboard players random @s st:cache1 1 300
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=1..3},tag=st.tick_ok] at @s run structure load 掉落物钻石 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=4},tag=st.tick_ok] at @s run structure load 掉落物绿宝石 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=5..10},tag=st.tick_ok] at @s run structure load 掉落物青金石 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=11..20},tag=st.tick_ok] at @s run structure load 掉落物红石 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=21..26},tag=st.tick_ok] at @s run structure load 掉落物粗金 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=27..41},tag=st.tick_ok] at @s run structure load 掉落物粗铁 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=42..51},tag=st.tick_ok] at @s run structure load 掉落物粗铜 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=52..68},tag=st.tick_ok] at @s run structure load 掉落物煤炭 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=69..78},tag=st.tick_ok] at @s run structure load 掉落物锡粉 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=79..86},tag=st.tick_ok] at @s run structure load 掉落物铅粉 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=87..91},tag=st.tick_ok] at @s run structure load 掉落物银粉 ~~-1~
execute as @e[scores={st:mc_type=13,st:runid=1,st:cache1=92..97},tag=st.tick_ok] at @s run structure load 掉落物镍粉 ~~-1~
# 收尾
execute as @e[scores={st:mc_type=13,st:runid=1..},tag=st.tick_ok] at @s run playsound dig.gravel @a[r=20]
execute as @e[scores={st:mc_type=13,st:runid=1..},tag=st.tick_ok] run replaceitem entity @s slot.inventory 0 minecraft:air
execute as @e[scores={st:mc_type=13,st:runid=1..},tag=st.tick_ok] at @s run particle minecraft:knockback_roar_particle ~~-1~
# 完全收尾
scoreboard players set @e[tag=st.tick_ok] st:mc_tick 0
scoreboard players set @e[tag=st.tick_ok] st:rs_cd 0