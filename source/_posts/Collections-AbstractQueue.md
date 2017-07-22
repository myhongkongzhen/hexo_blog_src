title: Collections -- AbstractQueue -- (十四)
date: 2015-12-11 15:57:12
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 AbstractQueue 詳解 (十一)
> _由於LinkedList引用了Deque,所以這一節先學習Queue接口相關_
> 這一節主要學習集合框架中的 AbstractQueue 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### AbstractQueue 說明:

### AbstractQueue UML:
<img src="/images/Collections/Collection-AbstractQueue.png"  />

### AbstractQueue 源碼解析:
```

	/**
	 * Inserts the specified element into this queue if it is possible to do so
	 * immediately without violating capacity restrictions, returning
	 * <tt>true</tt> upon success and throwing an <tt>IllegalStateException</tt>
	 * if no space is currently available.
	 *
	 * <p>This implementation returns <tt>true</tt> if <tt>offer</tt> succeeds,
	 * 如果offer操作成功，這個實現返回true，否則拋出一個異常
	 * else throws an <tt>IllegalStateException</tt>.
	 *
	 * @param e the element to add
	 * @return <tt>true</tt> (as specified by {@link java.util.Collection#add})
	 * @throws IllegalStateException if the element cannot be added at this
	 *         time due to capacity restrictions
	 * @throws ClassCastException if the class of the specified element
	 *         prevents it from being added to this queue
	 * @throws NullPointerException if the specified element is null and
	 *         this queue does not permit null elements
	 * @throws IllegalArgumentException if some property of this element
	 *         prevents it from being added to this queue
	 */
	public boolean add(E e) {
		if (offer(e))
			return true;
		else
			throw new IllegalStateException("Queue full");
	}

	/**
	 * Adds all of the elements in the specified collection to this
	 * queue.  Attempts to addAll of a queue to itself result in
	 *         視圖在一個隊列中添加自身會拋出一個異常
	 * <tt>IllegalArgumentException</tt>. Further, the behavior of
	 * this operation is undefined if the specified collection is
	 * modified while the operation is in progress.
	 *
	 * <p>This implementation iterates over the specified collection,
	 * and adds each element returned by the iterator to this
	 * queue, in turn.  A runtime exception encountered while
	 *                  一個運行時異常發生當嘗試添加一個元素
	 * trying to add an element (including, in particular, a
	 *                                         特定的
	 * <tt>null</tt> element) may result in only some of the elements
	 * 元素導致僅僅相同的元素成功添加當關聯的異常拋出的時候
	 * having been successfully added when the associated exception is
	 * thrown.
	 *
	 * @param c collection containing elements to be added to this queue
	 * @return <tt>true</tt> if this queue changed as a result of the call
	 * @throws ClassCastException if the class of an element of the specified
	 *         collection prevents it from being added to this queue
	 * @throws NullPointerException if the specified collection contains a
	 *         null element and this queue does not permit null elements,
	 *         or if the specified collection is null
	 * @throws IllegalArgumentException if some property of an element of the
	 *         specified collection prevents it from being added to this
	 *         queue, or if the specified collection is this queue
	 * @throws IllegalStateException if not all the elements can be added at
	 *         this time due to insertion restrictions
	 * @see #add(Object)
	 */
	public boolean addAll(Collection<? extends E> c) {
		if (c == null)
			throw new NullPointerException();
		if (c == this)
			throw new IllegalArgumentException();
		boolean modified = false;
		for (E e : c)
			if (add(e))
				modified = true;
		return modified;
	}

























```
