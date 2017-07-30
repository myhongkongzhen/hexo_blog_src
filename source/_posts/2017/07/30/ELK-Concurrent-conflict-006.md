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
## internal _version
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
```bash
PUT /test_index/test_type/7?version=2
{ 
  "test_field":"test field 7.1"
}
```
<img src="/images/elasticsearch/017_version_update.png"  />
<img src="/images/elasticsearch/017_version_update_02.png"  />

## external version
> - ?version=1**&version_type=external**
>   - es, _version=1, ?version=1 ==> update success
>   - es, _version=1, ?version **>1** &version_type=external ==> update success

## Partial update && Optimistic lock
> retry strategy
> - retry_on_conflict : retry times

```bash
POST /test_index/test_type/id/_update?retry_on_conflict=5&version=6
```


