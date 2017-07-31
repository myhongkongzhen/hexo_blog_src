---
title: ELK_白話Elasticsearch_001
categories: technology
date: 2017-07-23 23:04:57
tags:
- Elasticsearch
---
> Elasticsearch分佈式、高性能、高可用、可伸縮的搜索和分析系統 

<!--more-->

# 搜索  
------
##### 垂直搜索 (站內搜索)   
> - `互聯網搜索`  
    電商網站、招聘網站、新聞網站、各種APP
> - `IT系統的搜索`  
    OA軟件、辦公自動化、會議管理、日程管理......

_**搜索就是任何場景下，找尋你想要的信息，輸入一段關鍵字，期望找到這個關鍵字相關的信息**_  
# 如果用數據庫進行搜索
------
##### 電商系統  
```sql
    SELECT * FROM products WHERE product_name like '%牙膏%'
```    
|prod_id|prod_name|prod_desc|prod_img|
|-|-|-|-|
|1|中華牙膏| | |
|2|中牙刷膏| | |
|3|雲南白藥牙膏| | |
|4|佳潔士牙膏| | |  
> - 全表掃描,性能會很差   
> - 不能將關鍵字拆分開來，搜索更多符合期望的結果，搜索不到 **_中牙刷膏_**  
> - 查詢關鍵字可能很長很長......  

# 全文檢索和Lucene
------
#### 1、檢索 (倒排索引)
> 全文檢索
> 結構化搜索
> 數據分析

```markdown
1 生化 危機 電影  
2 生化 危機 海報  
3 生化 危機 文章  
4 生化 危機 新聞  
```  
|key|ids|  
|-|-|  
|生化|1,2,3,4|  
|危機|1,2,3,4|  
|電影|1|  
|海報|2|  
|文章|3|  
|新聞|4|
- 什麼是全文檢索
<img src="/images/elasticsearch/001_什麼是全文檢索.png"  />
- 倒排索引Wiki
<img src="/images/elasticsearch/002_倒排索引.png"  />

#### 2、What's Lucene ?
- 簡單來說，Lucene就是一個jar包，包含了封裝好的各種建立倒排索引，以及進行搜索的代碼，包括各種算法。用java開發的時候，引入該jar包，基於路測呢滴api進行開發。  
- 利用Lucene給已有的數據建立索引，Lucene會在本地磁盤上，組織索引的數據結構，還可以利用Lucene提供的API來針對磁盤上的索引數據，進行搜索。  

#### 3、What's Elasticsearch ?
High performance High availability Distributed
- Lucene is deployed on single server.
- When we save the big data, there is not enough space on single server.
- When we deploy lucene on more than one sever, we search the data, how do we communicate with multiple machines?
- When one lucene server is downtime, we need how to save the data on this server?   
> **Elasticsearch package underlying lucene.**

# Elasticsearch core idea
-----
- Near Realtime (NRT) : delay about 1s
- Cluster : include several Nodes
- Node : to be join default Cluster
- Document : the minimum unit of ES, include several fields
- Index : include several Types / Documents
- Type : logical classification
- Shard : Lucene Index, primary shard (易於橫向擴展)
- Replica : Copy of Shard, replica shard
    There are 10 default shard in one Index, 5 primary shard and 5 replica shard.
    _**Note:** Replica shard and Primary shard cannot be on the same server._

|ES|DB|
|-|-|
|Field|Column|
|Document|Line|
|Type|Table|
|Index|Database|



       

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
