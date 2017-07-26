title: Collections -- NavigableMap -- (25)
date: 2015-12-15 16:19:20
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 NavigableMap 詳解 (22)
> _由於 TreeSet,HashSet 引用了 Map 實現,所以這一節先學習 Map 接口相關_
> 這一節主要學習集合框架中的 NavigableMap 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

<!--### NavigableMap 說明:-->

### NavigableMap UML:
<img src="/images/JDK/Collections/Collection-NavigableMap.png"  />

### NavigableMap 源碼解析:
```

    /**
     * Returns a key-value mapping associated with the greatest key
     * less than or equal to the given key, or {@code null} if there
     * is no such key.
     *
     * @param key the key
     * @return an entry with the greatest key less than or equal to
     *         {@code key}, or {@code null} if there is no such key
     * @throws ClassCastException if the specified key cannot be compared
     *         with the keys currently in the map
     * @throws NullPointerException if the specified key is null
     *         and this map does not permit null keys
     */
    Entry<K,V> floorEntry( K key);

    /**
     * Returns a key-value mapping associated with the least key
     *                             關聯
     * greater than or equal to the given key, or {@code null} if
     * there is no such key.
     *
     * @param key the key
     * @return an entry with the least key greater than or equal to
     *         {@code key}, or {@code null} if there is no such key
     * @throws ClassCastException if the specified key cannot be compared
     *         with the keys currently in the map
     * @throws NullPointerException if the specified key is null
     *         and this map does not permit null keys
     */
    Entry<K,V> ceilingEntry( K key);
    
    /**
     * Returns a reverse order view of the mappings contained in this map.
     * The descending map is backed by this map, so changes to the map are
     * reflected in the descending map, and vice-versa.  If either map is
     * modified while an iteration over a collection view of either map
     * is in progress (except through the iterator's own {@code remove}
     * operation), the results of the iteration are undefined.
     *
     * <p>The returned map has an ordering equivalent to
     * <tt>{@link Collections#reverseOrder(Comparator) Collections.reverseOrder}(comparator())</tt>.
     * The expression {@code m.descendingMap().descendingMap()} returns a
     * view of {@code m} essentially equivalent to {@code m}.
     *
     * @return a reverse order view of this map
     */
    NavigableMap<K,V> descendingMap();

    /**
     * Returns a {@link java.util.NavigableSet} view of the keys contained in this map.
     * The set's iterator returns the keys in ascending order.
     * The set is backed by the map, so changes to the map are reflected in
     * the set, and vice-versa.  If the map is modified while an iteration
     * over the set is in progress (except through the iterator's own {@code
     * remove} operation), the results of the iteration are undefined.  The
     * set supports element removal, which removes the corresponding mapping
     * from the map, via the {@code Iterator.remove}, {@code Set.remove},
     * {@code removeAll}, {@code retainAll}, and {@code clear} operations.
     * It does not support the {@code add} or {@code addAll} operations.
     *
     * @return a navigable set view of the keys in this map
     */
    NavigableSet<K> navigableKeySet();

    /**
     * Returns a reverse order {@link java.util.NavigableSet} view of the keys contained in this map.
     * The set's iterator returns the keys in descending order.
     * The set is backed by the map, so changes to the map are reflected in
     * the set, and vice-versa.  If the map is modified while an iteration
     * over the set is in progress (except through the iterator's own {@code
     * remove} operation), the results of the iteration are undefined.  The
     * set supports element removal, which removes the corresponding mapping
     * from the map, via the {@code Iterator.remove}, {@code Set.remove},
     * {@code removeAll}, {@code retainAll}, and {@code clear} operations.
     * It does not support the {@code add} or {@code addAll} operations.
     *
     * @return a reverse order navigable set view of the keys in this map
     */
    NavigableSet<K> descendingKeySet();

    /**
     * Returns a view of the portion of this map whose keys range from
     * {@code fromKey} to {@code toKey}.  If {@code fromKey} and
     * {@code toKey} are equal, the returned map is empty unless
     * {@code fromInclusive} and {@code toInclusive} are both true.  The
     * returned map is backed by this map, so changes in the returned map are
     * reflected in this map, and vice-versa.  The returned map supports all
     * optional map operations that this map supports.
     *
     * <p>The returned map will throw an {@code IllegalArgumentException}
     * on an attempt to insert a key outside of its range, or to construct a
     * submap either of whose endpoints lie outside its range.
     *
     * @param fromKey low endpoint of the keys in the returned map
     * @param fromInclusive {@code true} if the low endpoint
     *        is to be included in the returned view
     * @param toKey high endpoint of the keys in the returned map
     * @param toInclusive {@code true} if the high endpoint
     *        is to be included in the returned view
     * @return a view of the portion of this map whose keys range from
     *         {@code fromKey} to {@code toKey}
     * @throws ClassCastException if {@code fromKey} and {@code toKey}
     *         cannot be compared to one another using this map's comparator
     *         (or, if the map has no comparator, using natural ordering).
     *         Implementations may, but are not required to, throw this
     *         exception if {@code fromKey} or {@code toKey}
     *         cannot be compared to keys currently in the map.
     * @throws NullPointerException if {@code fromKey} or {@code toKey}
     *         is null and this map does not permit null keys
     * @throws IllegalArgumentException if {@code fromKey} is greater than
     *         {@code toKey}; or if this map itself has a restricted
     *         range, and {@code fromKey} or {@code toKey} lies
     *         outside the bounds of the range
     */
    NavigableMap<K,V> subMap(K fromKey, boolean fromInclusive,
                             K toKey,   boolean toInclusive);

    /**
     * Returns a view of the portion of this map whose keys are less than (or
     * equal to, if {@code inclusive} is true) {@code toKey}.  The returned
     * map is backed by this map, so changes in the returned map are reflected
     * in this map, and vice-versa.  The returned map supports all optional
     * map operations that this map supports.
     *
     * <p>The returned map will throw an {@code IllegalArgumentException}
     * on an attempt to insert a key outside its range.
     *
     * @param toKey high endpoint of the keys in the returned map
     * @param inclusive {@code true} if the high endpoint
     *        is to be included in the returned view
     * @return a view of the portion of this map whose keys are less than
     *         (or equal to, if {@code inclusive} is true) {@code toKey}
     * @throws ClassCastException if {@code toKey} is not compatible
     *         with this map's comparator (or, if the map has no comparator,
     *         if {@code toKey} does not implement {@link Comparable}).
     *         Implementations may, but are not required to, throw this
     *         exception if {@code toKey} cannot be compared to keys
     *         currently in the map.
     * @throws NullPointerException if {@code toKey} is null
     *         and this map does not permit null keys
     * @throws IllegalArgumentException if this map itself has a
     *         restricted range, and {@code toKey} lies outside the
     *         bounds of the range
     */
    NavigableMap<K,V> headMap(K toKey, boolean inclusive);

    /**
     * Returns a view of the portion of this map whose keys are greater than (or
     * equal to, if {@code inclusive} is true) {@code fromKey}.  The returned
     * map is backed by this map, so changes in the returned map are reflected
     * in this map, and vice-versa.  The returned map supports all optional
     * map operations that this map supports.
     *
     * <p>The returned map will throw an {@code IllegalArgumentException}
     * on an attempt to insert a key outside its range.
     *
     * @param fromKey low endpoint of the keys in the returned map
     * @param inclusive {@code true} if the low endpoint
     *        is to be included in the returned view
     * @return a view of the portion of this map whose keys are greater than
     *         (or equal to, if {@code inclusive} is true) {@code fromKey}
     * @throws ClassCastException if {@code fromKey} is not compatible
     *         with this map's comparator (or, if the map has no comparator,
     *         if {@code fromKey} does not implement {@link Comparable}).
     *         Implementations may, but are not required to, throw this
     *         exception if {@code fromKey} cannot be compared to keys
     *         currently in the map.
     * @throws NullPointerException if {@code fromKey} is null
     *         and this map does not permit null keys
     * @throws IllegalArgumentException if this map itself has a
     *         restricted range, and {@code fromKey} lies outside the
     *         bounds of the range
     */
    NavigableMap<K,V> tailMap(K fromKey, boolean inclusive);
    
    
    
    
    
```
