title: Collections -- AbstractList -- (七) 
date: 2015-12-07 16:45:16
categories: 技術
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 AbstractList 抽象類詳解 (四) 
> 這一節主要學習集合框架中的AbstractList抽象類的成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->  

#### AbstractList List接口抽象類
> 定義了最小化的一般通用的方法實現

```
protected transient int modCount = 0; // fail-fast機制的實現：transient,如果擴展子類不需要此機制,modCount會ignore
/**
 * 遺留問題：這裡為什麼使用 transient 關鍵字，而不是 volatile ？ 
 * 如果是 volatile 關鍵字可以理解為內存可見，所以無亂那個線程修改了集合，那麼modCount都能感知到，與之比對的 expectedModCount
 * 都能發現值不同，因此發生 ConcurrentModificationException 異常。
 * 但是為何使用 transient 呢？ 這個關鍵字不是與 序列化 相關嗎？
 * 難道這裡 集合 迭代過程中 有 序列化 的相關操作？
 * 暫時未想明白，遺留一下這個問題 
 *
 *
 * 回答上面的遺留問題,這個modCount只是感知結構化發生變化的次數(見API DOC)
 * 而這個次數,並不需要序列化操作,僅僅存在調用者內存中即可,應該是出於性能考慮
 * 因此與 volatile 或者改變的內存值 沒有任何關係./(ㄒoㄒ)/~~ 我想多了,不是，是想彎路了
 */
```

AbstractList抽象類包含方法:
<!--<img src="/images/Collections/Collection-AbstractCollection.png"  />-->

