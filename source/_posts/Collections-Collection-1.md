title: Collections -- Collection 詳解 -- (四) 
date: 2015-12-01 14:46:35
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 Collection 接口詳解 (一) 
> 這一節主要學習集合框架中的Collection接口、相關子接口、實現類以及成員屬性、方法等具體實現

<!--more-->  

#### Collection接口分析：
> Collection接口繼承了Iterable接口，Iterable接口存在一個Iterator對象.

```
Iterator接口與Enumeration類似,都用於遍歷.
Iterator接口增加了remove方法,可以修改集合內部元素.
Iterator接口中的方法命名具有更好的語義定義.
```

> Collection接口包含方法:

<img src="/images/Collection-functions.png"  />
