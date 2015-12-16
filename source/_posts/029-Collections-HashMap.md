title: Collections -- HashMap -- (27)
date: 2015-12-15 17:34:04
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 HashMap 詳解 (24)
> _由於 TreeSet,HashSet 引用了 Map 實現,所以這一節先學習 Map 接口相關_
> 這一節主要學習集合框架中的 HashMap 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### HashMap 說明:
> This implementation provides all of the optional map operations, and permits null values and the null key.

### HashMap UML:
<img src="/images/Collections/Collection-HashMap.png"  />

### HashMap 源碼解析:
