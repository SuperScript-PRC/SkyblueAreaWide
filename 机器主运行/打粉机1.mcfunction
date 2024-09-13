# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=st.tick_ok,scores={st:mc_type=2}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 配方表
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=1}] at @s run clone 123457 111 123457 123457 111 123457 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=2}] at @s run clone 123457 111 123458 123457 111 123458 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=3}] at @s run clone 123457 111 123459 123457 111 123459 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=4}] at @s run clone 123457 111 123460 123457 111 123460 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=5}] at @s run clone 123457 111 123461 123457 111 123461 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=6}] at @s run clone 123457 111 123462 123457 111 123462 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=7}] at @s run clone 123457 111 123463 123457 111 123463 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=8}] at @s run clone 123457 111 123464 123457 111 123464 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=9}] at @s run clone 123457 111 123465 123457 111 123465 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=10}] at @s run clone 123457 111 123466 123457 111 123466 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=11}] at @s run clone 123457 111 123467 123457 111 123467 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=12}] at @s run clone 123457 111 123468 123457 111 123468 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=13}] at @s run clone 123457 111 123469 123457 111 123469 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=14}] at @s run clone 123457 111 123470 123457 111 123470 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=15}] at @s run clone 123457 111 123471 123457 111 123471 ~~-1~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=16}] at @s run clone 123457 111 123472 123457 111 123472 ~~-1~
# 收尾
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=1..}] at @s run particle minecraft:knockback_roar_particle ~~~
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=1..}] at @s run playsound dig.sand @a[r=20]
execute as @e[tag=st.tick_ok,scores={st:mc_type=2,st:runid=1..}] run replaceitem entity @s slot.inventory 0 minecraft:air