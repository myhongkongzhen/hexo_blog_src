title: Collections -- Vector -- (十七)
date: 2015-12-14 14:26:26
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 Vector 詳解 (十四)
> 這一節主要學習集合框架中的 Vector 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### Vector 說明:
> The iterators returned by this class's iterator and listIterator methods are fail-fast
> The Enumerations returned by the elements method are not fail-fast. 
> Vector is synchronized. If a thread-safe implementation is not needed, it is recommended to use ArrayList in place of Vector.
> 線程安全通過 synchronized 方法 實現
> 內部元素由數組維護
```
protected Object[] elementData; 
private class Itr implements Iterator<E> { ... }
final class ListItr extends Itr implements ListIterator<E> { ... }
```

### Vector UML:
<img src="/images/JDK/Collections/Collection-Vector.png"  />

### Vector 源碼解析:
```

    /**
     * Trims the capacity of this vector to be the vector's current
     * size. If the capacity of this vector is larger than its current
     * size, then the capacity is changed to equal the size by replacing
     * its internal data array, kept in the field {@code elementData},
     * with a smaller one. An application can use this operation to
     * minimize the storage of a vector.
     */
    public synchronized void trimToSize() {
        modCount++;
        int oldCapacity = elementData.length;
        if (elementCount < oldCapacity) {
            elementData = java.util.Arrays.copyOf( elementData, elementCount);
        }
    }

    /**
     * Returns an enumeration of the components of this vector. The
     * returned {@code Enumeration} object will generate all items in
     * this vector. The first item generated is the item at index {@code 0},
     * then the item at index {@code 1}, and so on.
     *
     * @return  an enumeration of the components of this vector
     * @see     java.util.Iterator
     */
    public Enumeration<E> elements() {
        return new Enumeration<E>() {
            int count = 0;

            public boolean hasMoreElements() {
                return count < elementCount;
            }

            public E nextElement() {
                synchronized (Vector.this) {
                    if (count < elementCount) {
                        return elementData(count++);
                    }
                }
                throw new NoSuchElementException("Vector Enumeration");
            }
        };
    }

    /**
     * Returns a view of the portion of this List between fromIndex,
     * inclusive, and toIndex, exclusive.  (If fromIndex and toIndex are
     * equal, the returned List is empty.)  The returned List is backed by this
     * List, so changes in the returned List are reflected in this List, and
     * vice-versa.  The returned List supports all of the optional List
     * operations supported by this List.
     *
     * <p>This method eliminates the need for explicit range operations (of
     * the sort that commonly exist for arrays).  Any operation that expects
     * a List can be used as a range operation by operating on a subList view
     * instead of a whole List.  For example, the following idiom
     * removes a range of elements from a List:
     * <pre>
     *      list.subList(from, to).clear();
     * </pre>
     * Similar idioms may be constructed for indexOf and lastIndexOf,
     * and all of the algorithms in the Collections class can be applied to
     * a subList.
     *
     * <p>The semantics of the List returned by this method become undefined if
     * the backing list (i.e., this List) is <i>structurally modified</i> in
     * any way other than via the returned List.  (Structural modifications are
     * those that change the size of the List, or otherwise perturb it in such
     * a fashion that iterations in progress may yield incorrect results.)
     *
     * @param fromIndex low endpoint (inclusive) of the subList
     * @param toIndex high endpoint (exclusive) of the subList
     * @return a view of the specified range within this List
     * @throws IndexOutOfBoundsException if an endpoint index value is out of range
     *         {@code (fromIndex < 0 || toIndex > size)}
     * @throws IllegalArgumentException if the endpoint indices are out of order
     *         {@code (fromIndex > toIndex)}
     */
    public synchronized List<E> subList( int fromIndex, int toIndex) {
        return Collections.synchronizedList(super.subList(fromIndex, toIndex),
                                            this);
    }



```
