# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{20}
# 感冒灵
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=ghast_tear,data=507},scores={sc:感冒=500..}] run scoreboard players remove @s sc:感冒 50
# #(连锁)#[1]
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=ghast_tear,data=507}] run clear @s ghast_tear 507 1
# 降火胃片
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=turtle_shell_piece,data=509},scores={sc:感冒=500..}] run scoreboard players remove @s sc:上火 50
# #[1]
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=turtle_shell_piece,data=509}] run clear @s turtle_shell_piece 509 1
# 家用绷带
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=feather,data=512},scores={sc:流血等级=1..2,sc:流血时间=1..}] run scoreboard players set @s sc:流血 0
# #[1]
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=feather,data=512}] run clear @s feather 512 1
# 医用绷带
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=paper,data=513},scores={sc:流血等级=1..,sc:流血时间=1..}] run scoreboard players set @s sc:流血 0
# #[1]
execute as @a[tag=shift,hasitem={slot=slot.weapon.mainhand,item=paper,data=513}] run clear @s paper 513 1