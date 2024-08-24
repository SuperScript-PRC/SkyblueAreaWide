# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 火力发电机自动给料以提供被燃烧物, 同时防止玩家拿走其给料产物
# #(循环)
execute as @e[scores={st:mc_type=6,st:heatgen_cd=0..35}] at @s run replaceitem block ~~-2~ slot.container 0 minecraft:chorus_fruit 1 1000 {"item_lock":{"mode":"lock_in_slot"}}
# #(连锁)
execute as @e[scores={st:mc_type=6}] at @s run replaceitem block ~~-2~ slot.container 2 air
# #(循环){40}
clear @a minecraft:chorus_fruit 1000
# #(连锁)
clear @a minecraft:chorus_fruit_popped