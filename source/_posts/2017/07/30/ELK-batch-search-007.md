---
title: ELK_batch search_007
categories: technology
date: 2017-07-30 22:23:16
tags:
- Elasticsearch
---
> - Batch query
>  - mget
>  - bulk 

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

# _bulk
------
## grammar
```bash
POST /_bulk
{
    {"action": {"metadata"}}
    {"data"}
}
POST /test_index/_bulk
POST /test_index/test_type/_bulk
```

## operating types
- delete : delete document
- create : PUT /index/type/id/_create
- index : PUT /index/type/id, create document or full replace document
- update : partial update

## show case
```bash
POST /_bulk
{ "delete" : { "_index" : "test_index", "_type" : "test_type", "_id" : 11 } }
{ "create" : { "_index" : "test_index", "_type" : "test_type", "_id" : 10 } }
{ "test_field" : "test content 10" }
{ "create" : { "_index" : "test_index", "_type" : "test_type", "_id" : 10 } }
{ "test_field" : "test content 10" }
{ "index" : { "_index" : "test_index", "_type" : "test_type", "_id" : 9 } }
{ "test_field" : "test content 9" }
{ "index" : { "_index" : "test_index", "_type" : "test_type", "_id" : 9 } }
{ "test_field" : "replace test content 9" }
{ "update" : { "_index" : "test_index", "_type" : "test_type", "_id" : 10 } }
{ "doc" : { "test_field" : "update test content 10" }} 

#===============================================================================

{
  "took": 33,
  "errors": true,
  "items": [
    {
      "delete": {
        "found": false,
        "_index": "test_index",
        "_type": "test_type",
        "_id": "11",
        "_version": 12,
        "result": "not_found",
        "_shards": {
          "total": 2,
          "successful": 1,
          "failed": 0
        },
        "status": 404
      }
    },
    {
      "create": {
        "_index": "test_index",
        "_type": "test_type",
        "_id": "10",
        "status": 409,
        "error": {
          "type": "version_conflict_engine_exception",
          "reason": "[test_type][10]: version conflict, document already exists (current version [2])",
          "index_uuid": "220l9S2uSjWUK-G_iIGnBw",
          "shard": "1",
          "index": "test_index"
        }
      }
    },
    {
      "create": {
        "_index": "test_index",
        "_type": "test_type",
        "_id": "10",
        "status": 409,
        "error": {
          "type": "version_conflict_engine_exception",
          "reason": "[test_type][10]: version conflict, document already exists (current version [2])",
          "index_uuid": "220l9S2uSjWUK-G_iIGnBw",
          "shard": "1",
          "index": "test_index"
        }
      }
    },
    {
      "index": {
        "_index": "test_index",
        "_type": "test_type",
        "_id": "9",
        "_version": 5,
        "result": "updated",
        "_shards": {
          "total": 2,
          "successful": 1,
          "failed": 0
        },
        "created": false,
        "status": 200
      }
    },
    {
      "index": {
        "_index": "test_index",
        "_type": "test_type",
        "_id": "9",
        "_version": 6,
        "result": "updated",
        "_shards": {
          "total": 2,
          "successful": 1,
          "failed": 0
        },
        "created": false,
        "status": 200
      }
    },
    {
      "update": {
        "_index": "test_index",
        "_type": "test_type",
        "_id": "10",
        "_version": 2,
        "result": "noop",
        "_shards": {
          "total": 2,
          "successful": 1,
          "failed": 0
        },
        "status": 200
      }
    }
  ]
}
```

## bulk size
- `1000 ~ 5000` 
- `5 ~ 15M`

## bulk api json spatial format
- one data one line, use '\n'
	- json spatial format VS json format
	```json
	{"action": {"meta"}}
    {"data"}
    {"action": {"meta"}}
    {"data"}
 // ---------------------------- 
        [{
          "action": { },
          "data": { }
        }]
	```
	- **Do not need to translate to jsonArray object**














