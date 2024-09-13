# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=!st.empty,scores={st:mc_type=12}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 配方: 1x锡锭+2x铜锭-3x青铜锭
execute as @e[tag=!st.empty,scores={st:mc_type=12},hasitem={item=copper_ingot,data=0,slot=0,quantity=2,location=slot.inventory}] at @s if entity @e[y=~-2,r=1,type=chest_minecart,c=1,hasitem={item=iron_ingot,data=505,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
# 配方: 1x钢锭+1x镍锭-2x殷钢锭
execute as @e[tag=!st.empty,scores={st:mc_type=12},hasitem={item=copper_ingot,data=509,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~-2,r=1,type=chest_minecart,c=1,hasitem={item=iron_ingot,data=504,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2
# 配方: 1x铜锭+1x镍锭-2x康铜锭
execute as @e[tag=!st.empty,scores={st:mc_type=12},hasitem={item=copper_ingot,data=509,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~-2,r=1,type=chest_minecart,c=1,hasitem={item=copper_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 3
# 配方: 1x铁锭+1x碳粉-1x钢锭
execute as @e[tag=!st.empty,scores={st:mc_type=12},hasitem={item=black_dye,data=0,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~-2,r=1,type=chest_minecart,c=1,hasitem={item=iron_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 4
# 配方: 1x金锭+1x银锭-1x琥珀金锭
execute as @e[tag=!st.empty,scores={st:mc_type=12},hasitem={item=iron_ingot,data=508,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~-2,r=1,type=chest_minecart,c=1,hasitem={item=gold_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 5
# 配方: 1x琥珀金锭+1x末影晶体-1x谐振合金
execute as @e[tag=!st.empty,scores={st:mc_type=12},hasitem={item=emerald,data=733,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~-2,r=1,type=chest_minecart,c=1,hasitem={item=gold_ingot,data=510,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 6