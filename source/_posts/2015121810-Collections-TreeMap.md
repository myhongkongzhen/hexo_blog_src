title: Collections -- TreeMap -- (29)
date: 2015-12-18 10:19:42
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 TreeMap 詳解 (26)
> _由於 TreeSet,HashSet 引用了 Map 實現,所以這一節先學習 Map 接口相關_
> 這一節主要學習集合框架中的 TreeMap 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### TreeMap 說明:
> A Red-Black tree based NavigableMap implementation
> Note that this implementation is not synchronized
> The iterators returned by the iterator method of the collections returned by all of this class's "collection view methods" are fail-fast
> 這章看到頭疼，大概了解一二了，不過對於紅黑樹實現還是模模糊糊，先放過這章，日後再回頭重看吧，現在腦子混混的.

### TreeMap UML:
<img src="/images/Collections/Collection-TreeMap.png"  />

### TreeMap 源碼解析:
```

    /**
     * Returns a shallow copy of this {@code TreeMap} instance. (The keys and
     * values themselves are not cloned.)
     *
     * @return a shallow copy of this map
     */
    public Object clone() {
        TreeMap<K,V> clone = null;
        try {
            clone = (TreeMap<K,V>) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new InternalError();
        }

        // Put clone into "virgin" state (except for comparator)
        clone.root = null;
        clone.size = 0;
        clone.modCount = 0;
        clone.entrySet = null;
        clone.navigableKeySet = null;
        clone.descendingMap = null;

        // Initialize clone with our mappings
        try {
            clone.buildFromSorted(size, entrySet().iterator(), null, null);
        } catch (java.io.IOException cannotHappen) {
        } catch (ClassNotFoundException cannotHappen) {
        }

        return clone;
    }
```
