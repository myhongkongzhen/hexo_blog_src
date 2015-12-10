title: Collections -- Queue -- (十)
date: 2015-12-10 11:26:41
categories: 技術
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 Queue 詳解 (七) 
> _由於LinkedList引用了Deque,所以這一節先學習Queue接口相關_
> 這一節主要學習集合框架中的 Queue 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->  

#### Queue 接口
Queue 類 UML:
<img src="/images/Collections/Collection-Queue.png"  />

實現類源碼解析:
```
/**
 * Inserts the specified element into this queue if it is possible to do
 * so immediately without violating capacity restrictions.
 * When using a capacity-restricted queue, this method is generally
 * 當使用容量受限的隊列，
 * preferable to {@link #add}, which can fail to insert an element only
 * 這個方法是通常最好比使用add,   他可以錯誤的添加一個元素僅僅由拋出的異常
 * by throwing an exception.
 *
 * @param e the element to add
 * @return <tt>true</tt> if the element was added to this queue, else
 *         <tt>false</tt>
 * @throws ClassCastException if the class of the specified element
 *         prevents it from being added to this queue
 * @throws NullPointerException if the specified element is null and
 *         this queue does not permit null elements
 * @throws IllegalArgumentException if some property of this element
 *         prevents it from being added to this queue
 */
boolean offer(E e);

/**
 * Retrieves and removes the head of this queue.  This method differs
 * 檢索
 * from {@link #poll poll} only in that it throws an exception if this
 * 這個方法與poll不同的地方僅僅在隊列為空時拋出一個異常
 * queue is empty.
 *
 * @return the head of this queue
 * @throws java.util.NoSuchElementException if this queue is empty
 */
E remove();

/**
 * Retrieves and removes the head of this queue,
 * or returns <tt>null</tt> if this queue is empty.
 * 如果隊列為null返回null
 *
 * @return the head of this queue, or <tt>null</tt> if this queue is empty
 */
E poll();

/**
 * Retrieves, but does not remove, the head of this queue.  This method
 * 檢索,      但不刪除,
 * differs from {@link #peek peek} only in that it throws an exception
 * 這個方法與peek的不同之處僅在 如果隊列為null拋出一個異常
 * if this queue is empty.
 *
 * @return the head of this queue
 * @throws java.util.NoSuchElementException if this queue is empty
 */
E element();

/**
 * Retrieves, but does not remove, the head of this queue,
 * or returns <tt>null</tt> if this queue is empty.
 * 如果隊列為null返回null
 *
 * @return the head of this queue, or <tt>null</tt> if this queue is empty
 */
E peek();






```






