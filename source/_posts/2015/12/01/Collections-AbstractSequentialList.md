title: Collections -- AbstractSequentialList -- (九)
date: 2015-12-10 10:19:29
categories: 技術
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 AbstractSequentialList 抽象類詳解 (六) 
> 這一節主要學習集合框架中的 AbstractSequentialList 抽象類的成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->  

#### AbstractSequentialList List接口抽象類
> 定義了最小化的一般通用的方法實現
```
public E get(int index) { ... }
public E set(int index, E element) { ... }
public void add(int index, E element) { ... }
public E remove(int index) { ... }
public boolean addAll(int index, Collection<? extends E> c) { ... }
```

AbstractList類UML:
<img src="/images/JDK/Collections/Collection-AbstractSequentialList.png"  />

實現類源碼解析:
```
/**
 * Replaces the element at the specified position in this list with the
 * specified element (optional operation).
 *
 * <p>This implementation first gets a list iterator pointing to the
 * indexed element (with <tt>listIterator(index)</tt>).  Then, it gets
 * the current element using <tt>ListIterator.next</tt> and replaces it
 * with <tt>ListIterator.set</tt>.
 *
 * <p>Note that this implementation will throw an
 * <tt>UnsupportedOperationException</tt> if the list iterator does not
 * implement the <tt>set</tt> operation.
 *
 * @throws UnsupportedOperationException {@inheritDoc}
 * @throws ClassCastException            {@inheritDoc}
 * @throws NullPointerException          {@inheritDoc}
 * @throws IllegalArgumentException      {@inheritDoc}
 * @throws IndexOutOfBoundsException     {@inheritDoc}
 */
public E set(int index, E element) {
    try {
        ListIterator<E> e = listIterator(index);
        E oldVal = e.next();
        e.set(element);
        return oldVal; // 返回的是舊值，被新值覆蓋 remove(index) 同樣返回的是舊值
    } catch (NoSuchElementException exc) {
        throw new IndexOutOfBoundsException("Index: "+index);
    }
}
```
