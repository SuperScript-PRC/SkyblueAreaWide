# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 机器检查配方, 并进入制作状态
#
# #(循环)#{4}
scoreboard players set @e[scores={st:runid_tmp=1..}] st:runid_tmp 0
# #(连锁)
tag @e[tag=st.rf_full] remove st.rf_full
execute as @e[tag=st.machine] if score @s st:mc_rf >= @s st:mc_mcp run tag @s add st.rf_full
# 打粉机
# 配方: 圆石-砂砾
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:cobblestone,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
# 配方: 砂砾-沙子
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:gravel,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2
# 配方: 羊毛-线
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:wool,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 3
# 配方: 铁锭-铁粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:iron_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 4
# 配方: 铜锭-铜粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:copper_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 5
# 配方: 金锭-金粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:gold_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 6
# 配方: 锡锭-锡粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:iron_ingot,data=505,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 7
# 配方: 铅锭-铅粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:netherbrick,data=506,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 8
# 配方: 银锭-银粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:iron_ingot,data=508,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 9
# 配方: 镍锭-镍粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:copper_ingot,data=509,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 10
# 配方: 钴锭-钴粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:netherbrick,data=513,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 11
# 配方: 粗铁-2铁粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:minecraft:raw_iron,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 12
# 配方: 粗铜-2铜粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:raw_copper,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 13
# 配方: 粗金-2金粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:raw_gold,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 14
# 配方: 木炭-碳粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:charcoal,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 15
# 配方: 煤炭-碳粉
execute as @e[scores={st:mc_type=2},hasitem={item=minecraft:coal,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 15
# 感应炉
# 配方: 铁粉-铁锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:gunpowder,data=601,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
# 配方: 铜粉-铜锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:glowstone_dust,data=602,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2
# 配方: 金粉-金锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:glowstone_dust,data=603,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 3
# 配方: 锡粉-锡锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:sugar,data=605,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 4
# 配方: 铅粉-铅锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:gunpowder,data=606,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 5
# 配方: 银粉-银锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:sugar,data=608,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 6
# 配方: 镍粉-镍锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:glowstone_dust,data=609,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 7
# 配方: 钴粉-钴锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:gunpowder,data=613,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 8
# 配方: 钢粉-钢锭
execute as @e[scores={st:mc_type=4},hasitem={item=minecraft:gunpowder,data=604,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 9
# 电力挖石机
execute as @e[scores={st:mc_type=11}] at @s if block ~~3~ minecraft:cobblestone run scoreboard players set @s st:runid_tmp 1
# 感应炉
# 配方: 1x锡锭+2x铜锭-3x青铜锭
execute as @e[scores={st:mc_type=12},hasitem={item=minecraft:iron_ingot,data=505,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~2,r=1,type=minecraft:hopper_minecart,c=1,hasitem={item=minecraft:copper_ingot,data=0,slot=0,quantity=2,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
# 配方: 1x钢锭+1x镍锭-2x殷钢锭
execute as @e[scores={st:mc_type=12},hasitem={item=minecraft:iron_ingot,data=504,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~2,r=1,type=minecraft:hopper_minecart,c=1,hasitem={item=minecraft:copper_ingot,data=509,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2
# 配方: 1x铜锭+1x镍锭-2x康铜锭
execute as @e[scores={st:mc_type=12},hasitem={item=minecraft:copper_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~2,r=1,type=minecraft:hopper_minecart,c=1,hasitem={item=minecraft:copper_ingot,data=509,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 3
# 配方: 1x铁锭+1x碳粉-1x钢锭
execute as @e[scores={st:mc_type=12},hasitem={item=minecraft:iron_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~2,r=1,type=minecraft:hopper_minecart,c=1,hasitem={item=minecraft:black_dye,data=0,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 4
# 配方: 1x金锭+1x银锭-1x琥珀金锭
execute as @e[scores={st:mc_type=12},hasitem={item=minecraft:gold_ingot,data=0,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~2,r=1,type=minecraft:hopper_minecart,c=1,hasitem={item=minecraft:iron_ingot,data=508,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 5
# 配方: 1x琥珀金锭+1x末影晶体-1x谐振合金
execute as @e[scores={st:mc_type=12},hasitem={item=minecraft:gold_ingot,data=510,slot=0,quantity=1,location=slot.inventory}] at @s if entity @e[y=~2,r=1,type=minecraft:hopper_minecart,c=1,hasitem={item=minecraft:emerald,data=733,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 6
# 电力筛子
execute as @e[scores={st:mc_type=13},hasitem={item=minecraft:gravel,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 1
execute as @e[scores={st:mc_type=13},hasitem={item=minecraft:sand,slot=0,quantity=1,location=slot.inventory}] run scoreboard players set @s st:runid_tmp 2
# 虚空基岩采矿机
scoreboard players set @e[scores={st:mc_type=8}] st:runid_tmp 1
# 伐木机
scoreboard players set @e[scores={st:mc_type=5}] st:runid_tmp 1
# 电炉

# 最终tick统计
# 如果加工中途物品发生更换, 即停止加工
execute as @e[scores={st:runid_tmp=1..}] unless score @s st:runid_tmp = @s st:runid run scoreboard players set @s st:mc_tick 0
# 不然就继续加工
execute as @e[tag=st.rf_full,scores={st:runid_tmp=1..}] if score @s st:runid_tmp = @s st:runid run scoreboard players add @s st:mc_tick 1
execute as @e[tag=st.rf_full,scores={st:runid_tmp=1..}] if score @s st:runid_tmp = @s st:runid run scoreboard players operation @s st:mc_rf -= @s st:mc_mcp
execute as @e[scores={st:runid_tmp=1..}] run scoreboard players operation @s st:runid = @s st:runid_tmp