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
> As a general rule, the default load factor (.75) offers a good tradeoff between time and space costs
```
    static class Entry<K,V> implements Map.Entry<K,V> { ... }
```

### HashMap UML:
<img src="/images/JDK/Collections/Collection-HashMap.png"  />

### HashMap 源碼解析:
```

    /**
     * The default initial capacity - MUST be a power of two.
     * 默認的初始化容量 - 必須是2的冪數
     */
    static final int DEFAULT_INITIAL_CAPACITY = 1 << 4; // aka 16 左移4位，就是2的4次方=16

    /**
     * The maximum capacity, used if a higher value is implicitly specified
     * 最大的容量，用於如果一個更大值隱含的由任何一個帶參的構造器指定
     * by either of the constructors with arguments.
     * MUST be a power of two <= 1<<30.
     * 其值必須小於 1 << 30;
     */
    static final int MAXIMUM_CAPACITY = 1 << 30;

    /**
     * The load factor used when none specified in constructor.
     * 當構造函數未指定時的負載因子
     */
    static final float DEFAULT_LOAD_FACTOR = 0.75f;

    /**
     * An empty table instance to share when the table is not inflated.
     * 為填充表共享一個空的表實例
     */
    static final Entry<?,?>[] EMPTY_TABLE = {};

    /**
     * The table, resized as necessary. Length MUST Always be a power of two.
     * 重新設置值的表，長度必須是2的冪數
     */
    transient Entry<K,V>[] table = (Entry<K,V>[]) EMPTY_TABLE;

    /**
     * The number of key-value mappings contained in this map.
     * map中k-v影射包含的數量
     */
    transient int size;

    /**
     * The next size value at which to resize (capacity * load factor).
     * 用於重新設置值的值，閥值
     * @serial
     */
    // If table == EMPTY_TABLE then this is the initial capacity at which the
//            如果table == EMPTY_TABLE 那麼初始的容量在table創建時
    // table will be created when inflated.
    int threshold;

    /**
     * The load factor for the hash table.
     * 哈希表的負載因子
     *
     * @serial
     */
    final float loadFactor;

    /**
     * The number of times this HashMap has been structurally modified
     * HashMap結構化改變的次數
     * Structural modifications are those that change the number of mappings in
     * 在hashMap中影射的改變或者
     * the HashMap or otherwise modify its internal structure (e.g.,
     * 內部結構的改變(例如rehash)
     * rehash).  This field is used to make iterators on Collection-views of
     * the HashMap fail-fast.  (See ConcurrentModificationException).
     * 這個域用於HahsMap快速失敗集合視圖上的迭代器
     */
    transient int modCount;

    /**
     * The default threshold of map capacity above which alternative hashing is
     * 默認的超過替代散列的map容量的閥值用於字符串key
     * used for String keys. Alternative hashing reduces the incidence of
     * 替代散列減少發生碰撞提供對於字符串key的弱的代碼計算
     * collisions due to weak hash code calculation for String keys.
     * <p/>
     * This value may be overridden by defining the system property
     * 這個值可以重寫由系統屬性定義
     * {@code jdk.map.althashing.threshold}. A property value of {@code 1}
     * forces alternative hashing to be used at all times whereas
     * 一個屬性值1 強迫在任何時間替代散列，而-1則確保任何時間都不會用到
     * {@code -1} value ensures that alternative hashing is never used.
     */
    static final int ALTERNATIVE_HASHING_THRESHOLD_DEFAULT = Integer.MAX_VALUE;
    
    /**
     * Returns index for hash code h.
     * 返回哈希值的索引
     */
    static int indexFor(int h, int length) {
        // assert Integer.bitCount(length) == 1 : "length must be a non-zero power of 2";
        return h & (length-1);
    }
    
    /**
     * Adds a new entry with the specified key, value and hash code to
     * 添加一個新的實體由指定的key，value以及哈希值到指定的塊中
     * the specified bucket.  It is the responsibility of this
     * method to resize the table if appropriate.
     * 這個方法響應的重新resize適當的表
     *
     * Subclass overrides this to alter the behavior of put method.
     */
    void addEntry(int hash, K key, V value, int bucketIndex) {
        if ((size >= threshold) && (null != table[bucketIndex])) {
            resize(2 * table.length);
            hash = (null != key) ? hash(key) : 0;
            bucketIndex = indexFor(hash, table.length);
        }

        createEntry(hash, key, value, bucketIndex);
    }

    /**
     * Like addEntry except that this version is used when creating entries
     * 如同addEntry期望的這個版本用於當創建entries作為map構造器或偽構造器一部分時
     * as part of Map construction or "pseudo-construction" (cloning,
     * deserialization).  This version needn't worry about resizing the table.
     * 這個版本不需要擔心重新resize表
     *
     * Subclass overrides this to alter the behavior of HashMap(Map),
     * clone, and readObject.
     */
    void createEntry(int hash, K key, V value, int bucketIndex) {
        Entry<K,V> e = table[bucketIndex];
        table[bucketIndex] = new Entry<>(hash, key, value, e);
        size++;
    }

    
```
