# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "100"}
# #(循环)#{5}
testfor @e[tag=st.tick_ok,scores={st:mc_type=16}]
# #(连锁) #[1]
setblock ~~~1 minecraft:chain_command_block 3
1
setblock ~~~-1 air
# 鸡
execute as @e[tag=st.tick_ok,scores={st:mc_type=16}] at @s if entity @e[y=~4,r=1,type=minecraft:chicken] run scoreboard players set @s st:runid 1
# #[1]
execute as @e[tag=st.tick_ok,scores={st:mc_type=16,st:runid=1}] at @s run loot spawn ~~~ loot "entities/chicken"
# 牛
execute as @e[tag=st.tick_ok,scores={st:mc_type=16}] at @s if entity @e[y=~4,r=1,type=minecraft:cow] run scoreboard players set @s st:runid 2
# #[1]
execute as @e[tag=st.tick_ok,scores={st:mc_type=16,st:runid=2}] at @s run loot spawn ~~~ loot "entities/cow"
# 羊
execute as @e[tag=st.tick_ok,scores={st:mc_type=16}] at @s if entity @e[y=~4,r=1,type=minecraft:sheep] run scoreboard players set @s st:runid 3
# #[1]
execute as @e[tag=st.tick_ok,scores={st:mc_type=16,st:runid=3}] at @s run loot spawn ~~~ loot "entities/sheep"
# 猪
execute as @e[tag=st.tick_ok,scores={st:mc_type=16}] at @s if entity @e[y=~4,r=1,type=minecraft:pig] run scoreboard players set @s st:runid 4
# #[1]
execute as @e[tag=st.tick_ok,scores={st:mc_type=16,st:runid=4}] at @s run loot spawn ~~~ loot "entities/pig"
# 兔
execute as @e[tag=st.tick_ok,scores={st:mc_type=16}] at @s if entity @e[y=~4,r=1,type=minecraft:rabbit] run scoreboard players set @s st:runid 5
# #[1]
execute as @e[tag=st.tick_ok,scores={st:mc_type=16,st:runid=5}] at @s run loot spawn ~~~ loot "entities/rabbit"
execute as @e[tag=st.tick_ok,scores={st:mc_type=16}] at @s run tp @e[r=1,type=item] @e[c=1,tag=st.collector]