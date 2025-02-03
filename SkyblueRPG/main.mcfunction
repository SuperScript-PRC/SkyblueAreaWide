# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)
# PVE
tag @e[tag=sr.hurted] remove sr.hurted
# #(连锁)
tag @a[tag=sr.player_atk] remove sr.player_atk
# 玩家攻击
replaceitem entity @a[scores={sr:mh_weapon=1..}] slot.hotbar 0 keep minecraft:snowball 1 668
tag @a[hasitem={location=slot.hotbar,slot=0,item=minecraft:snowball,data=668}] add sr.player_atk
# 玩家受伤
execute as @a unless entity @s[hasitem={item=leather_helmet,location=slot.armor.head}] run tag @s add sr.hurted
execute as @a[tag=sr.hurted] at @s if entity @e[r=5,tag=sr.mob,type=!player] run tellraw @a[tag=sr.rpg_bot] {"rawtext":[{"text":"sr.mob.attack.player"},{"selector":"@s"},{"score":{"name":"@e[r=5,tag=sr.mob,c=1]","objective":"sr:ms_uuid"}}]}
# 生物受伤
execute as @e[tag=sr.mob] unless entity @s[hasitem={item=leather_helmet,location=slot.armor.head}] run tag @s add sr.hurted
execute as @e[tag=sr.hurted,tag=sr.mob] at @s if entity @a[r=10,tag=sr.player_atk] run tellraw @a[tag=sr.rpg_bot] {"rawtext":[{"text":"sr.player.attack.mob"},{"selector":"@a[c=1]"},{"score":{"name":"@s","objective":"sr:ms_uuid"}}]}
replaceitem entity @e[tag=sr.hurted] slot.armor.head 0 minecraft:leather_helmet 1 1000 {"item_lock":{"mode": "lock_in_slot"},"keep_on_death":{}}