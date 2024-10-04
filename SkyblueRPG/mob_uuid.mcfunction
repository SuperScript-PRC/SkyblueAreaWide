# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)
testfor @e[tag=sr.mob_uninited]
# #(连锁)#[4]
scoreboard players add uuid sr:ms_uuid 1
scoreboard players operation @e[tag=sr.mob_uninited,c=1] sr:ms_uuid = uuid sr:ms_uuid
execute as @e[tag=sr.mob_uninited,c=1] run tellraw @a[tag=sr.rpg_bot] {"rawtext":[{"text":"sr.mob.spawn"},{"score":{"name":"@s","objective":"sr:ms_type"}},{"score":{"name":"@s","objective":"sr:ms_uuid"}}]} 
tag @e[tag=sr.mob_uninited,c=1] add sr.mob
tag @e[tag=sr.mob] remove sr.mob_uninited