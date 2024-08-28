# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 清除无用实体
#
# #(循环)#{6000}
tellraw @a {"rawtext":[{"text":"[§d扫地姬§f] §660秒后清除无用实体了哦"}]}
# #(连锁)
# #{600}
tellraw @a {"rawtext":[{"text":"[§d扫地姬§f] §630秒后清除无用实体了哦"}]}
# #{400}
tellraw @a {"rawtext":[{"text":"[§d扫地姬§f] §610秒后清除无用实体了哦"}]}
# #{200}
tellraw @a {"rawtext":[{"text":"[§d扫地姬§f] §6开始清除多余实体~"}]}
execute as @e[type=mob,type=!player,type=!npc,type=!villager,type=!wither,type=!ender_dragon,tag=!entity.protect] at @s run tp ~ -100 ~
tellraw @a {"rawtext":[{"text":"[§d扫地姬§f] §6清理完啦， 感觉游戏又流畅了呢~"}]}