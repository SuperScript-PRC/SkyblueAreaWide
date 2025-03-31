# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{20}
testfor @e[tag=st.tick_ok,scores={st:mc_type=8}]
# #(连锁)
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 配方表
scoreboard players random @e[tag=st.tick_ok,scores={st:mc_type=8}] st:mc_data1 1 125
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=1..3}] at @s run structure load 钻石矿石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=4}] at @s run structure load 绿宝石矿石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=5..12}] at @s run structure load 青金石矿石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=13..20}] at @s run structure load 红石矿石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=21..26}] at @s run structure load 金矿石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=27..47}] at @s run structure load 铁矿石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=48..60}] at @s run structure load 铜矿石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=61..95}] at @s run structure load 煤矿石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=96..106}] at @s run structure load 掉落物锡粉 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=107..113}] at @s run structure load 掉落物铅粉 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=114..118}] at @s run structure load 掉落物银粉 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=8,st:mc_data1=119..125}] at @s run structure load 掉落物镍粉 ~~~
# 收尾
execute as @e[tag=st.tick_ok,scores={st:mc_type=8}] at @s run tp @e[r=1,type=item] @e[r=15,tag=st.collector,c=1]
execute as @e[tag=st.tick_ok,scores={st:mc_type=8}] at @s run playsound dig.stone @a[r=20]
execute as @e[tag=st.tick_ok,scores={st:mc_type=8}] at @s run particle minecraft:totem_particle ~~~