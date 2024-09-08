# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(脉冲)#$1
scoreboard players set 实体数量 st:constant 0
# #(连锁)
scoreboard players set 机器数量 st:constant 0
scoreboard players set 箱子矿车数量 st:constant 0
scoreboard players set 生物数量 st:constant 0
execute as @e[tag=st.machine] run scoreboard players add 机器数量 st:constant 1
execute as @e[type=minecraft:chest_minecart] run scoreboard players add 机器数量 st:constant 1
execute as @e[family=mob] run scoreboard players add 生物数量 st:constant 1
execute as @e run scoreboard players add 实体数量 st:constant 1
tellraw @a { "rawtext": [ { "text": "§b机器总数： " }, { "score": {"name": "机器数量", "objective": "st:constant" } } ] }
tellraw @a { "rawtext": [ { "text": "§c箱子矿车总数： " }, { "score": {"name": "箱子矿车数量", "objective": "st:constant" } } ] }
tellraw @a { "rawtext": [ { "text": "§d生物总数： " }, { "score": {"name": "生物数量", "objective": "st:constant" } } ] }
tellraw @a { "rawtext": [ { "text": "§e实体总数： " }, { "score": {"name": "实体数量", "objective": "st:constant" } } ] }