# {"初始方向1": "z+", "初始方向2": "x+", "最大延伸": "25"}
# #(循环)#{20}
# 流血
damage @a[scores={sc:流血=1..,sc:流血等级=1}] 1 entity_attack
# #(连锁)
damage @a[scores={sc:流血=1..,sc:流血等级=2}] 2 entity_attack
damage @a[scores={sc:流血=1..,sc:流血等级=3}] 3 entity_attack
damage @a[scores={sc:流血=1..,sc:流血等级=4}] 4 entity_attack
scoreboard players remove @a[scores={sc:流血=1..}] sc:流血 1
# 上火
effect @a[scores={sc:上火=500..}] poison 5 0 true
effect @a[scores={sc:上火=500..}] slowness 5 0 true
# 中暑
damage @a[scores={sc:中暑=500..}] 1 fire
effect @a[scores={sc:中暑=500..}] nausea 5 0 true
# 感冒
effect @a[scores={sc:感冒=500..}] poison 5 0 true
effect @a[scores={sc:感冒=500..}] slowness 5 0 true
# 发烧
effect @a[scores={sc:发烧=500..}] poison 5 0 true
effect @a[scores={sc:发烧=500..}] nausea 5 0 true
effect @a[scores={sc:发烧=500..}] slowness 5 0 true