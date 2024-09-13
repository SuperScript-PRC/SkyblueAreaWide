# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=!st.empty,scores={st:mc_type=2}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 配方: 圆石-砂砾
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=cobblestone,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
# 配方: 砂砾-沙子
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=gravel,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2
# 配方: 羊毛-线
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=wool,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 3
# 配方: 铁锭-铁粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=iron_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 4
# 配方: 铜锭-铜粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=copper_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 5
# 配方: 金锭-金粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=gold_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 6
# 配方: 锡锭-锡粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=iron_ingot,data=505,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 7
# 配方: 铅锭-铅粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=netherbrick,data=506,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 8
# 配方: 银锭-银粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=iron_ingot,data=508,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 9
# 配方: 镍锭-镍粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=copper_ingot,data=509,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 10
# 配方: 钴锭-钴粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=netherbrick,data=513,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 11
# 配方: 粗铁-2铁粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=raw_iron,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 12
# 配方: 粗铜-2铜粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=raw_copper,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 13
# 配方: 粗金-2金粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=raw_gold,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 14
# 配方: 木炭-碳粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=charcoal,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 15
# 配方: 煤炭-碳粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=coal,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 15
# 配方: 骨头-骨粉
execute as @e[tag=!st.empty,scores={st:mc_type=2},hasitem={item=bone,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 16