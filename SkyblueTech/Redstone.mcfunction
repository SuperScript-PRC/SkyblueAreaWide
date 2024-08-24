# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 机器投料口的红石触发
#
# #(循环)#{4}
tag @e[tag=st.rs_trig] remove st.rs_trig
# #(连锁)
scoreboard players remove @e[scores={st:rs_cd=1..}] st:rs_cd 1
# 反向检测槽位为空
replaceitem entity @e[scores={st:rs_cd=0,st:gen_tick=0,st:mc_type=1..}] slot.inventory 0 keep minecraft:snowball 1 756
tag @e[scores={st:rs_cd=0},hasitem={item=minecraft:snowball,slot=0,location=slot.inventory,data=756}] add st.rs_trig
replaceitem entity @e[tag=st.trig] slot.inventory 0 air
execute as @e[tag=st.rs_trig,scores={st:mc_type=2}] at @s run scoreboard players set @s st:rs_place 1
execute as @e[tag=st.rs_trig,scores={st:mc_type=4}] at @s run scoreboard players set @s st:rs_place 1
execute as @e[tag=st.rs_trig,scores={st:mc_type=9}] at @s run scoreboard players set @s st:rs_place 1
execute as @e[tag=st.rs_trig,scores={st:mc_type=10}] at @s run scoreboard players set @s st:rs_place 1
execute as @e[tag=st.rs_trig,scores={st:mc_type=12}] at @s run scoreboard players set @s st:rs_place 2
execute as @e[tag=st.rs_trig,scores={st:mc_type=13}] at @s run scoreboard players set @s st:rs_place 1
execute as @e[scores={st:rs_place=1}] at @s run setblock ~~2~ minecraft:redstone_block
execute as @e[scores={st:rs_place=2}] at @s run setblock ~~3~ minecraft:redstone_block
# #{2}
execute as @e[scores={st:rs_place=1}] at @s run setblock ~~2~ minecraft:target
execute as @e[scores={st:rs_place=2}] at @s run setblock ~~3~ minecraft:target
scoreboard players set @e[scores={st:rs_place=1..}] st:rs_place 0
scoreboard players set @e[tag=st.rs_trig,scores={st:mc_type=1..}] st:rs_cd 20