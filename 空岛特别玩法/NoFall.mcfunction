# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "20"}
#
# 防止玩家落入虚空
# 落入后拉回到世界最上端
# TODO: 也许会有人利用这个跑出很远很远的距离..
#
# #(循环)#{5}
execute as @a[m=!1] at @s if entity @s[x=~-1,y=-64,z=~-1,dx=2,dy=30,dz=2] run effect @s resistance 3 255 true
# #(连锁)#[1]
execute as @a[m=!1] at @s if entity @s[x=~-1,y=-64,z=~-1,dx=2,dy=30,dz=2] run tp ~ 320 ~