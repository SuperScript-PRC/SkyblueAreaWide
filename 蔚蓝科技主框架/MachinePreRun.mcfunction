# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 机器检查配方, 并进入制作状态
#
# #(循环)#{5}
# 如果加工中途物品发生更换, 即停止加工
execute as @e[tag=st.machine,scores={st:runid_tmp=1..}] unless score @s st:runid_tmp = @s st:runid run scoreboard players set @s st:mc_tick 0
# #(连锁)
# 不然就继续加工
execute as @e[tag=st.rf_full,scores={st:runid_tmp=1..}] if score @s st:runid_tmp = @s st:runid run scoreboard players add @s st:mc_tick 1
execute as @e[tag=st.rf_full,scores={st:runid_tmp=1..}] if score @s st:runid_tmp = @s st:runid run scoreboard players operation @s st:mc_rf -= @s st:mc_mcp
execute as @e[scores={st:runid_tmp=1..}] run scoreboard players operation @s st:runid = @s st:runid_tmp
# 重置 rumid_tmp
scoreboard players set @e[scores={st:runid_tmp=1..}] st:runid_tmp 0
# 判断是否可以进行生产进度增加
tag @e[tag=st.rf_full] remove st.rf_full
execute as @e[tag=st.machine] unless score @s st:mc_rf < @s st:mc_mcp run tag @s add st.rf_full
# 这里运行着一些不必要断链的机器组
# 虚空基岩采矿机
scoreboard players set @e[scores={st:mc_type=8}] st:runid_tmp 1
# 伐木机
scoreboard players set @e[scores={st:mc_type=5}] st:runid_tmp 1
# 电力挖石机
scoreboard players set @e[scores={st:mc_type=11,st:mc_data1=1..}] st:runid_tmp 1
# 自动生物农场
execute as @e[scores={st:mc_type=11,st:mc_data1=1..,st:mc_data1=100..}] at @s if entity @e[c=1,y=~5,r=1] run scoreboard players set @s st:runid_tmp 1