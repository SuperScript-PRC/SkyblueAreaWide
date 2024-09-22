# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)
testfor @a[tag=sr.player_atk]
# #(连锁)#[1]
setblock ~~~1 minecraft:chain_command_block ["facing_direction"=3]
say inited!
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=1}] slot.hotbar 0 minecraft:wooden_sword 1 10000
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=3}] slot.hotbar 0 minecraft:iron_sword 1 10000
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=4}] slot.hotbar 0 minecraft:golden_sword 1 10000
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=5}] slot.hotbar 0 minecraft:diamond_sword 1 10000
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=6}] slot.hotbar 0 minecraft:netherite_sword
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=7}] slot.hotbar 0 minecraft:wooden_axe 1 10000
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=15}] slot.hotbar 0 minecraft:wooden_pickaxe 1 10000
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=24}] slot.hotbar 0 minecraft:wooden_shovel 1 10000
replaceitem entity @a[tag=sr.player_atk,scores={sr:mh_arm=48}] slot.hotbar 0 minecraft:trident 1 10000