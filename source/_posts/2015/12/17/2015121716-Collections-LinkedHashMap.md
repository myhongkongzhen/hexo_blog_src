title:  Collections -- LinkedHashMap -- (28)
date: 2015-12-17 16:37:30
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 LinkedHashMap 詳解 (25)
> _由於 TreeSet,HashSet 引用了 Map 實現,所以這一節先學習 Map 接口相關_
> 這一節主要學習集合框架中的 LinkedHashMap 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### LinkedHashMap 說明:
> Iteration over the collection-views of a LinkedHashMap requires time proportional to the size of the map, regardless of its capacity.
> Iteration over a HashMap is likely to be more expensive, requiring time proportional to its capacity
```
private static class Entry<K,V> extends HashMap.Entry<K,V> { ... }
```

### LinkedHashMap UML:
<img src="/images/JDK/Collections/Collection-LinkedHashMap.png"  />

### LinkedHashMap 源碼解析:
```

    /**
     * Transfers all entries to new table array.  This method is called
     * 轉換所有的entries到新的數組中
     * by superclass resize.  It is overridden for performance, as it is
     * 這個方法在子類重新size的時候調用
     * faster to iterate using our linked list.
     * 為性能而複寫，用這個鏈錶迭代器更快速
     */
    @Override
    void transfer( HashMap.Entry[] newTable, boolean rehash) {
        int newCapacity = newTable.length;
        for (Entry<K,V> e = header.after; e != header; e = e.after) {
            if (rehash)
                e.hash = (e.key == null) ? 0 : hash(e.key);
            int index = indexFor(e.hash, newCapacity); // 取索引 hash & (length - 1) ,& 性能高於 模運算
            e.next = newTable[index];
            newTable[index] = e;
        }
    }


```
