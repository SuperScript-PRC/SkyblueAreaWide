# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
#
# 机器运行一次
#
# #(循环)#{5}
scoreboard players set @e[tag=st.tick_ok] st:mc_tick 0
# #(连锁)
scoreboard players set @e[tag=st.tick_ok] st:rs_cd 0
tag @e[tag=st.tick_ok] remove st.tick_ok
# 判定机器是否可以生产
execute as @e[scores={st:mc_tick=1..}] unless score @s st:mc_tick < @s st:mc_stick run tag @s add st.tick_ok
# 电力挖石机
execute as @e[tag=st.tick_ok,scores={st:mc_type=11}] at @s if block ~~3~ minecraft:cobblestone run setblock ~~3~ air 0 destroy
execute as @e[tag=st.tick_ok,scores={st:mc_type=11}] at @s run tp @e[y=~3,r=1,name=圆石] @e[r=15,tag=st.collector,c=1]
# 伐木机
execute as @e[tag=st.tick_ok,scores={st:mc_type=5}] at @s run tag @s add st.need_iter
# 需要采矿机