# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 机器多方科结构判定
#
# #(循环)#{40}
tag @e[tag=st.machine] remove st.machine
# #(连锁)
tag @e[type=minecraft:chest_minecart,hasitem={item=minecraft:redstone_torch,data=715}] add st.machine
scoreboard players set @e[tag=st.machine] st:circuit 0
# 电路板等级
scoreboard players set @e[tag=st.machine,hasitem={item=ward_armor_trim_smithing_template,data=701}] st:circuit 1
scoreboard players set @e[tag=st.machine,hasitem={item=host_armor_trim_smithing_template,data=702}] st:circuit 2
scoreboard players set @e[tag=st.machine,hasitem={item=tide_armor_trim_smithing_template,data=703}] st:circuit 3
scoreboard players set @e[tag=st.machine,hasitem={item=dune_armor_trim_smithing_template,data=704}] st:circuit 4
# 加热器等级
scoreboard players set @e[tag=st.machine] st:heater 0
scoreboard players set @e[tag=st.machine,hasitem={item=music_disc_relic,data=716}] st:heater 1
scoreboard players set @e[tag=st.machine,hasitem={item=music_disc_blocks,data=720}] st:heater 2
scoreboard players set @e[tag=st.machine,hasitem={item=music_disc_chirp,data=726}] st:heater 3
scoreboard players set @e[tag=st.machine] st:mc_type 0
# 电池
tag @e[tag=st.dc] remove st.dc
execute as @e[type=chest_minecart] at @s if block ~~-1~ minecraft:lit_redstone_lamp run tag @s add st.dc
# 太阳能电池板=1
execute as @e[tag=st.machine] at @s if blocks 123456 115 123456 123458 118 123458 ~-1~-4~-1 masked run scoreboard players set @s st:mc_type 1
execute as @e[tag=st.machine,scores={st:mc_type=0}] at @s if blocks 123459 115 123456 123461 118 123458 ~-1~-4~-1 masked run scoreboard players set @s st:mc_type 1
# 打粉机=2
execute as @e[tag=st.machine,scores={st:mc_type=0,st:circuit=1..}] at @s if block ~~1~ minecraft:dropper if blocks 123463 115 123457 123465 118 123457 ~-1~-1~ masked run scoreboard players set @s st:mc_type 2
execute as @e[tag=st.machine,scores={st:mc_type=0,st:circuit=1..}] at @s if block ~~1~ minecraft:dropper if blocks 123466 115 123456 123466 118 123458 ~~-1~-1 masked run scoreboard players set @s st:mc_type 2
# 电炉=3
execute as @e[tag=st.machine,scores={st:mc_type=0,st:circuit=1..}] at @s if block ~~-1~ minecraft:target if block ~~-2~ hopper if block ~~-3~ furnace run scoreboard players set @s st:mc_type 3
# 多功能炉=4
execute as @e[tag=st.machine,scores={st:heater=1..,st:mc_type=0,st:circuit=1..}] at @s if block ~~1~ dropper ["facing_direction"=0] if blocks 123468 115 123457 123470 118 123457 ~-1~-1~ masked run scoreboard players set @s st:mc_type 4
execute as @e[tag=st.machine,scores={st:heater=1..,st:mc_type=0,st:circuit=1..}] at @s if block ~~1~ dropper ["facing_direction"=0] if blocks 123471 115 123456 123471 118 123458 ~~-1~-1 masked run scoreboard players set @s st:mc_type 4
# 伐木机=5
execute as @e[tag=st.machine,hasitem={item=iron_axe,data=730},scores={st:mc_type=0,st:circuit=1..}] at @s if block ~~-1~ minecraft:target if block ~~1~ minecraft:stonecutter_block if block ~~2~ minecraft:dirt run scoreboard players set @s st:mc_type 5
execute as @e[tag=st.machine,hasitem={item=iron_axe,data=730},scores={st:mc_type=0,st:circuit=1..}] at @s if block ~~-1~ minecraft:target if block ~~1~ minecraft:stonecutter_block if block ~~2~ minecraft:dirt run scoreboard players set @s st:mc_type 5
execute as @e[tag=st.machine,hasitem={item=iron_axe,data=730},scores={st:mc_type=0}] at @s if block ~~-1~ minecraft:target if block ~~1~ minecraft:stonecutter_block if block ~~2~ minecraft:stonecutter_block run scoreboard players set @s st:mc_type 5
# 火力发电机=6
execute as @e[tag=st.machine,scores={st:mc_type=0}] at @s if block ~~-1~ target if block ~~-2~ minecraft:furnace run scoreboard players set @s st:mc_type 6
execute as @e[tag=st.machine,scores={st:mc_type=0}] at @s if block ~~-1~ target if block ~~-2~ minecraft:lit_furnace run scoreboard players set @s st:mc_type 6
# 种植站=7
execute as @e[tag=st.machine,hasitem={item=iron_hoe,data=729},scores={st:mc_type=0,st:circuit=1..}] at @s if block ~~-2~ minecraft:water if block ~~-1~ minecraft:target run scoreboard players set @s st:mc_type 7
# 虚空采矿机=8
execute as @e[tag=st.machine,hasitem={item=flint,data=705},scores={st:mc_type=0,st:circuit=3..}] at @s if blocks 123473 115 123456 123479 118 123462 ~-3~-4~-3 masked run scoreboard players set @s st:mc_type 8
# 压缩机=9
execute as @e[tag=st.machine,scores={st:mc_type=0,st:circuit=1..}] at @s if block ~~1~ minecraft:dropper ["facing_direction"=0] if blocks 123481 115 123459 123483 118 123459 ~-1~-1~ masked run scoreboard players set @s st:mc_type 9
execute as @e[tag=st.machine,scores={st:mc_type=0,st:circuit=1..}] at @s if block ~~1~ minecraft:dropper ["facing_direction"=0] if blocks 123484 115 123458 123484 118 123460 ~~-1~-1 masked run scoreboard players set @s st:mc_type 9
# 地热发电机=10
execute as @e[tag=st.machine,scores={st:mc_type=0},hasitem={item=brick,data=732}] at @s if block ~~1~ minecraft:dropper ["facing_direction"=0] if block ~~-2~ minecraft:hopper if blocks 123456 115 123460 123458 118 123462 ~-1~-1~-1 masked run scoreboard players set @s st:mc_type 10
# 电力挖石机=11
execute as @e[tag=st.machine,scores={st:mc_type=0,st:circuit=1..},hasitem={item=minecraft:flint,data=706}] at @s if block ~~-1~ minecraft:target if block ~~1~ minecraft:piston ["facing_direction"=1] if block ~~2~ minecraft:stonecutter_block run scoreboard players set @s st:mc_type 11
# 感应炉=12
execute as @e[tag=st.machine,scores={st:mc_type=0,st:heater=1..,st:circuit=1..}] at @s if block ~~-1~ minecraft:dropper ["facing_direction"=1] if block ~~1~ minecraft:blast_furnace if block ~~3~ minecraft:target if entity @e[y=~2,r=1,type=minecraft:hopper_minecart] if blocks ~~-1~ ~~-1~ 123456 100 123456 all run scoreboard players set @s st:mc_type 12