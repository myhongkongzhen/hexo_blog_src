---
title: ELK_Elasticsearch core structure_004
categories: technology
date: 2017-07-29 22:59:21
tags:
- Elasticsearch
---
> - 擴容對應用程序的透明性
>  - 垂直擴容與水平擴容
>  - 保持負載均衡
> - Master node
>  - 節點對等，每個節點都能接收所有請求

<!--more-->

# Shard & Replica
------
- One index includes one shard or more shard.
    - When we create index, we set 3(ex) primary shard, then ES cluster can be balance for every shard.
- Every shard is a minimum working unit, which is a lucene instance.
- Every document is in the one primary shard and its replica shard.
- We cannot edit the number of primary shard , but can edit the number of replica shard.
- The same primary shard and replica shard cannot be in the same node.

# Create index
------
## Under the single node
```bash
PUT /test_index
{
    "settings" : {
        "number_of_shards" : 3,
        "number_of_replicas" : 1 // Every primary shard has one replica shard.
    }
}
```

## Under the two nodes
- Primary shard(node 1) data copy to replica shard(node 2).

# 横向擴容
------
（1）primary&replica自动负载均衡，6个shard，3 primary，3 replica
（2）每个node有更少的shard，IO/CPU/Memory资源给每个shard分配更多，每个shard性能更好
（3）扩容的极限，6个shard（3 primary，3 replica），最多扩容到6台机器，每个shard可以占用单台服务器的所有资源，性能最好
（4）超出扩容极限，动态修改replica数量，9个shard（3primary，6 replica），扩容到9台机器，比3台机器时，拥有3倍的读吞吐量
（5）3台机器下，9个shard（3 primary，6 replica），资源更少，但是容错性更好，最多容纳2台机器宕机，6个shard只能容纳1台机器宕机
<img src="/images/elasticsearch/011_橫向擴容.png"  />

# 容錯
------
- 自動選舉一個node為新的master，承擔master的責任
- 新的master將丟失的primary shard的某個replica shard提升為primary shard
    - Cluster status is yellow now. (P1,P2,P3 primary shard is active, but P1 miss one replica shard copy.)
- Restart downtime node.
    - 新的master會將丟失的副本copy一份到此節點上，該node會使用之前已有的shard數據，只同步一下宕機之後發生的修改.
    - Cluster status becomes green now.






















