---
title: ELK_Kinds of search type_003
categories: technology
date: 2017-07-29 21:25:15
tags:
- Elasticsearch
---
> - Basic Search
>  - Query string search
>  - Query DSL
>  - Query filter
>  - Full-test search
>  - Phrase search
>  - Highlight search
> - Advance Search
>  - Group by
>  - Avg
>  - Sort

<!--more-->

# Query string search
------
```bash
GET /index/type/_search
```
## Case one
```bash
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

```bash
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

```bash
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
```bash
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

```bash
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

# Partial update
------
```bash
POST /index/type/id/_update
{
    "doc" : {
        "update_field" : "update field content"
    }
}
```

# Partial update base on groovy script
------
```bash
POST test_index/test_type/11/_update
{
  "script": "ctx._source.num += 1"
}
```
- To add file test-add-tags.groovy is in the ES path/config/script/.

```bash
POST /test_index/test_type/11/_update
{
    "script" : {
        lang : "groovy",
        file : "test-add-tags", 
        params : {
            "new_tags" : "tags"
        }
     }
}
-------------------------------------------
ctx._source.tags += new_tags
```

# Phrase search (_短语搜索_)
------
> To input the query key, which will be demolished to build an inverted index

```bash
GET /ecommerce/product/_search
{
    "query" : { "match_phrase" : { "producer" : "yagao producer" } }
}
```

# Highlight search
------
```bash
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

# Aggs - group_by_tags
------
## Case 1.
```bash
GET /ecommerce/product/_search
{
    "size" : 0,
    "aggs" : {
        "group_by_tags" : { "terms" : { "field" : "tags" } }
    }
}
--------------------------------------------------------------
{
...
"buckets": [
        {
          "key": "fangzhu",
          "doc_count": 2
        },
        {
          "key": "meibai",
          "doc_count": 2
        },
        {
          "key": "qingxin",
          "doc_count": 1
        }
      ]
...
}
```

## Case 2.
```bash
GET /ecommerce/product/_search
{
    "size" : 0,
    "aggs" : {
        "group_by_tags" : {
            "terms" : { "field" : "tags" , "order" : { "avg_price" : "desc" } },
            "aggs" : { "avg_price" : { "avg" : { "field" : "price" } } }
        }
    }
}
--------------------------------------------------------------
{
...
"buckets": [
        {
          "key": "fangzhu",
          "doc_count": 2,
          "avg_price": {
            "value": 27.5
          }
        },
        {
          "key": "meibai",
          "doc_count": 2,
          "avg_price": {
            "value": 40
          }
        },
        {
          "key": "qingxin",
          "doc_count": 1,
          "avg_price": {
            "value": 40
          }
        }
      ]
...
}
```

## Case 3.
```bash
GET /ecommerce/product/_search
{
    "size" : 0,
    "aggs" : {
        "group_by_price" : {
            "range" : {
                "field" : "price",
                "ranges" : [
                    { "from" : 0, "to" : 20 },
                    { "from" : 20, "to" : 40 },
                    { "from" : 40, "to" : 60 }
                ]
            },
            "aggs" : {
                "group_by_tags" : {
                    "terms" : { "field" : "tags" },
                    "aggs" : {
                        "avg_price" : { "avg" : { "field" : "price" } }
                    }
                }
            }
        }
    }
}
--------------------------------------------------------------
{
  "took": 8,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 4,
    "max_score": 0,
    "hits": []
  },
  "aggregations": {
    "group_by_price": {
      "buckets": [
        {
          "key": "0.0-20.0",
          "from": 0,
          "to": 20,
          "doc_count": 0,
          "group_by_tags": {
            "doc_count_error_upper_bound": 0,
            "sum_other_doc_count": 0,
            "buckets": []
          }
        },
        {
          "key": "20.0-40.0",
          "from": 20,
          "to": 40,
          "doc_count": 2,
          "group_by_tags": {
            "doc_count_error_upper_bound": 0,
            "sum_other_doc_count": 0,
            "buckets": [
              {
                "key": "fangzhu",
                "doc_count": 2,
                "avg_price": {
                  "value": 27.5
                }
              },
              {
                "key": "meibai",
                "doc_count": 1,
                "avg_price": {
                  "value": 30
                }
              }
            ]
          }
        },
        {
          "key": "40.0-60.0",
          "from": 40,
          "to": 60,
          "doc_count": 2,
          "group_by_tags": {
            "doc_count_error_upper_bound": 0,
            "sum_other_doc_count": 0,
            "buckets": [
              {
                "key": "meibai",
                "doc_count": 1,
                "avg_price": {
                  "value": 50
                }
              },
              {
                "key": "qingxin",
                "doc_count": 1,
                "avg_price": {
                  "value": 40
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```


















