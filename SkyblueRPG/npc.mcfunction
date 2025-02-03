# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)
execute as @e[tag=npc] at @s run replaceitem entity @s slot.chest 0 keep minecraft:leather_chestplate
# #(连锁)#[2]
execute as @e[tag=npc,hasitem={location=slot.armor.chest,item=leather_chestplate}] at @s run setblock ~~-2~ minecraft:redstone_block
execute as @e[tag=npc,hasitem={location=slot.armor.chest,item=leather_chestplate}] at @s run replaceitem entity @s slot.armor.chest 0 minecraft:iron_chestplate 1 1000