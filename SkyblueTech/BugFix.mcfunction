# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 漏洞修复
#
# #(循环)#{160}
# 防止机器堆叠
scoreboard players set @e[tag=st.machine] st:nostack 0
# #(连锁)
execute as @e[tag=st.machine] at @s run scoreboard players add @e[r=1,tag=st.machine] st:nostack 1
kill @e[tag=st.machine,scores={st:nostack=2..}]