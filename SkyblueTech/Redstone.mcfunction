# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 机器投料口的红石触发
#
# #(循环)#{5}
tag @e[tag=st.empty] remove st.empty
# #(连锁)
scoreboard players remove @e[scores={st:rs_cd=1..}] st:rs_cd 1
# 反向检测槽位为空
replaceitem entity @e[scores={st:rs_cd=0,st:gen_tick=0,st:mc_type=1..}] slot.inventory 0 keep minecraft:snowball 1 756 {"minecraft:can_place_on":{"blocks":["bedrock"]}}
tag @e[scores={st:rs_cd=0},hasitem={item=minecraft:snowball,slot=0,location=slot.inventory,data=756}] add st.empty
replaceitem entity @e[tag=st.empty] slot.inventory 0 air
# 感谢 Wooden_pickaxe 的帮助, 使用雪球激活
execute as @e[tag=st.empty] at @s run summon minecraft:snowball ~~3~
scoreboard players set @e[tag=st.empty] st:rs_cd 20