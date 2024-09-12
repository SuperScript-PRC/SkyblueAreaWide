# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{20}
# 烹饪牛排
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=cooked_beef,data=515},scores={sc:感冒=500..}] run scoreboard players add @s sc:蛋白质 60
# #(连锁)#[2]
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=cooked_beef,data=515}] run scoreboard players add @s sc:脂质 40
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=cooked_beef,data=515}] run clear @s cooked_beef 515 1