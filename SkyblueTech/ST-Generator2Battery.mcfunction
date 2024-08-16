# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
# #(循环)#{4}
tag @e[tag=st.dc_active] remove st.dc_active
# #(连锁)
# 发电机发电
execute as @e[scores={st:gen_tick=1..}] at @s run scoreboard players operation @e[c=1,tag=st.dc] st:mc_rf += @s st:gen_rfp
execute as @e[scores={st:gen_tick=1..}] at @s run scoreboard players remove @s st:gen_tick 1
# 电池供能
execute as @e[tag=st.dc,scores={st:mc_rf=100..}] at @s if score @e[c=1,scores={st:mc_mcp=1..}] st:mc_rf < @e[c=1,scores={st:mc_mcp=1..}] st:mc_srf run tag @s add st.dc_active
execute as @e[tag=st.dc_active] at @s run scoreboard players remove @s st:mc_rf 100
execute as @e[tag=st.dc_active] at @s run scoreboard players add @e[c=1,scores={st:mc_mcp=1..}] st:mc_rf 100
# #(循环)#{40}
# 火力发电机发电控制
execute as @e[scores={st:mc_type=6}] at @s if block ~~-2~ minecraft:lit_furnace [] run scoreboard players add @s st:heatgen_cd 1
# #(连锁)
execute as @e[scores={st:mc_type=6}] at @s if block ~~-2~ minecraft:furnace [] run scoreboard players set @s st:heatgen_cd 0
scoreboard players set @e[scores={st:mc_type=6}] st:gen_rfp 0
scoreboard players set @e[scores={st:mc_type=6}] st:gen_tick 0
execute as @e[scores={st:mc_type=6,st:heatgen_cd=0..40}] at @s if block ~~-2~ minecraft:lit_furnace [] run scoreboard players set @s st:gen_rfp 80
execute as @e[scores={st:mc_type=6,st:heatgen_cd=0..40}] at @s if block ~~-2~ minecraft:lit_furnace [] run scoreboard players set @s st:gen_tick 10
# 地热发电机发电控制
execute as @e[scores={st:mc_type=10,st:gen_tick=0},hasitem={item=minecraft:lava_bucket,data=0,slot=0,quantity=1,location=slot.inventory}] at @s run replaceitem block ~~-1~ slot.container 0 minecraft:bucket
execute as @e[scores={st:mc_type=10,st:gen_tick=0},hasitem={item=minecraft:lava_bucket,data=0,slot=0,quantity=1,location=slot.inventory}] at @s run scoreboard players set @s st:gen_tick 400
execute as @e[scores={st:mc_type=10,st:gen_tick=1..},hasitem={item=minecraft:lava_bucket,data=0,slot=0,quantity=1,location=slot.inventory}] at @s run replaceitem entity @s slot.inventory 0 air