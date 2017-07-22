title: Collections -- AbstractSet -- (二十)
date: 2015-12-14 17:34:18
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 AbstractSet 詳解 (十七)
> 這一節主要學習集合框架中的 AbstractSet 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### AbstractSet 說明:
> 不重寫任何 AbstractCollection 類的方法，僅僅擴展 equals() 及 hashCode() 方法

### AbstractSet UML:
<img src="/images/Collections/Collection-AbstractSet.png"  />

### AbstractSet 源碼解析:
```

    /**
     * Returns the hash code value for this set.  The hash code of a set is
     * defined to be the sum of the hash codes of the elements in the set,
     * where the hash code of a <tt>null</tt> element is defined to be zero.
     * This ensures that <tt>s1.equals(s2)</tt> implies that
     * <tt>s1.hashCode()==s2.hashCode()</tt> for any two sets <tt>s1</tt>
     * and <tt>s2</tt>, as required by the general contract of
     * {@link Object#hashCode}.
     *
     * <p>This implementation iterates over the set, calling the
     * <tt>hashCode</tt> method on each element in the set, and adding up
     * the results.
     *
     * @return the hash code value for this set
     * @see Object#equals(Object)
     * @see java.util.Set#equals(Object)
     */
    public int hashCode() {
        int                   h = 0;
        Iterator<E> i = iterator();
        while (i.hasNext()) {
            E obj = i.next();
            if (obj != null)
                h += obj.hashCode();
        }
        return h;
    }
   
    /**
     * Removes from this set all of its elements that are contained in the
     * specified collection (optional operation).  If the specified
     * collection is also a set, this operation effectively modifies this
     *                                          有效
     * set so that its value is the <i>asymmetric set difference</i> of
     *                                 非對稱
     * the two sets.
     *
     * <p>This implementation determines which is the smaller of this set
     * and the specified collection, by invoking the <tt>size</tt>
     * method on each.  If this set has fewer elements, then the
     * implementation iterates over this set, checking each element
     * returned by the iterator in turn to see if it is contained in
     * the specified collection.  If it is so contained, it is removed
     * from this set with the iterator's <tt>remove</tt> method.  If
     * the specified collection has fewer elements, then the
     * implementation iterates over the specified collection, removing
     * from this set each element returned by the iterator, using this
     * set's <tt>remove</tt> method.
     *
     * <p>Note that this implementation will throw an
     * <tt>UnsupportedOperationException</tt> if the iterator returned by the
     * <tt>iterator</tt> method does not implement the <tt>remove</tt> method.
     *
     * @param  c collection containing elements to be removed from this set
     * @return <tt>true</tt> if this set changed as a result of the call
     * @throws UnsupportedOperationException if the <tt>removeAll</tt> operation
     *         is not supported by this set
     * @throws ClassCastException if the class of an element of this set
     *         is incompatible with the specified collection
     * (<a href="Collection.html#optional-restrictions">optional</a>)
     * @throws NullPointerException if this set contains a null element and the
     *         specified collection does not permit null elements
     * (<a href="Collection.html#optional-restrictions">optional</a>),
     *         or if the specified collection is null
     * @see #remove(Object)
     * @see #contains(Object)
     */
    public boolean removeAll( Collection<?> c) {
        boolean modified = false;

        if (size() > c.size()) {
            for ( Iterator<?> i = c.iterator(); i.hasNext(); )
                modified |= remove(i.next()); // 異或 ，更高的性能 ？ 
        } else {
            for ( Iterator<?> i = iterator(); i.hasNext(); ) {
                if (c.contains(i.next())) {
                    i.remove();
                    modified = true;
                }
            }
        }
        return modified;
    }
 
    
    
```
