# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=st.tick_ok,scores={st:mc_type=13}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 砂砾
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1..}] run scoreboard players random @s st:cache1 1 300
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=1..3}] at @s run structure load 掉落物钻石 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=4}] at @s run structure load 掉落物绿宝石 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=5..12}] at @s run structure load 掉落物青金石 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=13..20}] at @s run structure load 掉落物红石 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=21..26}] at @s run structure load 掉落物粗金 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=27..47}] at @s run structure load 掉落物粗铁 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=48..60}] at @s run structure load 掉落物粗铜 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=61..95}] at @s run structure load 掉落物煤炭 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=96..106}] at @s run structure load 掉落物锡粉 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=107..113}] at @s run structure load 掉落物铅粉 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=114..118}] at @s run structure load 掉落物银粉 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1,st:cache1=119..125}] at @s run structure load 掉落物镍粉 ~~-1~
# 沙子
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=2,st:cache1=1..12}] at @s run structure load 掉落物石英 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=2,st:cache1=13..25}] at @s run structure load 掉落物萤石 ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=2,st:cache1=26..36}] at @s run structure load 掉落物海带 ~~-1~
# 收尾
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1..}] at @s run tp @e[r=1,type=item] ~~-1~
# #[3]
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1..}] run replaceitem entity @s slot.inventory 0 minecraft:air
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1..}] at @s run playsound dig.gravel @a[r=20]
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1..}] at @s run particle minecraft:knockback_roar_particle ~~-1~