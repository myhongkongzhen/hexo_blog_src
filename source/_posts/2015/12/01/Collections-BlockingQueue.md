title: Collections -- BlockingQueue -- (十一)
date: 2015-12-10 14:53:03
categories: 技術
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 BlockingQueue 詳解 (八) 
> _由於LinkedList引用了Deque,所以這一節先學習Queue接口相關_
> 這一節主要學習集合框架中的 BlockingQueue 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->  

### BlockingQueue 說明:
> BlockingQueue implementations are thread-safe 線程安全的
<table>
 <tr> <td>       </td> <td>Throws exception </td> <td>Special value </td> <td>Blocks </td> <td>Times out</td> </tr> <tr> <td>Insert </td> <td>add(e) </td> <td>offer(e) </td> <td>put(e) </td> <td>offer(e, time, unit)</td> </tr> <tr> <td>Remove </td> <td>remove() </td> <td>poll() </td> <td>take() </td> <td>poll(time, unit)</td> </tr> <tr> <td>Examine</td> <td>element() </td> <td>peek() </td> <td>not applicable </td> <td>not applicable</td> </tr>
</table>

### BlockingQueue UML:
<img src="/images/JDK/Collections/Collection-BlockingQueue.png"  />

### BlockingQueue 源碼解析:
```

/**
 * Removes all available elements from this queue and adds them
 * 移除所有可用的元素從隊列中，并添加他們到給定的集合中
 * to the given collection.  This operation may be more
 * efficient than repeatedly polling this queue.  A failure
 * 這個操作比起重複的poll這個隊列更加高效
 * encountered while attempting to add elements to
 * 當試圖添加元素到集合中遇到一個失敗
 * collection <tt>c</tt> may result in elements being in neither,
 * 當關聯的異常拋出來任意一個或者二者，三者在元素中
 * either or both collections when the associated exception is
 * thrown.  Attempts to drain a queue to itself result in
 *          試圖排除一個隊列自己的結果會發生異常
 * <tt>IllegalArgumentException</tt>. Further, the behavior of
 * this operation is undefined if the specified collection is
 *  這個操作的行為是未定義的，如果指定的集合在操作過程改變了
 * modified while the operation is in progress.
 *
 * @param c the collection to transfer elements into
 * @return the number of elements transferred
 * @throws UnsupportedOperationException if addition of elements
 *         is not supported by the specified collection
 * @throws ClassCastException if the class of an element of this queue
 *         prevents it from being added to the specified collection
 * @throws NullPointerException if the specified collection is null
 * @throws IllegalArgumentException if the specified collection is this
 *         queue, or some property of an element of this queue prevents
 *         it from being added to the specified collection
 */
int drainTo(Collection<? super E> c);

/**
 * Removes all available elements from this queue and adds them
 * 移除所有可用的元素從隊列中，并添加他們到給定的集合中
 * to the given collection.  This operation may be more
 * efficient than repeatedly polling this queue.  A failure
 * 這個操作比起重複的poll這個隊列更加高效
 * encountered while attempting to add elements to
 * 當試圖添加元素到集合中遇到一個失敗
 * collection <tt>c</tt> may result in elements being in neither,
 * 當關聯的異常拋出來任意一個或者二者，三者在元素中
 * either or both collections when the associated exception is
 * thrown.  Attempts to drain a queue to itself result in
 *          試圖排除一個隊列自己的結果會發生異常
 * <tt>IllegalArgumentException</tt>. Further, the behavior of
 * this operation is undefined if the specified collection is
 *  這個操作的行為是未定義的，如果指定的集合在操作過程改變了
 * modified while the operation is in progress.
 *
 * @param c the collection to transfer elements into
 * @return the number of elements transferred
 * @throws UnsupportedOperationException if addition of elements
 *         is not supported by the specified collection
 * @throws ClassCastException if the class of an element of this queue
 *         prevents it from being added to the specified collection
 * @throws NullPointerException if the specified collection is null
 * @throws IllegalArgumentException if the specified collection is this
 *         queue, or some property of an element of this queue prevents
 *         it from being added to the specified collection
 */
int drainTo(Collection<? super E> c);







```
