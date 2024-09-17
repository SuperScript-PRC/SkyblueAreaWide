# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{20}
# 感冒灵
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=ghast_tear,data=507},scores={sc:感冒=500..}] run scoreboard players remove @s sc:感冒 50
# #(连锁)#[3]
title @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=ghast_tear,data=507}] actionbar §7服用了§f感冒灵§7， 感觉好多了..
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=ghast_tear,data=507}] at @s run playsound mob.horse.eat @s
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=ghast_tear,data=507}] run clear @s ghast_tear 507 1
# 降火胃片
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=turtle_shell_piece,data=509},scores={sc:感冒=500..}] run scoreboard players remove @s sc:上火 50
# #[3]
title @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=turtle_shell_piece,data=509}] actionbar §7服用了§f降火胃片§7， 感觉好多了..
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=turtle_shell_piece,data=509}] at @s run playsound mob.horse.eat @s
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=turtle_shell_piece,data=509}] run clear @s turtle_shell_piece 509 1
# 家用绷带
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=feather,data=512},scores={sc:流血等级=1..2,sc:流血时间=1..}] run scoreboard players set @s sc:流血 0
# #[2]
title @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=feather,data=512}] actionbar §7使用了§f家用绷带§7， 感觉好多了..
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=feather,data=512}] run clear @s feather 512 1
# 医用绷带
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=paper,data=513},scores={sc:流血等级=1..,sc:流血时间=1..}] run scoreboard players set @s sc:流血 0
# #[2]
title @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=paper,data=513}] actionbar §7使用了§f医用绷带§7， 感觉好多了..
execute as @a[tag=shift,hasitem={location=slot.weapon.mainhand,item=paper,data=513}] run clear @s paper 513 1

