# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=!st.empty,scores={st:mc_type=4}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 配方: 铁粉-铁锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=gunpowder,data=601,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
# 配方: 铜粉-铜锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=glowstone_dust,data=602,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2
# 配方: 金粉-金锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=glowstone_dust,data=603,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 3
# 配方: 锡粉-锡锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=sugar,data=605,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 4
# 配方: 铅粉-铅锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=gunpowder,data=606,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 5
# 配方: 银粉-银锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=sugar,data=608,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 6
# 配方: 镍粉-镍锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=glowstone_dust,data=609,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 7
# 配方: 钴粉-钴锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=gunpowder,data=613,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 8
# 配方: 钢粉-钢锭
execute as @e[tag=!st.empty,scores={st:mc_type=4},hasitem={item=gunpowder,data=604,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 9
# 电力挖石机
execute as @e[tag=!st.empty,scores={st:mc_type=11}] at @s if block ~~3~ cobblestone run scoreboard players set @s st:runid_tmp 1