# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=st.tick_ok,scores={st:mc_type=15}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 配方表
execute as @e[tag=st.tick_ok,scores={st:mc_type=14,st:runid=1}] at @s run replaceitem block ~~-3~ slot.container 0 minecraft:quartz
execute as @e[tag=st.tick_ok,scores={st:mc_type=14,st:runid=2}] at @s run replaceitem block ~~-3~ slot.container 0 minecraft:netherrack
# 收尾
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1..}] run replaceitem entity @s slot.inventory 0 minecraft:air
# #[1]
execute as @e[tag=st.tick_ok,scores={st:mc_type=13,st:runid=1..}] run playsound beacon.activate @a[r=20]