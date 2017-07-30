---
title: ELK_Concurrent conflict_006
categories: technology
date: 2017-07-30 14:44:47
tags:
- Elasticsearch
---
> - Pessimistic lock
>   - Relational Database
>       - ex : MySQL
> - Optimistic lock
>   - ex : Elasticsearch 

<!--more-->

# Lock
------
- Pessimistic lock 
    - Any time it lock, only one thread can operate data.
- Optimistic lock 
    - Any time it unlock, every thread can operate data, but it has a version info.

# _version 
------
```bash
{
  "_index": "test_index",
  "_type": "test_type",
  "_id": "4",
  "_version": 1, # any operating , plus 1 (include DELETE, Not physically deleted)
  "result": "created",
  "_shards": {
    "total": 2,
    "successful": 1,
    "failed": 0
  },
  "created": true
}
```
