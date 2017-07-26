title: Collections -- LinkedBlockingDeque -- (十五)
date: 2015-12-11 17:34:27
categories: 技術
tags:
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 LinkedBlockingDeque 詳解 (十二)
> _由於LinkedList引用了Deque,所以這一節先學習Queue接口相關，本實現類使用了JUC下的ReentrantLock鎖類，該類在學習鎖時詳細學習_
> 這一節主要學習集合框架中的 LinkedBlockingDeque 成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->

### LinkedBlockingDeque 說明:
> 三個內部類
```
static final class Node<E> { ... } // 雙向列表節點
private abstract class AbstractItr implements Iterator<E> { ... } // 迭代器抽象類
private class Itr extends AbstractItr { ... } // 升序
private class DescendingItr extends AbstractItr { .. } // 降序
```
> 線程安全的實現方式
```
final ReentrantLock lock = new ReentrantLock();
private final Condition notEmpty = lock.newCondition();
private final Condition notFull = lock.newCondition();
```

### LinkedBlockingDeque UML:
<img src="/images/JDK/Collections/Collection-LinkedBlockingDeque.png"  />

### LinkedBlockingDeque 源碼解析:
```

	/** Doubly-linked list node class */
	/** 雙端鏈錶節點類 */
	static final class Node<E> {
		/**
		 * The item, or null if this node has been removed.
		 * 條目，如果已經刪除，則為null
		 */
		E item;

		/**
		 * One of:
		 * - the real predecessor Node
		 * - 真實的前任節點
		 * - this Node, meaning the predecessor is tail
		 * - 這個節點，意味著前任為結尾
		 * - null, meaning there is no predecessor
		 * - null，意味著沒有前任
		 */
		Node<E> prev;

		/**
		 * One of:
		 * - the real successor Node
		 * - 真實的後繼
		 * - this Node, meaning the successor is head
		 * - 節點，意味著後繼為頭
		 * - null, meaning there is no successor
		 * - null,意味著沒有後繼
		 */
		Node<E> next;

		Node(E x) {
			item = x;
		}
	}

	/** Main lock guarding all access */
	/** 所有存儲訪問的主要守護鎖 */
	final ReentrantLock lock = new ReentrantLock();

	/** Condition for waiting takes 等待取出條件 */
	private final Condition notEmpty = lock.newCondition();

	/** Condition for waiting puts 等待放置條件 */
	private final Condition notFull = lock.newCondition();

	/**
	 * Creates a {@code LinkedBlockingDeque} with a capacity of
	 * {@link Integer#MAX_VALUE}, initially containing the elements of
	 * the given collection, added in traversal order of the
	 * collection's iterator.
	 * 按照添加的集合迭代遍歷順序
	 *
	 * @param c the collection of elements to initially contain
	 * @throws NullPointerException if the specified collection or any
	 *         of its elements are null
	 *         如果指定的集合或者他的任意元素為null，拋出異常
	 */
	public LinkedBlockingDeque( Collection<? extends E> c) {
		this(Integer.MAX_VALUE);
		final ReentrantLock lock = this.lock;
		lock.lock(); // Never contended, but necessary for visibility
		try {
			for (E e : c) {
				if (e == null)
					throw new NullPointerException();
				if (!linkLast(new Node<E>(e)))
					throw new IllegalStateException("Deque full");
			}
		} finally {
			lock.unlock();
		}
	}

	/**
	 * Returns the number of additional elements that this deque can ideally
	 * 返回隊列理想情況無阻賽訪問的元素的數量
	 * (in the absence of memory or resource constraints) accept without
	 * (在內存不足或資源)
	 * blocking. This is always equal to the initial capacity of this deque
	 * less the current {@code size} of this deque.
	 *
	 * <p>Note that you <em>cannot</em> always tell if an attempt to insert
	 * an element will succeed by inspecting {@code remainingCapacity}
	 * because it may be the case that another thread is about to
	 * insert or remove an element.
	 */
	public int remainingCapacity() {
		final ReentrantLock lock = this.lock;
		lock.lock();
		try {
			return capacity - count;
		} finally {
			lock.unlock();
		}
	}

	/**
	 * Returns an array containing all of the elements in this deque, in
	 * proper sequence; the runtime type of the returned array is that of
	 * the specified array.  If the deque fits in the specified array, it
	 * is returned therein.  Otherwise, a new array is allocated with the
	 * runtime type of the specified array and the size of this deque.
	 *
	 * <p>If this deque fits in the specified array with room to spare
	 * (i.e., the array has more elements than this deque), the element in
	 * the array immediately following the end of the deque is set to
	 * {@code null}.
	 *
	 * <p>Like the {@link #toArray()} method, this method acts as bridge between
	 * array-based and collection-based APIs.  Further, this method allows
	 * precise control over the runtime type of the output array, and may,
	 * 精確
	 * under certain circumstances, be used to save allocation costs.
	 *               情況
	 *
	 * <p>Suppose {@code x} is a deque known to contain only strings.
	 * The following code can be used to dump the deque into a newly
	 * allocated array of {@code String}:
	 *
	 * <pre>
	 *     String[] y = x.toArray(new String[0]);</pre>
	 *
	 * Note that {@code toArray(new Object[0])} is identical in function to
	 * {@code toArray()}.
	 *
	 * @param a the array into which the elements of the deque are to
	 *          be stored, if it is big enough; otherwise, a new array of the
	 *          same runtime type is allocated for this purpose
	 * @return an array containing all of the elements in this deque
	 * @throws ArrayStoreException if the runtime type of the specified array
	 *         is not a supertype of the runtime type of every element in
	 *         this deque
	 * @throws NullPointerException if the specified array is null
	 */
	@SuppressWarnings("unchecked")
	public <T> T[] toArray(T[] a) {
		final ReentrantLock lock = this.lock;
		lock.lock();
		try {
			if (a.length < count)
				a = (T[])java.lang.reflect.Array.newInstance
						(a.getClass().getComponentType(), count);

			int k = 0;
			for (Node<E> p = first; p != null; p = p.next)
				a[k++] = (T)p.item;
			if (a.length > k)
				a[k] = null;
			return a;
		} finally {
			lock.unlock();
		}
	}

// 插入刪除主要操作

	// Basic linking and unlinking operations, called only while holding lock

	/**
	 * Links node as first element, or returns false if full.
	 */
	private boolean linkFirst(Node<E> node) {
		// assert lock.isHeldByCurrentThread();
		if (count >= capacity)
			return false;
		Node<E> f = first;
		node.next = f;
		first = node;
		if (last == null)
			last = node;
		else
			f.prev = node;
		++count;
		notEmpty.signal();
		return true;
	}

	/**
	 * Links node as last element, or returns false if full.
	 * 連邊節點最後一個元素，或者如果full返回false
	 */
	private boolean linkLast(Node<E> node) {
		// assert lock.isHeldByCurrentThread();
		if (count >= capacity)
			return false;
		Node<E> l = last;
		node.prev = l;
		last = node;
		if (first == null)
			first = node;
		else
			l.next = node;
		++count;
		notEmpty.signal();
		return true;
	}

	/**
	 * Removes and returns first element, or null if empty.
	 */
	private E unlinkFirst() {
		// assert lock.isHeldByCurrentThread();
		Node<E> f = first;
		if (f == null)
			return null;
		Node<E> n = f.next;
		E item = f.item;
		f.item = null;
		f.next = f; // help GC
		first = n;
		if (n == null)
			last = null;
		else
			n.prev = null;
		--count;
		notFull.signal();
		return item;
	}

	/**
	 * Removes and returns last element, or null if empty.
	 */
	private E unlinkLast() {
		// assert lock.isHeldByCurrentThread();
		Node<E> l = last;
		if (l == null)
			return null;
		Node<E> p = l.prev;
		E item = l.item;
		l.item = null;
		l.prev = l; // help GC
		last = p;
		if (p == null)
			first = null;
		else
			p.next = null;
		--count;
		notFull.signal();
		return item;
	}


```
