---
title: ELK_install & startup Elasticsearch & 'CRUD'_002
categories: technology
date: 2017-07-29 16:21:16
tags:
- Elasticsearch
---
> To introduce to install & startup Elasticsearch
> To introduce Document data structure
> To introduce easy cluster management
> To study Elasticsearch 'CRUD' operation

<!--more-->

# Install Elasticsearch
------
## Download & Install & Startup elasticsearch : [Elasticsearch](https://www.elastic.co/downloads/elasticsearch)
<img src="/images/elasticsearch/003_install_startup_ES.png"  />

## To check if the Elasticsearch startup success. [127.0.0.1:9200](http://127.0.0.1:9200/?pretty)
```bash
{
  "name" : "PFS_monitor_node-1", // Node name
  "cluster_name" : "PFS_monitor_cluster", // Cluster name
  "cluster_uuid" : "tBEEZhRUS0O3SmduwgYZVw", // Cluster uuid
  "version" : {
    "number" : "5.2.0", // Elasticsearch version
    "build_hash" : "24e05b9",
    "build_date" : "2017-01-24T19:52:35.800Z",
    "build_snapshot" : false,
    "lucene_version" : "6.4.0" // Lucene versoin
  },
  "tagline" : "You Know, for Search"
}
```

------
## Download & Install Kibana : [Kibana](https://www.elastic.co/downloads/kibana)
<img src="/images/elasticsearch/004_kibana.png"  />

## To use kibana to study Elasticsearch. [Kibana dev tools](http://localhost:5601/app/kibana#/dev_tools/console?_g=()
<img src="/images/elasticsearch/005_healthcheck.png"  />

```bash
{
  "cluster_name": "PFS_monitor_cluster",
  "status": "yellow",
  "timed_out": false,
  "number_of_nodes": 1,
  "number_of_data_nodes": 1,
  "active_primary_shards": 1,
  "active_shards": 1,
  "relocating_shards": 0,
  "initializing_shards": 0,
  "unassigned_shards": 1,
  "delayed_unassigned_shards": 0,
  "number_of_pending_tasks": 0,
  "number_of_in_flight_fetch": 0,
  "task_max_waiting_in_queue_millis": 0,
  "active_shards_percent_as_number": 50
}
```

# Document Data Structure
------
## Java Data Structure
<img src="/images/elasticsearch/006_java_data_structure.png"  />

## Database structure
|table column|t_employee|
|-|-|
|ee_id|int|
|email|varchar|
|first_name|varchar|
|last_name|varchar|
|info_id|int|
|join_date|datetime|

|table column|t_employee_info|
|-|-|
|info_id|int|
|bio|varchar|
|age|int|
|interests|varchar(100)|

## Document data structure
The document data structure of elasticsearch is JSON **基於文檔的數據結構**
```JSON
{
    email : myhongkongzhen@gmail.com,
    first_name : Jane,
    last_name : Wu,
    info : {
        bio : curious and modest,
        age : 31,
        interest : [
            film,
            takarazuka,
            eatting
        ]
        join_date : Jul 29th 2017
    }
}
```

# Elasticsearch cluster management
------
## ES health check
([GET _cat/health?v](http://127.0.0.1:9200/_cat/health?v)) **One of the ES apis : _cat**
<img src="/images/elasticsearch/007_es_healthcheck.png"  />
## ES health status
- green
    - Every primary shard & replica shard of index is active.
- yellow
    - Every primary shard of index is active.
    - Part of replica shard of index is not available.
- red
    - Part of primary shard of index is not available.
    - Data of part of index is lost.
    
## Check index of cluster
[GET _cat/indices?v](http://127.0.0.1:9200/_cat/indices?v)
```markdown
health status index   uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   .kibana SCPH1iHxTwiV6naHOTRiig   1   1          1            0      3.1kb          3.1kb
```

## Create index
[PUT /zzwu_index?pretty](http://127.0.0.1:9200/zzwu_index?pretty)
```markdown
{
  "acknowledged": true,
  "shards_acknowledged": true
}

health status index      uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   .kibana    SCPH1iHxTwiV6naHOTRiig   1   1          1            0      3.1kb          3.1kb
yellow open   zzwu_index AdEOBWZbTvawswsr8jgA-A   5   1          0            0       650b           650b
```

## Delete index
[DELETE /zzwu_index?pretty](http://127.0.0.1:9200/_cat/indices?v)
```bash
{
  "acknowledged": true
}

{
  "error" : {
    "root_cause" : [
      {
        "type" : "index_not_found_exception",
        "reason" : "no such index",
        "resource.type" : "index_or_alias",
        "resource.id" : "zzwu_index",
        "index_uuid" : "_na_",
        "index" : "zzwu_index"
      }
    ],
    "type" : "index_not_found_exception",
    "reason" : "no such index",
    "resource.type" : "index_or_alias",
    "resource.id" : "zzwu_index",
    "index_uuid" : "_na_",
    "index" : "zzwu_index"
  },
  "status" : 404
}
```

# Show Case
------
## Create index & type
```bash
PUT /index/type/id
{
  "json data"
}
```

```bash
PUT /ecommerce/product/1
{
    "name" : "gaolujie yagao",
    "desc" :  "gaoxiao meibai",
    "price" :  30,
    "producer" :      "gaolujie producer",
    "tags": [ "meibai", "fangzhu" ]
}
```
<img src="/images/elasticsearch/008_create_index_type.png"  />

## Search document
```bash
GET /index/type/id
```

```bash
GET /ecommerce/product/2
```
<img src="/images/elasticsearch/009_search_index.png"  />

## Edit document
- replace

```bash
PUT /ecommerce/product/1
{
    "name" : "jiaqiangban gaolujie yagao",
    "desc" :  "gaoxiao meibai",
    "price" :  30,
    "producer" :      "gaolujie producer",
    "tags": [ "meibai", "fangzhu" ]
}
```
<img src="/images/elasticsearch/010_edit_replace_01.png"  />

```bash
PUT /ecommerce/product/1
{
    "name" : "jiaqiangban gaolujie yagao"
}
```
<img src="/images/elasticsearch/010_edit_replace_02.png"  />

- update

```bash
POST /ecommerce/product/1/_update
{
  "doc": {
    "name": "jiaqiangban gaolujie yagao"
  }
}
```
<img src="/images/elasticsearch/010_edit_update_02.png"  />

## Delete document
```bash
DELETE /ecommerce/product/1
----------------------------
{
  "found": true,
  "_index": "ecommerce",
  "_type": "product",
  "_id": "1",
  "_version": 10,
  "result": "deleted",
  "_shards": {
    "total": 2,
    "successful": 1,
    "failed": 0
  }
}
```





















