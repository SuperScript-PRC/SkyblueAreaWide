# 机器多方科结构判定
#
# #(循环)#{5}
tag @e[tag=st.iter] add st.iter_ok
# #(连锁)
tag @e[tag=st.iter] remove st.iter
execute as @e[tag=st.iter_ok,c=1] unless entity @e[tag=st.need_iter,tag=!st.iter_ok] run tag @e[tag=st.iter_ok] remove st.iter_ok
execute as @e[tag=st.need_iter,c=1] if entity @e[tag=st.need_iter,tag=!st.iter_ok] run tag @e[c=1,tag=st.need_iter,tag=!st.iter_ok] add st.iter
# 开始识别
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run clone ~-2~5~-2~2~12~2 123457 89 123457 filtered move log
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run clone ~-2~4~-2~2~4~2 123457 89 123457 filtered normal log
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run clone ~-2~5~-2~2~12~2 123457 89 123457 filtered move log2
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run clone ~-2~4~-2~2~4~2 123457 89 123457 filtered normal log2
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run clone ~-2~5~-2~2~12~2 123457 89 123457 filtered move leaves
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run clone ~-2~5~-2~2~12~2 123457 89 123457 filtered move leaves2
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run fill ~-2~4~-2 ~2~4~2 sapling 0 replace log 0
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run fill ~-2~4~-2 ~2~4~2 sapling 1 replace log 1
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run fill ~-2~4~-2 ~2~4~2 sapling 2 replace log 2
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run fill ~-2~4~-2 ~2~4~2 sapling 3 replace log 3
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run fill ~-2~4~-2 ~2~4~2 sapling 4 replace log2
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run fill ~-2~4~-2 ~2~4~2 sapling 5 replace log2 1
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run fill ~-2~4~-2 ~2~4~2 air 0 replace log
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run fill ~-2~4~-2 ~2~4~2 air 0 replace log2
execute as @e[tag=st.iter,scores={st:mc_type=5}] run fill 123457 89 123457 123461 98 123461 air 0 destroy
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run tp @e[x=123457,y=89,z=123457,dx=4,dy=12,dz=4,type=item] ~~~
execute as @e[tag=st.iter,scores={st:mc_type=5}] at @s run tp @e[r=1,type=item] @e[c=1,r=15,tag=st.collector]
tag @e[tag=st.iter,scores={st:mc_type=5}] remove st.need_iter