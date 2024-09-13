# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{5}
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=minecraft:hopper_minecart}] at @s positioned ~~1.2~ if block ^^^1.2 minecraft:campfire run tag @s add sc.place_pot
# #(连锁) #[4]
title @a[tag=sc.place_pot] actionbar §a烹饪锅已放置
execute as @a[tag=sc.place_pot] at @s positioned ~~1.3~ run execute as @s run summon minecraft:hopper_minecart ^^^1.2
execute as @a[tag=sc.place_pot] at @s run replaceitem entity @s slot.weapon.mainhand 0 air
tag @a remove sc.place_pot