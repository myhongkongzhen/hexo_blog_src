---
title: ELK_batch search_007
categories: technology
date: 2017-07-30 22:23:16
tags:
- Elasticsearch
---
> - Batch query
>  - mget
>  - 

<!--more-->

# _mget
------
```bash
GET /_mget  # different index & type
{
    "docs" : [
        {
            "_index" : "test_index",
            "_type" : "test_type",
            "_id" : "1"
        },
        {
            "_index" : "test_index",
            "_type" : "test_type",
            "_id" : "2"
        }
    ]
}
```
<img src="/images/elasticsearch/019_mget_search.png" />
```bash
GET /test_index/_mget # the same index and different type
{
    "docs" : [
          {
             "_type" :  "test_type",
             "_id" :    1
          },
          {
             "_type" :  "test_type",
             "_id" :    2
          }
    ]
}
```
```bash
GET /test_index/test_type/_mget # the same index & type
{
   "ids": [1, 2]
}
```






