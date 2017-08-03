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



- _Continue_
