# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{40}
scoreboard players remove @a[scores={sc:糖类=1..}] sc:糖类 1
# #(循环)#{60}
scoreboard players remove @a[scores={sc:脂肪=1..}] sc:脂肪 1
# #(循环)#{80}
scoreboard players remove @a[scores={sc:蛋白质=1..}] sc:蛋白质 1
# #(循环)#{140}
scoreboard players remove @a[scores={sc:维A=1..}] sc:维A 1
scoreboard players remove @a[scores={sc:维C=1..}] sc:维C 1
# #(循环)#{160}
scoreboard players remove @a[tag=!sc.sick,scores={sc:上火=1..}] sc:上火 1
# #(连锁)
scoreboard players remove @a[tag=!sc.sick,scores={sc:感冒=1..}] sc:感冒 1
scoreboard players remove @a[tag=!sc.sick,scores={sc:发烧=1..}] sc:发烧 1
scoreboard players remove @a[tag=!sc.sick,scores={sc:中暑=1..}] sc:中暑 1
scoreboard players remove @a[tag=!sc.sick,scores={sc:中毒=1..}] sc:中毒 1