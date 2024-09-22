# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#[4]
execute as @a[scores={sr:skillmode=0},hasitem={item=minecraft:iron_ingot,data=755,location=slot.weapon.mainhand}] run tellraw @a[tag=sr.rpg_bot] {"rawtext":[{"text":"sr.skill.loaded"},{"selector":"@s"}]}
# #(连锁)
execute as @a[scores={sr:skillmode=0},hasitem={item=minecraft:iron_ingot,data=755,location=slot.weapon.mainhand}] run scoreboard players set @s sr:skillmode 1
execute as @a[scores={sr:skillmode=0},hasitem={item=minecraft:gold_ingot,data=755,location=slot.weapon.mainhand}] run tellraw @a[tag=sr.rpg_bot] {"rawtext":[{"text":"sr.ult.loaded"},{"selector":"@s"}]}
execute as @a[scores={sr:skillmode=0},hasitem={item=minecraft:gold_ingot,data=755,location=slot.weapon.mainhand}] run scoreboard players set @s sr:skillmode 2
