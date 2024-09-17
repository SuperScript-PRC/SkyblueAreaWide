# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{0}
tag @a[tag=shift] remove shift
# #(连锁)
execute as @a at @s if entity @a[y=~1.49,dy=1] unless entity @s[y=~1.51,dy=1] run tag @s add shift