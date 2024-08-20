# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 地热发电机控制
# (循环)
execute as @e[scores={st:mc_type=6,heatgen_cd=0..40}] at @s run replaceitem block ~~-2~ slot.container 0 minecraft:iron_shovel 1 1000 {"item_lock":{"mode":"lock_in_slot"}}
# (连锁)
execute as @e[scores={st:mc_type=6}] at @s run replaceitem block ~~-2~ slot.container 2 air