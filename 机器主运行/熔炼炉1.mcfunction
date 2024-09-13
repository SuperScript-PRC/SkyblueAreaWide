# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=st.tick_ok,scores={st:mc_type=4}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 配方表
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=1}] at @s run clone 123459 111 123457 123459 111 123457 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=2}] at @s run clone 123459 111 123458 123459 111 123458 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=3}] at @s run clone 123459 111 123459 123459 111 123459 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=4}] at @s run clone 123459 111 123460 123459 111 123460 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=5}] at @s run clone 123459 111 123461 123459 111 123461 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=6}] at @s run clone 123459 111 123462 123459 111 123462 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=7}] at @s run clone 123459 111 123463 123459 111 123463 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=8}] at @s run clone 123459 111 123464 123459 111 123464 ~~-1~
# 收尾
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=1..}] at @s run particle minecraft:campfire_smoke_particle ~~3~
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=1..}] at @s run playsound dig.sand @a[r=20]
execute as @e[tag=st.tick_ok,scores={st:mc_type=4,st:runid=1..}] run replaceitem entity @s slot.inventory 0 minecraft:air