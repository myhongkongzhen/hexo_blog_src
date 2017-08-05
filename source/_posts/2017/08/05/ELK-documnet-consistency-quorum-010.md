---
title: ELK_documnet consistency & quorum_010
categories:
  - technology
tags: [Elasticsearch]
date: 2017-08-05 22:22:23
---
> - document writing consistency 
> - quorum

<!--more-->

**Document consistency**
------
- **_PUT /index/type/id?consistency=XXX_**
	- one : primary shard is active 
	- all : all primary shard and replic shard are active 
	- quorum : default value, most partial shard are active
		- `quorum = int ( ( primary + number_of_replicas )/ 2 ) + 1`
		- wait 1min, timeout: 100ms( default ), 30s
			- **_PUT /index/type/id?timeout=XXX_**

> Note:
> - if number of node is less than number of quorum, we cannot do any writing operating.
> - special operating: number_of_replica > 1, quorum is available




- _CONTINUE_