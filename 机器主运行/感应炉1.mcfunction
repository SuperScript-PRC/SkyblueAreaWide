# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=st.tick_ok,scores={st:mc_type=12}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 配方表
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=1}] at @s run clone 123461 111 123457 123461 111 123457 ~~-3~
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=2}] at @s run clone 123461 111 123458 123461 111 123458 ~~-3~
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=3}] at @s run clone 123461 111 123459 123461 111 123459 ~~-3~
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=4}] at @s run clone 123461 111 123460 123461 111 123460 ~~-3~
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=5}] at @s run clone 123461 111 123461 123461 111 123461 ~~-3~
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=6}] at @s run clone 123461 111 123462 123461 111 123462 ~~-3~
# 收尾
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=1..}] at @s run replaceitem entity @e[y=~-2,c=1,r=1,type=minecraft:minecraft:chest_minecart] slot.inventory 0 minecraft:air
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=1..}] run replaceitem entity @s slot.inventory 0 minecraft:air
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=1..}] at @s run playsound dig.sand @a[r=20]
execute as @e[tag=st.tick_ok,scores={st:mc_type=12,st:runid=1..}] at @s run particle minecraft:egg_destroy_emitter ~~~