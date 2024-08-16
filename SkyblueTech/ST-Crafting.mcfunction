# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{10}
tag @a[tag=st.crafting] remove st.crafting
execute as @a at @s if block ~~-1~ minecraft:dropper if block ~~-2~ minecraft:crafting_table run setblock 123497 106 123458 minecraft:chain_command_block 3
# #(连锁)#
1
setblock ~~~-1 minecraft:air
execute as @a at @s if block ~~-1~ minecraft:dropper if block ~~-2~ minecraft:crafting_table run tag @s add st.crafting
execute as @a[tag=st.crafting] at @s if blocks ~~-1~ ~~-1~ 123497 107 123461 all run clone 123497 108 123461 123497 108 123461 ~~-1~