實現類源碼解析:
```
/**
 * Sole constructor.  (For invocation by subclass constructors, typically
 * 唯一的構造器.(.隱含的有子類調用)
 * implicit.)
 */
protected AbstractList() {
}

/**
 * Appends the specified element to the end of this list (optional
 * 添加指定元素到list的末尾，可選的操作
 * operation).
 *
 * <p>Lists that support this operation may place limitations on what
 * 支持這個操作的list可以限制添加至這個list的的元素的放置地點
 * elements may be added to this list.  In particular, some
 *                                      特別說明，
 * lists will refuse to add null elements, and others will impose
 * 一些list會拒絕添加null元素，
 * restrictions on the type of elements that may be added.  List
 * 而另一些list會加上添加至這個list的元素的類型限制.
 * classes should clearly specify in their documentation any restrictions
 * List類要在他們的文檔中明確添加至list的元素的限制條件的詳細說明
 * on what elements may be added.
 *
 * <p>This implementation calls {@code add(size(), e)}.
 * 這個實現調用add(size(),e).
 *
 * <p>Note that this implementation throws an
 * 注意這個實現如果沒有複寫add(int,Object)
 * {@code UnsupportedOperationException} unless
 * add(int ,E)會拋出一個異常 UnsupportedOperationException
 * {@link #add(int, Object) add(int, E)} is overridden.
 *
 * @param e element to be appended to this list
 * @return {@code true} (as specified by {@link Collection#add})
 * @throws UnsupportedOperationException if the {@code add} operation
 *         is not supported by this list
 * @throws ClassCastException if the class of the specified element
 *         prevents it from being added to this list
 * @throws NullPointerException if the specified element is null and this
 *         list does not permit null elements
 * @throws IllegalArgumentException if some property of this element
 *         prevents it from being added to this list
 */
public boolean add(E e) {
    add(size(), e);
    return true;
}

/**
 * {@inheritDoc}
 *
 * <p>This implementation always throws an
 * 這個實現總是拋出異常 UnsupportedOperationException
 * {@code UnsupportedOperationException}.
 *
 * @throws UnsupportedOperationException {@inheritDoc}
 * @throws ClassCastException            {@inheritDoc}
 * @throws NullPointerException          {@inheritDoc}
 * @throws IllegalArgumentException      {@inheritDoc}
 * @throws IndexOutOfBoundsException     {@inheritDoc}
 */
public E set(int index, E element) {
    throw new UnsupportedOperationException();
}

/**
 * {@inheritDoc}
 *
 * <p>This implementation always throws an
 * {@code UnsupportedOperationException}.
 *
 * @throws UnsupportedOperationException {@inheritDoc}
 * @throws ClassCastException            {@inheritDoc}
 * @throws NullPointerException          {@inheritDoc}
 * @throws IllegalArgumentException      {@inheritDoc}
 * @throws IndexOutOfBoundsException     {@inheritDoc}
 */
public void add(int index, E element) {
    throw new UnsupportedOperationException();
}

/**
 * {@inheritDoc}
 *
 * <p>This implementation always throws an
 * {@code UnsupportedOperationException}.
 *
 * @throws UnsupportedOperationException {@inheritDoc}
 * @throws IndexOutOfBoundsException     {@inheritDoc}
 */
public E remove(int index) {
    throw new UnsupportedOperationException();
}

/**
 * {@inheritDoc}
 *
 * <p>This implementation first gets a list iterator (with
 * 這個實現首先獲取一個list迭代器(有listIterator獲得)
 * {@code listIterator()}).  Then, it iterates over the list until the
 *                           而後,由迭代器遍歷list直到發現指定的元素,
 * specified element is found or the end of the list is reached.
 *                            或者list到達list的末尾.
 *
 * @throws ClassCastException   {@inheritDoc}
 * @throws NullPointerException {@inheritDoc}
 */
public int indexOf(Object o) {
    //獲取listIterator雙向迭代器
    ListIterator<E> it = listIterator();
    if (o==null) { // 指定元素為null
        while (it.hasNext()) // 遍歷本list
            if (it.next()==null) // 本list存在null元素
                return it.previousIndex(); // 返回 此元素索引
    } else {
        while (it.hasNext())
            if (o.equals(it.next())) // 判斷指定元素與本list中的元素是否相等
                return it.previousIndex();
    }
    return -1;
}

/**
 * {@inheritDoc}
 *
 * <p>This implementation returns {@code listIterator(0)}.
 * 這個實現返回listIterator(0)
 *
 * @see #listIterator(int)
 */
public ListIterator<E> listIterator() {
    return listIterator(0);
}
	
/**
 * {@inheritDoc}
 *
 * <p>This implementation returns a straightforward implementation of the
 * 這個實現返回了一個簡單的ListIterator接口的實現.
 * {@code ListIterator} interface that extends the implementation of the
 * 這個實現擴展了由iterator()方法返回的Iterator接口的實現.
 * {@code Iterator} interface returned by the {@code iterator()} method.
 * The {@code ListIterator} implementation relies on the backing list's
 * 這個ListIterator實現依賴於集合的get(int),set(int,E),add(int,E)以及
 * {@code get(int)}, {@code set(int, E)}, {@code add(int, E)}
 * and {@code remove(int)} methods.
 * remove(int)方法為基礎.
 *
 * <p>Note that the list iterator returned by this implementation will
 * 注意由這個實現返回的list迭代器在響應remove,set,add時會拋出一個異常.
 * throw an {@link UnsupportedOperationException} in response to its
 * {@code remove}, {@code set} and {@code add} methods unless the
 * 除非這個list的remove,set,add方法重寫了.
 * list's {@code remove(int)}, {@code set(int, E)}, and
 * {@code add(int, E)} methods are overridden.
 *
 * <p>This implementation can be made to throw runtime exceptions in the
 * 這個實現在並發改變時會拋出一個運行時異常,
 * face of concurrent modification, as described in the specification for
 * the (protected) {@link #modCount} field.
 * 在受保護的modCount域中詳細的描述
 *
 * @throws IndexOutOfBoundsException {@inheritDoc}
 */
public ListIterator<E> listIterator(final int index) {
    rangeCheckForAdd(index); // 範圍校驗

    return new ListItr(index); // private 內部類
}

private void rangeCheckForAdd(int index) {
    if (index < 0 || index > size()) // 索引超出size範圍，數組越界異常
        throw new IndexOutOfBoundsException(outOfBoundsMsg(index));
}

private class Itr implements Iterator<E> {
    /**
     * Index of element to be returned by subsequent call to next.
     * 由子序列調用下一個返回的元素的索引
     */
    int cursor = 0;

    /**
     * Index of element returned by most recent call to next or
     * 由最近調用的後繼或前驅返回的元素的索引
     * previous.  Reset to -1 if this element is deleted by a call
     *            如果調用remove使得元素刪除了，則重置為-1
     * to remove.
     */
    int lastRet = -1;

    /**
     * The modCount value that the iterator believes that the backing
     * 迭代器相信list支持的modCount值應該存在.
     * List should have.  If this expectation is violated, the iterator
     *                    如果違反了期望,
     * has detected concurrent modification.
     * 這個迭代器會檢測到並發的改變.
     */
    int expectedModCount = modCount;

    // 判斷是否存在下一個
    public boolean hasNext() {
        return cursor != size();
    }

    // 返回下一個元素
    public E next() {
        // fail-fast檢測
        checkForComodification();
        try {
            int i = cursor;
            E next = get(i);
            lastRet = i;
            cursor = i + 1;
            return next;
        } catch (IndexOutOfBoundsException e) {
            checkForComodification();
            throw new NoSuchElementException();
        }
    }

    // 移除
    public void remove() {
        if (lastRet < 0)
            throw new IllegalStateException();
        checkForComodification();

        try {
            AbstractList.this.remove(lastRet);
            if (lastRet < cursor)
                cursor--;
            lastRet = -1;
            expectedModCount = modCount;
        } catch (IndexOutOfBoundsException e) {
            throw new ConcurrentModificationException();
        }
    }

    final void checkForComodification() {
        if (modCount != expectedModCount)
            throw new ConcurrentModificationException();
    }
}

private class ListItr extends Itr implements ListIterator<E> {
    ListItr(int index) {
        cursor = index;
    }

    // 存在前向元素
    public boolean hasPrevious() {
        return cursor != 0;
    }

    // 返回前驅元素
    public E previous() {
        // 檢查元素是否並發修改了，fail-fast機制
        checkForComodification();
        try {
            int i = cursor - 1;
            E previous = get(i);
            lastRet = cursor = i;
            return previous;
        } catch (IndexOutOfBoundsException e) {
            checkForComodification();
            throw new NoSuchElementException();
        }
    }

    // 後繼索引
    public int nextIndex() {
        return cursor;
    }

    // 前驅索引
    public int previousIndex() {
        return cursor-1;
    }

    public void set(E e) {
        if (lastRet < 0)
            throw new IllegalStateException();
        checkForComodification();

        try {
            AbstractList.this.set(lastRet, e);
            expectedModCount = modCount;
        } catch (IndexOutOfBoundsException ex) {
            throw new ConcurrentModificationException();
        }
    }

    public void add(E e) {
        checkForComodification();

        try {
            int i = cursor;
            AbstractList.this.add(i, e);
            lastRet = -1;
            cursor = i + 1;
            expectedModCount = modCount;
        } catch (IndexOutOfBoundsException ex) {
            throw new ConcurrentModificationException();
        }
    }
}

/**
 * The number of times this list has been <i>structurally modified</i>.
 * 這個list已經結構修改的次數.
 * Structural modifications are those that change the size of the
 * 結構修改是 那些list的大小改變了,
 * list, or otherwise perturb it in such a fashion that iterations in
 *       或者除此以外的例如迭代器在使用過程中產生不正確結果的狀況.
 * progress may yield incorrect results.
 *
 * <p>This field is used by the iterator and list iterator implementation
 * 這個域用於有迭代器iterator或者listIterator方法返回的實現.
 * returned by the {@code iterator} and {@code listIterator} methods.
 * If the value of this field changes unexpectedly, the iterator (or list
 * 如果這個域的值無法預料的改變了,
 * iterator) will throw a {@code ConcurrentModificationException} in
 * 那麼迭代器會在響應next,remove,previous,set,add操作時拋出一個異常
 * response to the {@code next}, {@code remove}, {@code previous},
 * {@code set} or {@code add} operations.  This provides
 * <i>fail-fast</i> behavior, rather than non-deterministic behavior in
 * 其提供了fail-fast行為,而不是非確定性行為在迭代過程中並發的改變其表面現象.
 * the face of concurrent modification during iteration.
 *
 * <p><b>Use of this field by subclasses is optional.</b> If a subclass
 * 子類中這個域的使用是可選的.
 * wishes to provide fail-fast iterators (and list iterators), then it
 * 如果一個子類希望提供fail-fast迭代,
 * merely has to increment this field in its {@code add(int, E)} and
 * 那麼他僅僅提供這個與在add,remove(和一些其他的複寫list結構改變的結果的方法)方法
 * {@code remove(int)} methods (and any other methods that it overrides
 * 的增量
 * that result in structural modifications to the list).  A single call to
 * {@code add(int, E)} or {@code remove(int)} must add no more than
 * 單獨的調用add或者remove必須添加不多於這個域的一個，
 * one to this field, or the iterators (and list iterators) will throw
 * 或者迭代器拋出一個虛假的異常
 * bogus {@code ConcurrentModificationExceptions}.  If an implementation
 * does not wish to provide fail-fast iterators, this field may be
 * 如果一個實現不希望提供fail-fast迭代，這個域會ignore
 * ignored.
 */
protected transient int modCount = 0; // fail-fast機制的實現：transient

/**
 * {@inheritDoc}
 *
 * <p>This implementation first gets a list iterator that points to the end
 * 這個實現首先返回一個指向list結果的迭代器
 * of the list (with {@code listIterator(size())}).  Then, it iterates
 * (由listIterator(size)提供)
 * backwards over the list until the specified element is found, or the
 * 而後,迭代器向後迭代,知道發現指定的元素
 * beginning of the list is reached.
 * 或者到達list的開始.
 *
 * @throws ClassCastException   {@inheritDoc}
 * @throws NullPointerException {@inheritDoc}
 */
public int lastIndexOf(Object o) {
    ListIterator<E> it = listIterator(size());
    if (o==null) {
        while (it.hasPrevious()) // 向後遍歷
            if (it.previous()==null) // 後繼是否為null
                return it.nextIndex();
    } else {
        while (it.hasPrevious())
            if (o.equals(it.previous()))
                return it.nextIndex();
    }
    return -1;
}

/**
 * Removes all of the elements from this list (optional operation).
 * 從集合中移除所有的元素
 * The list will be empty after this call returns.
 * 這個方法調用後會返回一個empty集合
 *
 * <p>This implementation calls {@code removeRange(0, size())}.
 *
 * <p>Note that this implementation throws an
 * {@code UnsupportedOperationException} unless {@code remove(int
 * index)} or {@code removeRange(int fromIndex, int toIndex)} is
 * overridden.
 *
 * @throws UnsupportedOperationException if the {@code clear} operation
 *         is not supported by this list
 */
public void clear() {
    removeRange(0, size());
}

/**
 * Removes from this list all of the elements whose index is between
 * 從集合中移除包含fromIndex索引到toIndex除外之間的所有元素。[fromIndex,toIndex)
 * {@code fromIndex}, inclusive, and {@code toIndex}, exclusive.
 * Shifts any succeeding elements to the left (reduces their index).
 * 改變任何成功的元素會向左減少他們的索引.
 * This call shortens the list by {@code (toIndex - fromIndex)} elements.
 * 這個方法調用有(toIndex-fromIndex)元素縮短集合.
 * (If {@code toIndex==fromIndex}, this operation has no effect.)
 * 如果 toIndex == fromIndex ，那麼，這個操作不熟任何影響
 *
 * <p>This method is called by the {@code clear} operation on this list
 * 這個方法由list或他的子list的clear方法調用
 * and its subLists.  Overriding this method to take advantage of
 * the internals of the list implementation can <i>substantially</i>
 * 複寫這個方法能夠使得list實現的內部有利條件
 * improve the performance of the {@code clear} operation on this list
 * 提高list和他的子list的clear操作性能
 * and its subLists.
 *
 * <p>This implementation gets a list iterator positioned before
 * 這個實現在fromIndex之前獲得一個迭代器位置,
 * {@code fromIndex}, and repeatedly calls {@code ListIterator.next}
 * 並且重複調用ListIterator.next方法在ListIterator.remove方法之後，
 * followed by {@code ListIterator.remove} until the entire range has
 *                                           直到移除了整個範圍
 * been removed.  <b>Note: if {@code ListIterator.remove} requires linear
 * 注意：如果ListIterator.remove需要線性時間
 * time, this implementation requires quadratic time.</b>
 * 整個實現需要平方的時間
 *
 * @param fromIndex index of first element to be removed
 * @param toIndex index after last element to be removed
 */
protected void removeRange(int fromIndex, int toIndex) {
    ListIterator<E> it = listIterator(fromIndex);
    for (int i=0, n=toIndex-fromIndex; i<n; i++) {
        it.next();
        it.remove();
    }
}

/**
 * Returns an iterator over the elements in this list in proper sequence.
 * 返回在這個list中的正確的序列的迭代器
 *
 * <p>This implementation returns a straightforward implementation of the
 * 這個實現返回一個有迭代接口返回的簡單實現
 * iterator interface, relying on the backing list's {@code size()},
 *  依託list的size(),get(int)以及remove(int)方法
 * {@code get(int)}, and {@code remove(int)} methods.
 *
 * <p>Note that the iterator returned by this method will throw an
 * {@link UnsupportedOperationException} in response to its
 * {@code remove} method unless the list's {@code remove(int)} method is
 * overridden.
 *
 * <p>This implementation can be made to throw runtime exceptions in the
 * face of concurrent modification, as described in the specification
 * for the (protected) {@link #modCount} field.
 *
 * @return an iterator over the elements in this list in proper sequence
 */
public Iterator<E> iterator() {
    return new Itr();
}

/**
 * Compares the specified object with this list for equality.  Returns
 * 比較指定的obj與此list的相等性.
 * {@code true} if and only if the specified object is also a list, both
 * 當且僅當指定的obj也是一個list，
 * lists have the same size, and all corresponding pairs of elements in
 * 兩個list有相同size
 * the two lists are <i>equal</i>.  (Two elements {@code e1} and
 * 並且所有相應元素對在兩個list中都是相等的
 * {@code e2} are <i>equal</i> if {@code (e1==null ? e2==null :
 * e1.equals(e2))}.)  In other words, two lists are defined to be
 * equal if they contain the same elements in the same order.<p>
 * 換句話，兩個list如果他們在相同的排列中包含相同的元素則標記為相等
 *
 * This implementation first checks if the specified object is this
 * 這個實現首先檢查指定的元素是不是當前list
 * list. If so, it returns {@code true}; if not, it checks if the
 * 如果是，返回true;如果不是，檢查指定的obj是否是一個list
 * specified object is a list. If not, it returns {@code false}; if so,
 * 如果不是，返回false;
 * it iterates over both lists, comparing corresponding pairs of elements.
 * 如果是，迭代兩個list,比較相應的元素.
 * If any comparison returns {@code false}, this method returns
 * 如果任意比較返回了false,
 * {@code false}.  If either iterator runs out of elements before the
 * 那麼這個方法返回false;如果任意迭代器在另一些前運行出元素範圍，則返回false
 * other it returns {@code false} (as the lists are of unequal length);
 * (由於list存在不等的長度)
 * otherwise it returns {@code true} when the iterations complete.
 * 當迭代器完成，返回true
 *
 * @param o the object to be compared for equality with this list
 * @return {@code true} if the specified object is equal to this list
 */
public boolean equals(Object o) {
    if (o == this)
        return true;
    if (!(o instanceof List))
        return false;

    ListIterator<E> e1 = listIterator();
    ListIterator    e2 = ((List) o).listIterator();
    while (e1.hasNext() && e2.hasNext()) {
        E o1 = e1.next();
        Object o2 = e2.next();
        if (!(o1==null ? o2==null : o1.equals(o2)))
            return false;
    }
    return !(e1.hasNext() || e2.hasNext());
}

```
