# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 机器检查配方, 并进入制作状态
#
# #(循环)#{20}
tag @a remove bag.full
# #(连锁)
replaceitem entity @a slot.inventory 26 keep snowball 1 503 {"minecraft:can_place_on":{"blocks": ["bedrock"]}}
tag @a add bag.full
tag @a[hasitem={item=minecraft:snowball,data=503}] remove bag.full
clear @a minecraft:snowball 503