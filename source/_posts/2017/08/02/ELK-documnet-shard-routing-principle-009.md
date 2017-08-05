---
title: ELK_documnet & shard routing principle_009
categories:
  - technology
tags: [Elasticsearch]
date: 2017-08-02 23:50:27
---
> Document Routing principle 

<!--more-->

# Document Routing
------
- When client creates document, ES determines which shard of index the document is in. 
- Routing algorithm 
    - **```shard = hash ( routing ) % number_of_primary_shards```**
        - routing = routing id , ex : document_id ( default num , _you can be manually specified_. )
        - hash ( routing) = hash ( document_id ) : hash code
        - mod ( num of primary shards ) -> result is always from **zero** to [ **number_of_primary_shards - 1** ]
        - routing algorithm is base on primary shard.
        
# Document 'CUD' flow 
------
- 'CUD' operating locate on primary shard.
```puml
@startuml

package node_0 <<Frame>>{
	package primary_phard_0 <<Frame>>{
		note "P0" as p0
	}
	
	package replica_shard_2 <<Frame>>{
		note "R2" as r2
	}
}

package node_1 <<Frame>>{
	package primary_phard_1 <<Frame>>{
		note "P1" as p1
	}
	
	package replica_shard_0 <<Frame>>{
		note "R0" as r0
	}
}

package node_2 <<Frame>>{
	package primary_phard_2 <<Frame>>{
		note "P2" as p2
	}
	
	package replica_shard_1 <<Frame>>{
		note "R1" as r1
	}
}

package client <<Frame>>{
	note "client java programming" as java
}

client --> node_1 : <b><color:blue>1.Select ES node

note as c
	<size:20>coordinate node 協調節點
end note

c -> node_1

node_1 --> primary_phard_2 : <b><color:red>2.Routing to primary shard\n<b><color:red> 3.Create document / index in local

primary_phard_2 --> replica_shard_2 : <b><color:green>4.Find its replica shard\n<b><color:green> 5.Synchronize document to replica shard

node_1 --> client : <b>response to client</b>

@enduml

```


