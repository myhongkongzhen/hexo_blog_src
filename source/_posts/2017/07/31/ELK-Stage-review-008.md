---
title: ELK_Stage review_008
categories: technology
date: 2017-07-31 17:26:42
tags:
- Elasticsearch
---
> Stage review  
> - _Distributed Document Store_
> - **文檔數據存儲系統**
> - 操作JSON文檔類型數據
>   - NOSQL存儲系統

<!--more-->

# Elasticsearch core structure
------
```puml
@startuml

package node_1 <<Frame>>{

    package index-->Database <<Frame>> {
        
        package primary_shard0 <<Frame>>{
            note "one index includes one or more shards " as N1
            
            package type-->Table <<Frame>> {
                    
                package document-->Row <<Frame>> {
                        
                    package field-->Column <<Cloud>>{
                    }
                }
            }
        }
    }
}

package node_2 <<Frame>>{
    package replica_shard0 <<Cloud>>{
    '        note "one or more shards " as N2
    }
}

primary_shard0 ...> replica_shard0 : <color:red><b>Copy and different node.</b></color>

@enduml
```
IMG download => [ES core structure](/images/elasticsearch/020_stage_review.png)

