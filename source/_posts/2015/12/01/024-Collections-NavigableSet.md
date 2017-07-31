title: Collections -- NavigableSet -- (22)
date: 2015-12-15 11:20:08
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 NavigableSet 詳解 (19)
> 這一節主要學習集合框架中的 NavigableSet 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### NavigableSet 說明:

### NavigableSet UML:
<img src="/images/JDK/Collections/Collection-NavigableSet.png"  />

### NavigableSet 源碼解析:
```

    /**
     * Returns a reverse order view of the elements contained in this set.
     * 返回這個集合包含元素相反的視圖
     * The descending set is backed by this set, so changes to the set are
     * 倒序的set基於這個set
     * reflected in the descending set, and vice-versa.  If either set is
     * 在倒序的set中改變這個結合是引用的，反之亦然
     * modified while an iteration over either set is in progress (except
     * 如果任意set當迭代任意set在過程中
     * through the iterator's own {@code remove} operation), the results of
     * the iteration are undefined.
     * 迭代的結果是為定義的
     *
     * <p>The returned set has an ordering equivalent to
     * <tt>{@link Collections#reverseOrder(Comparator) Collections.reverseOrder}(comparator())</tt>.
     * The expression {@code s.descendingSet().descendingSet()} returns a
     * view of {@code s} essentially equivalent to {@code s}.
     *
     * @return a reverse order view of this set
     */
    NavigableSet<E> descendingSet();

    /**
     * Returns an iterator over the elements in this set, in descending order.
     * Equivalent in effect to {@code descendingSet().iterator()}.
     *
     * @return an iterator over the elements in this set, in descending order
     */
    Iterator<E> descendingIterator();

    /**
     * Returns a view of the portion of this set whose elements range from
     * {@code fromElement} to {@code toElement}.  If {@code fromElement} and
     * {@code toElement} are equal, the returned set is empty unless {@code
     * fromInclusive} and {@code toInclusive} are both true.  The returned set
     * is backed by this set, so changes in the returned set are reflected in
     * this set, and vice-versa.  The returned set supports all optional set
     * operations that this set supports.
     *
     * <p>The returned set will throw an {@code IllegalArgumentException}
     * on an attempt to insert an element outside its range.
     *
     * @param fromElement low endpoint of the returned set
     * @param fromInclusive {@code true} if the low endpoint
     *        is to be included in the returned view
     * @param toElement high endpoint of the returned set
     * @param toInclusive {@code true} if the high endpoint
     *        is to be included in the returned view
     * @return a view of the portion of this set whose elements range from
     *         {@code fromElement}, inclusive, to {@code toElement}, exclusive
     * @throws ClassCastException if {@code fromElement} and
     *         {@code toElement} cannot be compared to one another using this
     *         set's comparator (or, if the set has no comparator, using
     *         natural ordering).  Implementations may, but are not required
     *         to, throw this exception if {@code fromElement} or
     *         {@code toElement} cannot be compared to elements currently in
     *         the set.
     * @throws NullPointerException if {@code fromElement} or
     *         {@code toElement} is null and this set does
     *         not permit null elements
     * @throws IllegalArgumentException if {@code fromElement} is
     *         greater than {@code toElement}; or if this set itself
     *         has a restricted range, and {@code fromElement} or
     *         {@code toElement} lies outside the bounds of the range.
     */
    NavigableSet<E> subSet(E fromElement, boolean fromInclusive,
                           E toElement,   boolean toInclusive);

    /**
     * Returns a view of the portion of this set whose elements are less than
     * (or equal to, if {@code inclusive} is true) {@code toElement}.  The
     * returned set is backed by this set, so changes in the returned set are
     * reflected in this set, and vice-versa.  The returned set supports all
     * optional set operations that this set supports.
     *
     * <p>The returned set will throw an {@code IllegalArgumentException}
     * on an attempt to insert an element outside its range.
     *
     * @param toElement high endpoint of the returned set
     * @param inclusive {@code true} if the high endpoint
     *        is to be included in the returned view
     * @return a view of the portion of this set whose elements are less than
     *         (or equal to, if {@code inclusive} is true) {@code toElement}
     * @throws ClassCastException if {@code toElement} is not compatible
     *         with this set's comparator (or, if the set has no comparator,
     *         if {@code toElement} does not implement {@link Comparable}).
     *         Implementations may, but are not required to, throw this
     *         exception if {@code toElement} cannot be compared to elements
     *         currently in the set.
     * @throws NullPointerException if {@code toElement} is null and
     *         this set does not permit null elements
     * @throws IllegalArgumentException if this set itself has a
     *         restricted range, and {@code toElement} lies outside the
     *         bounds of the range
     */
    NavigableSet<E> headSet(E toElement, boolean inclusive);

    /**
     * Returns a view of the portion of this set whose elements are greater
     * than (or equal to, if {@code inclusive} is true) {@code fromElement}.
     * The returned set is backed by this set, so changes in the returned set
     * are reflected in this set, and vice-versa.  The returned set supports
     * all optional set operations that this set supports.
     *
     * <p>The returned set will throw an {@code IllegalArgumentException}
     * on an attempt to insert an element outside its range.
     *
     * @param fromElement low endpoint of the returned set
     * @param inclusive {@code true} if the low endpoint
     *        is to be included in the returned view
     * @return a view of the portion of this set whose elements are greater
     *         than or equal to {@code fromElement}
     * @throws ClassCastException if {@code fromElement} is not compatible
     *         with this set's comparator (or, if the set has no comparator,
     *         if {@code fromElement} does not implement {@link Comparable}).
     *         Implementations may, but are not required to, throw this
     *         exception if {@code fromElement} cannot be compared to elements
     *         currently in the set.
     * @throws NullPointerException if {@code fromElement} is null
     *         and this set does not permit null elements
     * @throws IllegalArgumentException if this set itself has a
     *         restricted range, and {@code fromElement} lies outside the
     *         bounds of the range
     */
    NavigableSet<E> tailSet(E fromElement, boolean inclusive);


```
