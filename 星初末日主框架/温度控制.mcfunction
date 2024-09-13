# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{80}
execute as @a if score @s sc:温度 < @s sc:环境温度 run scoreboard players add @s sc:温度 1
# #[1]
execute as @a if score @s sc:温度 > @s sc:环境温度 run scoreboard players remove @s sc:温度 1