# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 机器的各个属性初始化
#
# #(循环)#{80}
scoreboard players add @e[scores={st:mc_type=1..}] st:mc_rf 0
# #(连锁)
scoreboard players add @e[scores={st:mc_type=1..}] st:rs_cd 0
scoreboard players add @e[scores={st:mc_type=1..}] st:gen_tick 0
scoreboard players set @e[scores={st:mc_type=1..}] st:energyd 100
scoreboard players set @e[scores={st:mc_type=1..}] st:speedup 1
scoreboard players add @e[scores={st:mc_type=1..}] st:runid_tmp 0
scoreboard players add @e[tag=st.dc] st:mc_rf 0
scoreboard players set @e[tag=st.dc] st:mc_srf 100000
execute as @e[tag=st.machine,hasitem={item=netherite_upgrade_smithing_template,data=710,quantity=1}] run scoreboard players set @s st:speedup 2
execute as @e[tag=st.machine,hasitem={item=netherite_upgrade_smithing_template,data=710,quantity=2}] run scoreboard players set @s st:speedup 3
execute as @e[tag=st.machine,hasitem={item=rib_armor_trim_smithing_template,data=711,quantity=1}] run scoreboard players set @s st:energyd 75
execute as @e[tag=st.machine,hasitem={item=rib_armor_trim_smithing_template,data=711,quantity=2}] run scoreboard players set @s st:energyd 55
# 火力发电机
scoreboard players add @e[scores={st:mc_type=6}] st:heatgen_cd 0
# 打粉机
scoreboard players set @e[scores={st:mc_type=2}] st:mc_stick 25
# #[2]
scoreboard players set @e[scores={st:mc_type=2}] st:mc_mcp 20
scoreboard players set @e[scores={st:mc_type=2}] st:mc_srf 300
# 金属炉
scoreboard players set @e[scores={st:mc_type=4}] st:mc_stick 22
# #[2]
scoreboard players set @e[scores={st:mc_type=4}] st:mc_mcp 30
scoreboard players set @e[scores={st:mc_type=4}] st:mc_srf 300
# 伐木机
scoreboard players set @e[scores={st:mc_type=5}] st:mc_stick 300
# #[2]
scoreboard players set @e[scores={st:mc_type=5}] st:mc_mcp 2
scoreboard players set @e[scores={st:mc_type=5}] st:mc_srf 600
# 种植站
scoreboard players set @e[scores={st:mc_type=7}] st:mc_stick 16
# #[2]
scoreboard players set @e[scores={st:mc_type=7}] st:mc_mcp 42
scoreboard players set @e[scores={st:mc_type=7}] st:mc_srf 400
# 虚空采矿机
scoreboard players set @e[scores={st:mc_type=8}] st:mc_stick 200
# #[2]
scoreboard players set @e[scores={st:mc_type=8}] st:mc_mcp 320
scoreboard players set @e[scores={st:mc_type=8}] st:mc_srf 3500
# 压缩机
scoreboard players set @e[scores={st:mc_type=9}] st:mc_stick 40
# #[2]
scoreboard players set @e[scores={st:mc_type=9}] st:mc_mcp 18
scoreboard players set @e[scores={st:mc_type=9}] st:mc_srf 300
# 地热发电机
scoreboard players set @e[scores={st:mc_type=10}] st:gen_rfp 90
# 电力挖石机
scoreboard players set @e[scores={st:mc_type=11}] st:mc_stick 20
# #[2]
scoreboard players set @e[scores={st:mc_type=11}] st:mc_mcp 25
scoreboard players set @e[scores={st:mc_type=11}] st:mc_srf 320
# 感应炉
scoreboard players set @e[scores={st:mc_type=12}] st:mc_stick 20
# #[2]
scoreboard players set @e[scores={st:mc_type=12}] st:mc_mcp 35
scoreboard players set @e[scores={st:mc_type=12}] st:mc_srf 450
# 自动筛子
scoreboard players set @e[scores={st:mc_type=13}] st:mc_stick 18
# #[2]
scoreboard players set @e[scores={st:mc_type=13}] st:mc_mcp 28
scoreboard players set @e[scores={st:mc_type=13}] st:mc_srf 400
# 加速卡

execute as @e[tag=st.machine,scores={st:mc_stick=1..,st:speedup=1..}] run scoreboard players operation @s st:mc_stick /= @s st:speedup
# 节能卡
execute as @e[tag=st.machine,scores={st:mc_mcp=1..}] run scoreboard players operation @s st:mc_mcp *= @s st:energyd
execute as @e[tag=st.machine,scores={st:mc_mcp=1..}] run scoreboard players operation @s st:mc_mcp /= hundred st:constant
