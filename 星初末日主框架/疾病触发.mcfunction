# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{40}
# 低温
execute as @a[scores={sc:体温=..-20,sc:感冒=..980}] run scoreboard players add @s sc:感冒 2
# 高温
execute as @a[scores={sc:体温=20..,sc:中暑=..980}] run scoreboard players add @s sc:中暑 2
