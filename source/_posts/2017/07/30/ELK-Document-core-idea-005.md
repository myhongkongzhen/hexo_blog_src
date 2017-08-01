---
title: ELK_Document core idea_005
categories: technology
date: 2017-07-30 13:21:14
tags:
- Elasticsearch
---
> **document core metadata**  
>   - `_index` 
>   - `_type` 
>   - `_id` 
>   - `_source`

<!--more-->

```bash
{
  "_index": "test_index",
  "_type": "test_type",
  "_id": "1",
  "_version": 1,
  "found": true,
  "_source": {
    "test_content": "test test"
  }
}
```

# _index
------
- One document is in which index.
    - The different data(field) need be in different index.

# _type
------
- One document belongs to which type in index.

# _id
------
- The unique identity of the document.  
    - Manual create document id.  
        - Import other system data to ES.  
        ```bash
        PUT /test_index/test_type/2
        {
          "test_content" : "my test"
        }
        ```
    - Auto create document id.  
        - length : 20
        - url security : base64
        - GUID
    ```bash
    POST /test_index/test_type
    {
      "test_content" : "my test" 
    }
    ```
    <img src="/images/elasticsearch/012_auto_create_doc_id.png"  />
    
# _source
------
```bash
        GET /test_index/test_type/1
```
<img src="/images/elasticsearch/013_source_get_return.png"  />

```bash
        GET /test_index/test_type/1?_source=test_field1,test_field2
```
<img src="/images/elasticsearch/014_source_get_spec_return.png"  />

# Document replacement
------
- The same as creating the document
    - if _id exists, then it will be full replacement.
    - if not, create new document.
```bash
        PUT /test_index/test_type/4
         { 
           "test_field6":"test field 6"
         }
```
<img src="/images/elasticsearch/015_doc_full_replacement.png"  />
- Forced replacement
    - **`PUT /index/type/id?op_type=create`**
    - **`PUT /index/type/id/_create`**
    
<img src="/images/elasticsearch/016_doc_forced_replacement.png"  />
- Delete document

```bash
DELETE /test_index/test_type/4
```




