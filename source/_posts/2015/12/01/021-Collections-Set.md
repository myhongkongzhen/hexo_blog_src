title: Collections -- Set -- (十九)
date: 2015-12-14 15:36:04
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 Set 詳解 (十六)
> 這一節主要學習集合框架中的 Set 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### Set 說明:
> A collection that contains no duplicate elements.

### Set UML:
<img src="/images/Collections/Collection-Set.png"  />

### Set 源碼解析:
```

    /**
     * Returns an iterator over the elements in this set.  The elements are
     * 返回遍歷集合元素的迭代器
     * returned in no particular order (unless this set is an instance of some
     * 沒有特定順序的返回這些元素
     * class that provides a guarantee).
     * 除非這個set是一個提供了維護的實現的類
     *
     * @return an iterator over the elements in this set
     */
    Iterator<E> iterator();

    /**
     * Adds the specified element to this set if it is not already present
     * (optional operation).  More formally, adds the specified element
     * <tt>e</tt> to this set if the set contains no element <tt>e2</tt>
     * such that
     * <tt>(e==null&nbsp;?&nbsp;e2==null&nbsp;:&nbsp;e.equals(e2))</tt>.
     * If this set already contains the element, the call leaves the set
     * unchanged and returns <tt>false</tt>.  In combination with the
     * 調用離開set不會改變並且返回false
     * restriction on constructors, this ensures that sets never contain
     * 附帶構造器限制組合
     * duplicate elements.
     * 這保證集合永遠不會包含重複的元素
     *
     * <p>The stipulation above does not imply that sets must accept all
     * 約定以上沒有壽命集合必須接受所有元素
     * elements; sets may refuse to add any particular element, including
     *           集合可以拒絕添加任何特定元素
     * <tt>null</tt>, and throw an exception, as described in the
     * 包括null，拋出異常， 在規範中由Collection.add說明
     * specification for {@link java.util.Collection#add Collection.add}.
     * Individual set implementations should clearly document any
     * 個別的集合實現應該明確文檔任何限制他們可包含的元素
     * restrictions on the elements that they may contain.
     *
     * @param e element to be added to this set
     * @return <tt>true</tt> if this set did not already contain the specified
     *         element
     * @throws UnsupportedOperationException if the <tt>add</tt> operation
     *         is not supported by this set
     * @throws ClassCastException if the class of the specified element
     *         prevents it from being added to this set
     * @throws NullPointerException if the specified element is null and this
     *         set does not permit null elements
     * @throws IllegalArgumentException if some property of the specified element
     *         prevents it from being added to this set
     */
    boolean add(E e);

```
