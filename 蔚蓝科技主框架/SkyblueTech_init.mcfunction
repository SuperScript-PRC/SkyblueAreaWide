# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 初始化计分板
#
# #(脉冲)$1
scoreboard objectives add st:mc_type dummy st机器种类
# #(连锁)
scoreboard objectives add st:mc_tick dummy st机器当前tick
scoreboard objectives add st:mc_stick dummy st机器总tick
scoreboard objectives add st:mc_rf dummy st机器储电
scoreboard objectives add st:mc_srf dummy st机器储电上限
scoreboard objectives add st:mc_mcp dummy st机器功率
scoreboard objectives add st:mc_mcpdyn dummy st动态机器功率
scoreboard objectives add st:mc_data1 dummy st机器数据1
scoreboard objectives add st:mc_data2 dummy st机器数据2
scoreboard objectives add st:gen_rfp dummy st发电机功率
scoreboard objectives add st:gen_tick dummy st发电剩余
scoreboard objectives add st:circuit dummy st电路板种类
scoreboard objectives add st:heater dummy st加热器种类
scoreboard objectives add st:speedup dummy st加速速度
scoreboard objectives add st:energyd dummy st节能百分比
scoreboard objectives add st:constant dummy st常量表
scoreboard objectives add st:runid dummy st机器运行任务id
scoreboard objectives add st:runid_tmp dummy st机器运行任务id
scoreboard objectives add st:rs_cd dummy st红石激活冷却cd
scoreboard objectives add st:cache1 dummy st缓存1
scoreboard objectives add st:cache2 dummy st缓存2
scoreboard objectives add st:cache3 dummy st缓存3
scoreboard objectives add st:heatgen_cd dummy st火力超时检测
scoreboard objectives add st:iter dummy st遍历
scoreboard objectives add st:nostack dummy st矿车堆叠计算
scoreboard players set hundred st:constant 100