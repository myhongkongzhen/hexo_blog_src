title: Collections -- BlockingDuque -- (十三)
date: 2015-12-11 14:32:31
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 BlockingDuque 詳解 (十)
> _由於LinkedList引用了Deque,所以這一節先學習Queue接口相關_
> 這一節主要學習集合框架中的 BlockingDuque 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### BlockingDuque 說明:
> Like any BlockingQueue, a BlockingDeque is thread safe

### BlockingDuque UML:
<img src="/images/Collections/Collection-BlockingDeque.png"  />

### BlockingDuque 源碼解析:
```

	/**
	 * Inserts the specified element at the front of this deque,
	 * waiting if necessary for space to become available.
	 * 必須等待空間成為可用
	 *
	 * @param e the element to add
	 * @throws InterruptedException if interrupted while waiting
	 * @throws ClassCastException if the class of the specified element
	 *         prevents it from being added to this deque
	 * @throws NullPointerException if the specified element is null
	 * @throws IllegalArgumentException if some property of the specified
	 *         element prevents it from being added to this deque
	 */
	void putFirst(E e) throws InterruptedException;
	
	/**
	 * Inserts the specified element at the front of this deque,
	 * waiting up to the specified wait time if necessary for space to
	 * become available.
	 *
	 * @param e the element to add
	 * @param timeout how long to wait before giving up, in units of
	 *                放棄前等待的時間   
	 *        <tt>unit</tt>
	 *        單位時間   
	 * @param unit a <tt>TimeUnit</tt> determining how to interpret the
	 *        <tt>timeout</tt> parameter
	 * @return <tt>true</tt> if successful, or <tt>false</tt> if
	 *         the specified waiting time elapses before space is available
	 * @throws InterruptedException if interrupted while waiting
	 * @throws ClassCastException if the class of the specified element
	 *         prevents it from being added to this deque
	 * @throws NullPointerException if the specified element is null
	 * @throws IllegalArgumentException if some property of the specified
	 *         element prevents it from being added to this deque
	 */
	boolean offerFirst(E e, long timeout, TimeUnit unit)
			throws InterruptedException;
	
	/**
	 * Inserts the specified element into the queue represented by this deque
	 *                                              意味著
	 * (in other words, at the tail of this deque) if it is possible to do so
	 * immediately without violating capacity restrictions, returning
	 * <tt>true</tt> upon success and throwing an
	 * <tt>IllegalStateException</tt> if no space is currently available.
	 * When using a capacity-restricted deque, it is generally preferable to
	 * use {@link #offer(Object) offer}.
	 *
	 * <p>This method is equivalent to {@link #addLast(Object) addLast}.
	 *
	 * @param e the element to add
	 * @throws IllegalStateException {@inheritDoc}
	 * @throws ClassCastException if the class of the specified element
	 *         prevents it from being added to this deque
	 * @throws NullPointerException if the specified element is null
	 * @throws IllegalArgumentException if some property of the specified
	 *         element prevents it from being added to this deque
	 */
	boolean add(E e);
	
	/**
	 * Pushes an element onto the stack represented by this deque.  In other
	 *                                  意味著
	 * words, inserts the element at the front of this deque unless it would
	 *                                                       除非
	 * violate capacity restrictions.
	 *
	 * <p>This method is equivalent to {@link #addFirst(Object) addFirst}.
	 *
	 * @throws IllegalStateException {@inheritDoc}
	 * @throws ClassCastException {@inheritDoc}
	 * @throws NullPointerException if the specified element is null
	 * @throws IllegalArgumentException {@inheritDoc}
	 */
	void push(E e);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
```
