# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=!st.empty,scores={st:mc_type=13}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
execute as @e[tag=!st.empty,scores={st:mc_type=13},hasitem={item=gravel,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
execute as @e[tag=!st.empty,scores={st:mc_type=13},hasitem={item=sand,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2