# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=!st.empty,scores={st:mc_type=15}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 沙子-石英块
execute as @e[tag=!st.empty,scores={st:mc_type=15},hasitem={item=sand,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
# #[1]
execute as @e[tag=!st.empty,scores={st:mc_type=15},hasitem={item=sand,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:mc_mcpdyn 1000
# 圆石-地狱岩
execute as @e[tag=!st.empty,scores={st:mc_type=15},hasitem={item=cobblestone,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2
# #[1]
execute as @e[tag=!st.empty,scores={st:mc_type=15},hasitem={item=cobblestone,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 800