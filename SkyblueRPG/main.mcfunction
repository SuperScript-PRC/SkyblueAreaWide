# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)
# PVE
tag @e[tag=sr.hurted] remove sr.hurted
# #(连锁)
tag @a[tag=sr.player_atk] remove sr.player_atk
# 玩家攻击
replaceitem entity @a[scores={sr:mh_weapon=1..}] slot.hotbar 0 keep minecraft:snowball 1 668
tag @a[hasitem={location=slot.hotbar,slot=0,item=minecraft:snowball,data=668}] add sr.player_atk
# 受伤
replaceitem entity @e[tag=sr.entity] slot.armor.feet 0 keep minecraft:snowball 1 667
tag @e[tag=sr.entity,hasitem={location=slot.armor.feet,item=minecraft:snowball,data=667}] add sr.hurted
replaceitem entity @e[tag=sr.hurted] slot.armor.feet 0 minecraft:leather_boots 1 1000 {"item_lock":{"mode": "lock_in_slot"},"keep_on_death":{}}
execute as @e[tag=sr.hurted,type=!player] at @s if entity @a[r=10,tag=sr.player_atk] run tellraw @a[tag=sr.rpg_bot] {"rawtext":[{"text":"sr.player.attack.mob"},{"selector":"@a[c=1]"},{"score":{"name":"@s","objective":"sr:ms_uuid"}}]}
execute as @a[tag=sr.hurted] at @s if entity @e[r=5,tag=sr.mob,type=!player] run tellraw @a[tag=sr.rpg_bot] {"rawtext":[{"text":"sr.mob.attack.player"},{"selector":"@s"},{"score":{"name":"@e[r=5,tag=sr.mob,type=!player]","objective":"sr:ms_uuid"}}]}