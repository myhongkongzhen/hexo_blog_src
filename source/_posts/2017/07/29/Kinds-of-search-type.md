---
title: ELK_Kinds of search type_003
categories: technology
date: 2017-07-29 21:25:15
tags:
- Elasticsearch
---
> - Query string search
> - Query DSL
> - Query filter
> - Full-test search
> - Phrase search
> - Highlight search

<!--more-->

# Query string search
------
```json
GET /index/type/_search
```
## Case one
```json
GET /ecommerce/product/_search
------------------------------
{
  "took": 7,   // used time(ms)
  "timed_out": false, // if it is check out
  "_shards": {
    "total": 5,  // 5 shard
    "successful": 5, // all request hits all primary shard & replica shard
    "failed": 0
  },
  "hits": {
    "total": 3, // result
    "max_score": 1, // The meaning of the score is the match of a search for a search score, the more relevant, the more match, the score is also high
    "hits": [ // the details of result documents
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "2",
        "_score": 1,
        "_source": {
          "name": "jiajieshi yagao",
          "desc": "youxiao fangzhu",
          "price": 25,
          "producer": "jiajieshi producer",
          "tags": [
            "fangzhu"
          ]
        }
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "1",
        "_score": 1,
        "_source": {
          "name": "jiaqiangban gaolujie yagao",
          "desc": "gaoxiao meibai",
          "price": 30,
          "producer": "gaolujie producer",
          "tags": [
            "meibai",
            "fangzhu"
          ]
        }
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "3",
        "_score": 1,
        "_source": {
          "name": "zhonghua yagao",
          "desc": "caoben zhiwu",
          "price": 40,
          "producer": "zhonghua producer",
          "tags": [
            "qingxin"
          ]
        }
      }
    ]
  }
}
```

## Case two
- paramter comes from http request.
```json
GET /ecommerce/product/_search?q=name:yagao&sort=price:asc
----------------------------------------------------------
{
  "took": 20,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 3,
    "max_score": null,
    "hits": [
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "2",
        "_score": null,
        "_source": {
          "name": "jiajieshi yagao",
          "desc": "youxiao fangzhu",
          "price": 25,
          "producer": "jiajieshi producer",
          "tags": [
            "fangzhu"
          ]
        },
        "sort": [
          25
        ]
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "1",
        "_score": null,
        "_source": {
          "name": "jiaqiangban gaolujie yagao",
          "desc": "gaoxiao meibai",
          "price": 30,
          "producer": "gaolujie producer",
          "tags": [
            "meibai",
            "fangzhu"
          ]
        },
        "sort": [
          30
        ]
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "3",
        "_score": null,
        "_source": {
          "name": "zhonghua yagao",
          "desc": "caoben zhiwu",
          "price": 40,
          "producer": "zhonghua producer",
          "tags": [
            "qingxin"
          ]
        },
        "sort": [
          40
        ]
      }
    ]
  }
}
```

# Query DSL
------
> Query Domain Specified Language
> Http request body: using JSON data structure

```json
GET /ecommerce/product/_search
{
   "query" : { "match_all" : {} }
}
--------------------------------------------------------------
GET /ecommerce/product/_search
{
    "query" : { "match" : { "name" : "yagao" } },
    "sort" : [ { "price"  : "desc" } ]
}
--------------------------------------------------------------
GET /ecommerce/product/_search
{
    "query" : { "match_all" : {} },
    "from" : 1, // from 0 to total
    "size" : 2  // query result total
}
--------------------------------------------------------------
GET /ecommerce/product/_search
{
   "query" : { "match_all" : {} },
   "_source" : [ "name" , "price" ]
}
```

# Query filter
------
```json
GET /ecommerce/product/_search
{
    "query" : {
        "bool" : { // include multiple query conditions
            "must" : { "match" : { "name" : "yagao" } },
            "filter" : { "range" : { "price" : { "gt" : 25 } } }
        }
    }
}
```

# _Full-text search_
------
> Producer this field, which will be demolished to build an inverted index

|key|item|
|-|-|
|special|4|
|yagao	|4|
|producer|1,2,3,4|
|gaolujie|1|
|zhognhua|3|
|jiajieshi|2|

```json
GET /ecommerce/product/_search
{
    "query" : { "match" : { "producer" : "yagao producer" } }
}
--------------------------------------------------------------
{
  "took": 10,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 4,
    "max_score": 0.70293105, // <1>
    "hits": [
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "4",
        "_score": 0.70293105, // <2>
        "_source": {
          "name": "special yagao",
          "desc": "special meibai",
          "price": 50,
          "producer": "special yagao producer",
          "tags": [
            "meibai"
          ]
        }
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "1",
        "_score": 0.25811607, // <3>
        "_source": {
          "name": "jiaqiangban gaolujie yagao",
          "desc": "gaoxiao meibai",
          "price": 30,
          "producer": "gaolujie producer",
          "tags": [
            "meibai",
            "fangzhu"
          ]
        }
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "3",
        "_score": 0.25811607, // <4>
        "_source": {
          "name": "zhonghua yagao",
          "desc": "caoben zhiwu",
          "price": 40,
          "producer": "zhonghua producer",
          "tags": [
            "qingxin"
          ]
        }
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "2",
        "_score": 0.1805489, // <5>
        "_source": {
          "name": "jiajieshi yagao",
          "desc": "youxiao fangzhu",
          "price": 25,
          "producer": "jiajieshi producer",
          "tags": [
            "fangzhu"
          ]
        }
      }
    ]
  }
}
```

# Phrase search (_短语搜索_)
------
> To input the query key, which will be demolished to build an inverted index

```json
GET /ecommerce/product/_search
{
    "query" : { "match_phrase" : { "producer" : "yagao producer" } }
}
```

# Highlight search
------
```json
GET /ecommerce/product/_search
{
    "query" : { "match" : { "producer" : "producer" } },
    "highlight": { "fields" : { "producer" : {} } }
}
--------------------------------------------------------------
{
  "took": 41,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 4,
    "max_score": 0.25811607,
    "hits": [
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "1",
        "_score": 0.25811607,
        "_source": {
          "name": "jiaqiangban gaolujie yagao",
          "desc": "gaoxiao meibai",
          "price": 30,
          "producer": "gaolujie producer",
          "tags": [
            "meibai",
            "fangzhu"
          ]
        },
        "highlight": {
          "producer": [
            "gaolujie <em>producer</em>"
          ]
        }
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "3",
        "_score": 0.25811607,
        "_source": {
          "name": "zhonghua yagao",
          "desc": "caoben zhiwu",
          "price": 40,
          "producer": "zhonghua producer",
          "tags": [
            "qingxin"
          ]
        },
        "highlight": {
          "producer": [
            "zhonghua <em>producer</em>"
          ]
        }
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "2",
        "_score": 0.1805489,
        "_source": {
          "name": "jiajieshi yagao",
          "desc": "youxiao fangzhu",
          "price": 25,
          "producer": "jiajieshi producer",
          "tags": [
            "fangzhu"
          ]
        },
        "highlight": {
          "producer": [
            "jiajieshi <em>producer</em>"
          ]
        }
      },
      {
        "_index": "ecommerce",
        "_type": "product",
        "_id": "4",
        "_score": 0.14638957,
        "_source": {
          "name": "special yagao",
          "desc": "special meibai",
          "price": 50,
          "producer": "special yagao producer",
          "tags": [
            "meibai"
          ]
        },
        "highlight": {
          "producer": [
            "special yagao <em>producer</em>"
          ]
        }
      }
    ]
  }
}
```

















