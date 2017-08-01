title: Collections -- Deque -- (十二)
date: 2015-12-10 17:17:38
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 Deque 詳解 (九)
> _由於LinkedList引用了Deque,所以這一節先學習Queue接口相關_
> 這一節主要學習集合框架中的 Deque 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### Deque 說明:

### Deque UML:
<img src="/images/JDK/Collections/Collection-Deque.png"  />

### Deque 源碼解析:
```
/**
 * Inserts the specified element at the front of this deque if it is
 * 插入指定的元素在deque的前驅
 * possible to do so immediately without violating capacity restrictions.
 * 如果沒有違反容量限制會理解插入
 * When using a capacity-restricted deque, it is generally preferable to
 * 當使用有限容量的deque,
 * use method {@link #offerFirst}.
 * 一般更喜歡使用offerFirst方法
 *
 * @param e the element to add
 * @throws IllegalStateException if the element cannot be added at this
 *         time due to capacity restrictions
 * @throws ClassCastException if the class of the specified element
 *         prevents it from being added to this deque
 * @throws NullPointerException if the specified element is null and this
 *         deque does not permit null elements
 * @throws IllegalArgumentException if some property of the specified
 *         element prevents it from being added to this deque
 */
void addFirst(E e);

/**
 * Inserts the specified element at the front of this deque if it is
 * 插入指定的元素在deque的前驅
 * possible to do so immediately without violating capacity restrictions.
 * 如果沒有違反容量限制會理解插入
 * When using a capacity-restricted deque, it is generally preferable to
 * 當使用有限容量的deque,
 * use method {@link #offerFirst}.
 * 一般更喜歡使用offerFirst方法
 *
 * @param e the element to add
 * @throws IllegalStateException if the element cannot be added at this
 *         time due to capacity restrictions
 * @throws ClassCastException if the class of the specified element
 *         prevents it from being added to this deque
 * @throws NullPointerException if the specified element is null and this
 *         deque does not permit null elements
 * @throws IllegalArgumentException if some property of the specified
 *         element prevents it from being added to this deque
 */
void addFirst(E e);

/**
 * Inserts the specified element at the front of this deque unless it would
 * 插入一個指定的元素在deque的前驅
 * violate capacity restrictions.  When using a capacity-restricted deque,
 * 直到他違反了容量限制
 * this method is generally preferable to the {@link #addFirst} method,
 * 當使用一個有限容量deque,這個方法通常比addFirst方法更好
 * which can fail to insert an element only by throwing an exception.
 * 它能夠由拋出一個異常表示添加元素失敗
 *
 * @param e the element to add
 * @return <tt>true</tt> if the element was added to this deque, else
 *         <tt>false</tt>
 * @throws ClassCastException if the class of the specified element
 *         prevents it from being added to this deque
 *         防止
 * @throws NullPointerException if the specified element is null and this
 *         deque does not permit null elements
 * @throws IllegalArgumentException if some property of the specified
 *         element prevents it from being added to this deque
 */
boolean offerFirst(E e);

/**
 * Inserts the specified element at the end of this deque unless it would
 * 添加指定的元素在deque的末尾
 * violate capacity restrictions.  When using a capacity-restricted deque,
 * 直到違反容量限制
 * this method is generally preferable to the {@link #addLast} method,
 * 當使用一個有限容量deque，這個方法通常是更優於addLast方法
 * which can fail to insert an element only by throwing an exception.
 *
 * @param e the element to add
 * @return <tt>true</tt> if the element was added to this deque, else
 *         <tt>false</tt>
 * @throws ClassCastException if the class of the specified element
 *         prevents it from being added to this deque
 * @throws NullPointerException if the specified element is null and this
 *         deque does not permit null elements
 * @throws IllegalArgumentException if some property of the specified
 *         element prevents it from being added to this deque
 */
boolean offerLast(E e);

/**
 * Retrieves and removes the first element of this deque.  This method
 * 檢查和移除deque的首元素
 * differs from {@link #pollFirst pollFirst} only in that it throws an
 * 這個方法與pollFirst方法不同之處僅僅在於如果deque是一個empty他會拋出一個異常
 * exception if this deque is empty.
 *
 * @return the head of this deque
 * @throws NoSuchElementException if this deque is empty
 */
E removeFirst();

/**
 * Retrieves and removes the first element of this deque,
 * 檢查和移除隊列中的首元素
 * or returns <tt>null</tt> if this deque is empty.
 * 如果隊列為空，返回null
 *
 * @return the head of this deque, or <tt>null</tt> if this deque is empty
 */
E pollFirst();

/**
 * Retrieves, but does not remove, the first element of this deque.
 * 檢查，但不移除隊列中的首元素
 * This method differs from {@link #peekFirst peekFirst} only in that it
 * 與peekFirst方法不同之處僅僅為當隊列為空，拋出一個異常
 * throws an exception if this deque is empty.
 *
 * @return the head of this deque
 * @throws NoSuchElementException if this deque is empty
 */
E getFirst();

/**
 * Retrieves, but does not remove, the first element of this deque,
 * or returns <tt>null</tt> if this deque is empty.
 * 如果隊列為空，返回null
 *
 * @return the head of this deque, or <tt>null</tt> if this deque is empty
 */
E peekFirst();

/**
 * Removes the first occurrence of the specified element from this deque.
 * 移除隊列中第一個發現的指定元素
 * If the deque does not contain the element, it is unchanged.
 * 如果隊列中不包含這個元素,隊列不會改變
 * More formally, removes the first element <tt>e</tt> such that
 * 更嚴格的講，移除第一個元素e
 * <tt>(o==null&nbsp;?&nbsp;e==null&nbsp;:&nbsp;o.equals(e))</tt>
 * 當(o == null ? e == null : e.equals(e))
 * (if such an element exists).
 * 如果這樣的元素存在
 * Returns <tt>true</tt> if this deque contained the specified element
 * 如果隊列包含了指定元素，返回true
 * (or equivalently, if this deque changed as a result of the call).
 * 與之相應的，作為調用的結果對聯改變了。
 *
 * @param o element to be removed from this deque, if present
 * @return <tt>true</tt> if an element was removed as a result of this call
 * @throws ClassCastException if the class of the specified element
 *         is incompatible with this deque
 * (<a href="Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if the specified element is null and this
 *         deque does not permit null elements
 * (<a href="Collection.html#optional-restrictions">optional</a>)
 */
boolean removeFirstOccurrence(Object o);

	/**
	 * Inserts the specified element into the queue represented by this deque
	 * 添加指定的元素到隊列中意味著如果沒有違反容量限制，他會立即執行
	 * (in other words, at the tail of this deque) if it is possible to do so
	 * immediately without violating capacity restrictions, returning
	 * <tt>true</tt> upon success and throwing an
	 * 成功返回true
	 * <tt>IllegalStateException</tt> if no space is currently available.
	 * 如果當前沒有可用空間會拋出一個異常
	 * When using a capacity-restricted deque, it is generally preferable to
	 * 當使用一個有限隊列，通常更好的做法是使用offer方法
	 * use {@link #offer(Object) offer}.
	 *
	 * <p>This method is equivalent to {@link #addLast}.
	 * 這個方法等效于addLast方法
	 *
	 * @param e the element to add
	 * @return <tt>true</tt> (as specified by {@link java.util.Collection#add})
	 * @throws IllegalStateException if the element cannot be added at this
	 *         time due to capacity restrictions
	 * @throws ClassCastException if the class of the specified element
	 *         prevents it from being added to this deque
	 * @throws NullPointerException if the specified element is null and this
	 *         deque does not permit null elements
	 * @throws IllegalArgumentException if some property of the specified
	 *         element prevents it from being added to this deque
	 */
	boolean add(E e);

	/**
	 * Inserts the specified element into the queue represented by this deque
	 * (in other words, at the tail of this deque) if it is possible to do so
	 * immediately without violating capacity restrictions, returning
	 * <tt>true</tt> upon success and <tt>false</tt> if no space is currently
	 *                                如果沒有可用空間，返回false
	 * available.  When using a capacity-restricted deque, this method is
	 * generally preferable to the {@link #add} method, which can fail to
	 * insert an element only by throwing an exception.
	 * 僅僅由拋出一個異常表示添加元素失敗
	 *
	 * <p>This method is equivalent to {@link #offerLast}.
	 *
	 * @param e the element to add
	 * @return <tt>true</tt> if the element was added to this deque, else
	 *         <tt>false</tt>
	 * @throws ClassCastException if the class of the specified element
	 *         prevents it from being added to this deque
	 * @throws NullPointerException if the specified element is null and this
	 *         deque does not permit null elements
	 * @throws IllegalArgumentException if some property of the specified
	 *         element prevents it from being added to this deque
	 */
	boolean offer(E e);

	/**
	 * Retrieves, but does not remove, the head of the queue represented by
	 * 檢查，但不移除
	 * this deque (in other words, the first element of this deque).
	 * This method differs from {@link #peek peek} only in that it throws an
	 * exception if this deque is empty.
	 *
	 * <p>This method is equivalent to {@link #getFirst()}.
	 *
	 * @return the head of the queue represented by this deque
	 * @throws NoSuchElementException if this deque is empty
	 */
	E element();

	/**
	 * Retrieves, but does not remove, the head of the queue represented by
	 * this deque (in other words, the first element of this deque), or
	 * returns <tt>null</tt> if this deque is empty.
	 *
	 * <p>This method is equivalent to {@link #peekFirst()}.
	 *
	 * @return the head of the queue represented by this deque, or
	 *         <tt>null</tt> if this deque is empty
	 */
	E peek();

	/**
	 * Pushes an element onto the stack represented by this deque (in other
	 * 壓入一個元到棧中意味著這個隊列如果沒有違反容量限制會立即執行
	 * words, at the head of this deque) if it is possible to do so
	 * immediately without violating capacity restrictions, returning
	 * <tt>true</tt> upon success and throwing an
	 * 成功返回true
	 * <tt>IllegalStateException</tt> if no space is currently available.
	 * 如果滅有可用空間拋出一個異常
	 *
	 * <p>This method is equivalent to {@link #addFirst}.
	 *
	 * @param e the element to push
	 * @throws IllegalStateException if the element cannot be added at this
	 *         time due to capacity restrictions
	 * @throws ClassCastException if the class of the specified element
	 *         prevents it from being added to this deque
	 * @throws NullPointerException if the specified element is null and this
	 *         deque does not permit null elements
	 * @throws IllegalArgumentException if some property of the specified
	 *         element prevents it from being added to this deque
	 */
	void push(E e);

	/**
	 * Returns an iterator over the elements in this deque in reverse 
	 *                                                        相反
	 * sequential order.  The elements will be returned in order from
	 * 的序列順序
	 * last (tail) to first (head).
	 * 從尾到頭
	 *
	 * @return an iterator over the elements in this deque in reverse
	 * sequence
	 */
	Iterator<E> descendingIterator();



```
