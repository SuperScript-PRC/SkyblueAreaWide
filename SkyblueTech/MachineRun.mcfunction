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
execute as @e[scores={st:mc_type=2,st:runid=1},tag=st.tick_ok] at @s run clone 123457 112 123457 123457 112 123457 ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=2},tag=st.tick_ok] at @s run clone 123458 112 123457 123457 112 123458 ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=3},tag=st.tick_ok] at @s run clone 123457 112 123459 123457 112 123459 ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=4},tag=st.tick_ok] at @s run clone 123457 112 123460 123457 112 123460 ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=5},tag=st.tick_ok] at @s run clone 123457 112 123461 123457 112 123461  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=6},tag=st.tick_ok] at @s run clone 123457 112 123462 123457 112 123462  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=7},tag=st.tick_ok] at @s run clone 123457 112 123463 123457 112 123463  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=8},tag=st.tick_ok] at @s run clone 123457 112 123464 123457 112 123464  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=9},tag=st.tick_ok] at @s run clone 123457 112 123465 123457 112 123465  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=10},tag=st.tick_ok] at @s run clone 123457 112 123466 123457 112 123466  ~~-1~
execute as @e[scores={st:mc_type=2,st:runid=11},tag=st.tick_ok] at @s run clone 123457 112 123467 123457 112 123467  ~~-1~
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
# 完全收尾
scoreboard players set @e[tag=st.tick_ok] st:mc_tick 0
scoreboard players set @e[tag=st.tick_ok] st:rs_cd 0