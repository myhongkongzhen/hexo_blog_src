title: Collections -- List -- (五) 
date: 2015-12-03 14:17:27
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 List 接口詳解 (二) 
> 這一節主要學習集合框架中的Collection接口、相關子接口、實現類以及成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->  

#### List接口分析

> List接口包含方法:

<img src="/images/Collection-List.png"  />

```
boolean contains(Object o); // (o == null ? e == null : o.equals(e)) ***(NullPointerException)if the specified element is null and this list does not permit null elements
Object[] toArray(); //(in proper sequence). In other words, this method must allocate a new array even if this list is backed by an array







```
