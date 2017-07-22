title: Collections -- ArrayList -- (八) 
date: 2015-12-09 09:24:01
categories: 技術
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 ArrayList 類詳解 (五) 
> 這一節主要學習集合框架中的ArrayList類的成員屬性、方法等具體實現
_**存在遺留問題**_
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->  

#### ArrayList List接口具體類
> 底層實現:Object的數組 
```
/**
 * The array buffer into which the elements of the ArrayList are stored.
 * 數組的緩存用於ArrayList存儲元素的空間
 * The capacity of the ArrayList is the length of this array buffer. Any
 * ArrayList的容量是數組緩存的長度.
 * empty ArrayList with elementData == EMPTY_ELEMENTDATA will be expanded to
 * 任何空的ArrayList的 elementData == EMPTY_ELEMENTDATA 在第一個元素添加時
 * DEFAULT_CAPACITY when the first element is added.
 * 擴大 10 容量
 */
private transient Object[] elementData; // 非序列化的
```
> 存在三個內部類:
```
private class Itr implements Iterator<E> ; // 提供集合序列遍歷,移除最後一個元素操作
private class ListItr extends Itr implements ListIterator<E> ; // 提供集合向前向後遍歷,set,add操作
// 截取指定索引範圍的元素list，但是僅僅是多了一個引用副本，指向的還是元list的那段內存空間 
// 子list中修改元素，元list相等索引位置的元素同樣被修改了
private class SubList extends AbstractList<E> implements RandomAccess; 
```

#### 遺留問題
> 1、JAVA數組的定義、初始化、賦值的相關操作
>   【突然發現最基本的數組基本含義都有些搞不明白了，看完所有本類代碼后，查一下數組相關知識
```
/**
 * Shared empty array instance used for empty instances.
 * 用於empty實例的共享的數組實例
 */
private static final Object[] EMPTY_ELEMENTDATA = {};
```
> 2、數據串行化 IO操作，此操作相關在 JAVA IO中詳解
```
private void writeObject(java.io.ObjectOutputStream s){ ... }
private void readObject(java.io.ObjectInputStream s){ ... }
```

ArrayList類UML:
<img src="/images/Collections/Collection-ArrayList.png"  />

實現類源碼解析:
```
/**
 * Default initial capacity.
 * 默認的初始容量
 */
private static final int DEFAULT_CAPACITY = 10;

/**
 * Increases the capacity of this <tt>ArrayList</tt> instance, if
 * ArrayList實例的增加的容量,
 * necessary, to ensure that it can hold at least the number of elements
 * 如果必要,   確保容量可以容納指定的最小容量參數的元素個數
 * specified by the minimum capacity argument.
 *
 * @param   minCapacity   the desired minimum capacity
 *                            期望的  最小容量
 */
public void ensureCapacity(int minCapacity) {
     // 最小的擴容
    int minExpand = (elementData != EMPTY_ELEMENTDATA)
                    // any size if real element table
                    ? 0
                    // larger than default for empty table. It's already supposed to be
                    // at default size.
                    : DEFAULT_CAPACITY; // 10

    if (minCapacity > minExpand) {
        // 確定明確容量
        ensureExplicitCapacity(minCapacity);
    }
}

// 明確內部容量
private void ensureCapacityInternal(int minCapacity) {
    // 判斷共享數據是否是一個空數組
    if (elementData == EMPTY_ELEMENTDATA) {
        // 如果是，設置最小容量，默認 10 ，指定的容量大於10時設為
        // 指定的容量
        minCapacity = Math.max(DEFAULT_CAPACITY, minCapacity);
    }

    ensureExplicitCapacity(minCapacity);
}

private void ensureExplicitCapacity(int minCapacity) {
    modCount++;

    // overflow-conscious code
    if (minCapacity - elementData.length > 0)
        grow(minCapacity);
}

/**
 * The maximum size of array to allocate.
 * 分配的數組最大的值
 * Some VMs reserve some header words in an array.
 * 一些vm在數組中保留了一些頭信息
 * Attempts to allocate larger arrays may result in
 * 嘗試分配更大的數組結果會出現 OutOfMemoryError
 * OutOfMemoryError: Requested array size exceeds VM limit
 *                   請求數組的元素超過了vm的極限
 */
private static final int MAX_ARRAY_SIZE = Integer.MAX_VALUE - 8;

/**
 * Increases the capacity to ensure that it can hold at least the
 * 增加容量確保容量能夠提供由最小容量參數指定的元素個數.
 * number of elements specified by the minimum capacity argument.
 *
 * @param minCapacity the desired minimum capacity
 *                        期望的
 */
private void grow(int minCaGpacity) {
    // overflow-conscious code
    //====================================== 如果共享數組為空數組
    int oldCapacity = elementData.length; // 0
    int newCapacity = oldCapacity + (oldCapacity >> 1); // 0
    if (newCapacity - minCapacity < 0) // 一定為負數
        newCapacity = minCapacity; // 新容量為 指定最小容量
    if (newCapacity - MAX_ARRAY_SIZE > 0) // 新容量與最大容量比較
        newCapacity = hugeCapacity(minCapacity); // 設為最大容量:Integer.MAX_VALUE - 8;
    // minCapacity is usually close to size, so this is a win:
    // 數組拷貝
    elementData = Arrays.copyOf(elementData, newCapacity);
}

private static int hugeCapacity(int minCapacity) {
    if (minCapacity < 0) // overflow
        throw new OutOfMemoryError();
    return (minCapacity > MAX_ARRAY_SIZE) ?
           Integer.MAX_VALUE :
           MAX_ARRAY_SIZE;
}

/**
 * Returns <tt>true</tt> if this list contains the specified element.
 * More formally, returns <tt>true</tt> if and only if this list contains
 * at least one element <tt>e</tt> such that
 * <tt>(o==null&nbsp;?&nbsp;e==null&nbsp;:&nbsp;o.equals(e))</tt>.
 *
 * @param o element whose presence in this list is to be tested
 *                        存在   
 * @return <tt>true</tt> if this list contains the specified element
 */
public boolean contains(Object o) {
    return indexOf(o) >= 0;
}

/**
 * Returns the index of the first occurrence of the specified element
 * 返回list中指定元素的首次范閒的索引
 * in this list, or -1 if this list does not contain the element.
 *               或者不包含元素時返回-1
 * More formally, returns the lowest index <tt>i</tt> such that
 * 更正式的講，    返回 ( o == null ? get(i) == null : o.equals( get(i) ) )
 * <tt>(o==null&nbsp;?&nbsp;get(i)==null&nbsp;:&nbsp;o.equals(get(i)))</tt>,
 * 最低的索引
 * or -1 if there is no such index.
 * 如果沒有這樣的索引，返回-1
 */
public int indexOf(Object o) {
    if (o == null) {
        for (int i = 0; i < size; i++)
            if (elementData[i]==null)
                return i;
    } else {
        for (int i = 0; i < size; i++)
            if (o.equals(elementData[i]))
                return i;
    }
    return -1;
}
	
/**
 * Returns the index of the last occurrence of the specified element
 * 返回list中指定元素的最後發現的索引
 * in this list, or -1 if this list does not contain the element.
 * More formally, returns the highest index <tt>i</tt> such that
 * <tt>(o==null&nbsp;?&nbsp;get(i)==null&nbsp;:&nbsp;o.equals(get(i)))</tt>,
 * or -1 if there is no such index.
 * 不存在這樣的索引返回-1
 */
public int lastIndexOf(Object o) {
    if (o == null) {
        for (int i = size-1; i >= 0; i--)
            if (elementData[i]==null)
                return i;
    } else {
        for (int i = size-1; i >= 0; i--)
            if (o.equals(elementData[i]))
                return i;
    }
    return -1;
}

/**
 * Returns an array containing all of the elements in this list
 * 返回一個數組包含了所有list中的正確序列的元素
 * in proper sequence (from first to last element).
 *
 * <p>The returned array will be "safe" in that no references to it are
 * 返回的數組是安全的，因為沒有引用維護這個list
 * maintained by this list.  (In other words, this method must allocate
 *                           (換句話說,這個方法必須分配一個新的數組)
 * a new array).  The caller is thus free to modify the returned array.
 *                調用者因而自由的改變返回的數組
 *
 * <p>This method acts as bridge between array-based and collection-based
 * 這個方法的行為作為數組和集合基礎的橋樑
 * APIs.
 *
 * @return an array containing all of the elements in this list in
 *         proper sequence
 *         正確
 */
public Object[] toArray() {
    return Arrays.copyOf(elementData, size);
}

/**
 * Returns an array containing all of the elements in this list in proper
 * sequence (from first to last element); the runtime type of the returned
 * array is that of the specified array.  If the list fits in the
 * 返回數組的運行時類型是這個指定數組的類型.
 * specified array, it is returned therein.  Otherwise, a new array is
 *                                 在其中     否則，
 * allocated with the runtime type of the specified array and the size of
 * 一個新的數組又指定數組的運行時類型與list的大小分配
 * this list.
 *
 * <p>If the list fits in the specified array with room to spare
 * (i.e., the array has more elements than the list), the element in
 * the array immediately following the end of the collection is set to
 *           立即
 * <tt>null</tt>.  (This is useful in determining the length of the
 *                                    確定
 * list <i>only</i> if the caller knows that the list does not contain
 * any null elements.)
 *
 * @param a the array into which the elements of the list are to
 *          be stored, if it is big enough; otherwise, a new array of the
 *          same runtime type is allocated for this purpose.
 * @return an array containing the elements of the list
 * @throws ArrayStoreException if the runtime type of the specified array
 *         is not a supertype of the runtime type of every element in
 *         this list
 * @throws NullPointerException if the specified array is null
 */
@SuppressWarnings("unchecked")
public <T> T[] toArray(T[] a) {
    if (a.length < size)
        // Make a new array of a's runtime type, but my contents:
        return (T[]) Arrays.copyOf(elementData, size, a.getClass());
    System.arraycopy(elementData, 0, a, 0, size);
    if (a.length > size)
        a[size] = null;
    return a;
}	

/**
 * Returns the element at the specified position in this list.
 *
 * @param  index index of the element to return
 * @return the element at the specified position in this list
 * @throws IndexOutOfBoundsException {@inheritDoc}
 */
public E get(int index) {
    // 範圍檢測，不會檢測 索引為負的情況,只會檢測索引是否超過size值
    rangeCheck(index);

    return elementData(index);
}	

/**
 * Returns the element at the specified position in this list.
 *
 * @param  index index of the element to return
 * @return the element at the specified position in this list
 * @throws IndexOutOfBoundsException {@inheritDoc}
 */
public E get(int index) {
    // 範圍檢測，不會檢測 索引為負的情況,只會檢測索引是否超過size值
    rangeCheck(index);

    return elementData(index);
}	

/**
 * Replaces the element at the specified position in this list with
 * the specified element.
 *
 * @param index index of the element to replace
 * @param element element to be stored at the specified position
 * @return the element previously at the specified position
 *         返回設定值之前的舊值
 * @throws IndexOutOfBoundsException {@inheritDoc}
 */
public E set(int index, E element) {
    rangeCheck(index);

    E oldValue = elementData(index);
    elementData[index] = element;
    return oldValue;
}

/**
 * Inserts the specified element at the specified position in this
 * 在指定位置添加元素
 * list. Shifts the element currently at that position (if any) and
 * any subsequent elements to the right (adds one to their indices).
 *     隨後的元素向右移動(增加索引)
 *
 * @param index index at which the specified element is to be inserted
 * @param element element to be inserted
 * @throws IndexOutOfBoundsException {@inheritDoc}
 */
public void add(int index, E element) {
    rangeCheckForAdd(index);

    ensureCapacityInternal(size + 1);  // Increments modCount!!
    // 指定位置后的元素拷貝
    System.arraycopy(elementData, index, elementData, index + 1,
                     size - index);
    elementData[index] = element;
    size++;
}

/**
 * Removes the element at the specified position in this list.
 * 移除list中指定位置的元素
 * Shifts any subsequent elements to the left (subtracts one from their
 * 隨後的元素左移(索引減一)
 * indices).
 *
 * @param index the index of the element to be removed
 *              返回移除索引位置時的舊數據   
 * @return the element that was removed from the list
 * @throws IndexOutOfBoundsException {@inheritDoc}
 */
public E remove(int index) {
    rangeCheck(index);

    modCount++;
    E oldValue = elementData(index);

    int numMoved = size - index - 1;
    if (numMoved > 0) // 指定位置元素前移
        System.arraycopy(elementData, index+1, elementData, index,
                         numMoved);
    elementData[--size] = null; // clear to let GC do its work

    return oldValue;
}

/**
 * Removes the first occurrence of the specified element from this list,
 * 移除list中指定的首次發現的元素
 * if it is present.  If the list does not contain the element, it is
 * 如果它存在的話       如果不包含這樣的元素，不發生改變
 * unchanged.  More formally, removes the element with the lowest index
 *             更正式的說，移除符合( o == null ? get(i) == null : o.equalse(get(i)) )
 * <tt>i</tt> such that
 * <tt>(o==null&nbsp;?&nbsp;get(i)==null&nbsp;:&nbsp;o.equals(get(i)))</tt>
 * 規則的最低索引的元素
 * (if such an element exists).  Returns <tt>true</tt> if this list
 * (如果這樣的元素存在)
 * contained the specified element (or equivalently, if this list
 * 如果list中包含指定元素返回true
 * changed as a result of the call).
 * (或者等效的,這個list因為這個方法的調用改變了結果)
 *
 * @param o element to be removed from this list, if present
 * @return <tt>true</tt> if this list contained the specified element
 */
public boolean remove(Object o) {
    if (o == null) {
        for (int index = 0; index < size; index++)
            if (elementData[index] == null) {
                fastRemove(index);
                return true;
            }
    } else {
        for (int index = 0; index < size; index++)
            if (o.equals(elementData[index])) {
                fastRemove(index);
                return true;
            }
    }
    return false;
}

/*
 * Private remove method that skips bounds checking and does not
 * 不做校驗的是快速刪除方法，不返回刪除的元素
 * return the value removed.
 */
private void fastRemove(int index) {
    modCount++;
    int numMoved = size - index - 1;
    if (numMoved > 0)
        System.arraycopy(elementData, index+1, elementData, index,
                         numMoved);
    elementData[--size] = null; // clear to let GC do its work
}

/**
 * Appends all of the elements in the specified collection to the end of
 * 在list的末尾添加指定集合中的所有元素
 * this list, in the order that they are returned by the
 * 按照集合迭代順序返回的順序
 * specified collection's Iterator.  The behavior of this operation is
 * undefined if the specified collection is modified while the operation
 * 這個操作的行為是未定義的,如果當操作過程中指定的集合改變了
 * is in progress.  (This implies that the behavior of this call is
 * undefined if the specified collection is this list, and this
 * (這就暗示了調用的行為當這個指定的集合是這個list，並且這個list是不為空時，是未定義的)
 * list is nonempty.)
 *
 * @param c collection containing elements to be added to this list
 * @return <tt>true</tt> if this list changed as a result of the call
 * @throws NullPointerException if the specified collection is null
 */
public boolean addAll(Collection<? extends E> c) {
    Object[] a = c.toArray();
    int numNew = a.length;
    ensureCapacityInternal(size + numNew);  // Increments modCount

    /**
     *
     * Integer[] des = new Integer[ 4 ];
     * Integer[] src = { 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 };
     *
     * // 把 src 數組的元素從 第 2 號位置開始拷貝,拷貝3個元素
     * // 到 des 數組中，在des中的 1 號位置開始放置這些數據
     * System.arraycopy( src, 2, des, 1, 3 );
     *
     */
     
    System.arraycopy(a, 0, elementData, size, numNew);
    size += numNew;
    return numNew != 0;
}

/**
 * Removes from this list all of the elements whose index is between
 * 從list中移除所有的索引在[fromIndex,toIndex)之間元素
 * {@code fromIndex}, inclusive, and {@code toIndex}, exclusive.
 * Shifts any succeeding elements to the left (reduces their index).
 * This call shortens the list by {@code (toIndex - fromIndex)} elements.
 * (If {@code toIndex==fromIndex}, this operation has no effect.)
 * (如果fromIndex == toIndex，這個操作沒有任何影響)
 *
 * @throws IndexOutOfBoundsException if {@code fromIndex} or
 *         {@code toIndex} is out of range
 *         ({@code fromIndex < 0 ||
 *          fromIndex >= size() ||
 *          toIndex > size() ||
 *          toIndex < fromIndex})
 */
protected void removeRange(int fromIndex, int toIndex) {
    modCount++;
    int numMoved = size - toIndex;
    System.arraycopy(elementData, toIndex, elementData, fromIndex,
                     numMoved);

    // clear to let GC do its work
    int newSize = size - (toIndex-fromIndex);
    for (int i = newSize; i < size; i++) {
        elementData[i] = null; // clear to let GC do its work
    }
    size = newSize;
}	

/**
 * Removes from this list all of its elements that are contained in the
 * 從list中移除所有的包含于指定集合中的元素
 * specified collection.
 *
 * @param c collection containing elements to be removed from this list
 * @return {@code true} if this list changed as a result of the call
 * @throws ClassCastException if the class of an element of this list
 *         is incompatible with the specified collection
 * (<a href="Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if this list contains a null element and the
 *         specified collection does not permit null elements
 * (<a href="Collection.html#optional-restrictions">optional</a>),
 *         or if the specified collection is null
 * @see Collection#contains(Object)
 */
public boolean removeAll(Collection<?> c) {
    return batchRemove(c, false);
}

/**
 * Removes from this list all of its elements that are contained in the
 * 從list中移除所有的包含于指定集合中的元素
 * specified collection.
 *
 * @param c collection containing elements to be removed from this list
 * @return {@code true} if this list changed as a result of the call
 * @throws ClassCastException if the class of an element of this list
 *         is incompatible with the specified collection
 * (<a href="Collection.html#optional-restrictions">optional</a>)
 * @throws NullPointerException if this list contains a null element and the
 *         specified collection does not permit null elements
 * (<a href="Collection.html#optional-restrictions">optional</a>),
 *         or if the specified collection is null
 * @see Collection#contains(Object)
 */
public boolean removeAll(Collection<?> c) {
    return batchRemove(c, false);
}

private boolean batchRemove(Collection<?> c, boolean complement) {
    final Object[] elementData = this.elementData;
    int r = 0, w = 0;
    boolean modified = false;
    try {
        for (; r < size; r++)
            // 判斷當前集合的元素是否包含在指定集合中
            // 判斷當前集合的元素是否包含在指定集合中
            // 如果不包含在其中 complement = false
            // 將此元素重新索引到數組中==即保留非指定的元素集，去除了包含的元素
            // 如果包含在其中 complement = true
            // 將此元素重新索引到數組中==即保留指定的元素集，去除了非包含的元素
            if (c.contains(elementData[r]) == complement)
                elementData[w++] = elementData[r];
    } finally {
        // Preserve behavioral compatibility with AbstractCollection,
        // 保留AbstractCollection的兼容性行為
        // even if c.contains() throws.
        if (r != size) {
            // 拷貝剩餘的未同指定集合比較的元素到新索引位置
            System.arraycopy(elementData, r,
                             elementData, w,
                             size - r);
            w += size - r;
        }
        if (w != size) {
            // clear to let GC do its work
            for (int i = w; i < size; i++)
                elementData[i] = null;
            modCount += size - w;
            size = w;
            modified = true;
        }
    }
    return modified;
}	

/**
 * Returns a list iterator over the elements in this list (in proper
 * 返回一個list中的遍歷元素的list迭代器
 * sequence), starting at the specified position in the list.
 *            開始於指定的位置
 * The specified index indicates the first element that would be
 * 指定的索引說明第一個元素由初始ListIterator.next調用返回
 * returned by an initial call to {@link ListIterator#next next}.
 * An initial call to {@link ListIterator#previous previous} would
 * 初始調用ListIterator.previous調用用指定的索引減一的元素
 * return the element with the specified index minus one.
 *
 * <p>The returned list iterator is <a href="#fail-fast"><i>fail-fast</i></a>.
 *
 * @throws IndexOutOfBoundsException {@inheritDoc}
 */
public ListIterator<E> listIterator(int index) {
    if (index < 0 || index > size)
        // 索引越界異常
        throw new IndexOutOfBoundsException("Index: "+index);
    // 新建一個指定索引開始的迭代器
    return new ListItr(index);
}

/**
 * Returns a list iterator over the elements in this list (in proper
 * sequence).
 *
 * <p>The returned list iterator is <a href="#fail-fast"><i>fail-fast</i></a>.
 *
 * @see #listIterator(int)
 */
public ListIterator<E> listIterator() {
    return new ListItr(0);
}

/**
 * Returns an iterator over the elements in this list in proper sequence.
 *
 * <p>The returned iterator is <a href="#fail-fast"><i>fail-fast</i></a>.
 *
 * @return an iterator over the elements in this list in proper sequence
 */
public Iterator<E> iterator() {
    return new Itr();
}

/**
 * Returns a view of the portion of this list between the specified
 * 返回在[fromIndex,toIndex)之間的list的一部分視圖
 * {@code fromIndex}, inclusive, and {@code toIndex}, exclusive.  (If
 * {@code fromIndex} and {@code toIndex} are equal, the returned list is
 * (如果 fromIndex == toIndex ，返回list是empty的)
 * empty.)  The returned list is backed by this list, so non-structural
 *          這個返回的list基於當前的list,
 * changes in the returned list are reflected in this list, and vice-versa.
 * 因此沒有結構改變在這個list中返回的list是課反射的,反之亦然
 * The returned list supports all of the optional list operations.
 * 這個返回的list支持所有的list的可選操作
 *
 * <p>This method eliminates the need for explicit range operations (of
 * 這個方法消除了明確範圍操作的需要
 * the sort that commonly exist for arrays).  Any operation that expects
 * (排序一般存在的數組)
 * a list can be used as a range operation by passing a subList view
 * 任何期望一個list用於範圍操作的操作通過一個子list視圖帶起整個list
 * instead of a whole list.  For example, the following idiom
 *                           例如，從list中移除一個範圍的元素
 * removes a range of elements from a list:
 * 之後通常的做法:
 * <pre>
 *      list.subList(from, to).clear();
 * </pre>
 * Similar idioms may be constructed for {@link #indexOf(Object)} and
 * 類似的做法能構造indexOf,lastIndexOf方法，
 * {@link #lastIndexOf(Object)}, and all of the algorithms in the
 * 並且所有的算法在Collections類中的都可以應用於子list.
 * {@link Collections} class can be applied to a subList.
 *
 * <p>The semantics of the list returned by this method become undefined if
 * 有這個方法返回的list的語意成為未定義的，
 * the backing list (i.e., this list) is <i>structurally modified</i> in
 * 如果基於list的結構化的改變通過任何方式
 * any way other than via the returned list.  (Structural modifications are
 *                    通過返回的list
 * those that change the size of this list, or otherwise perturb it in such
 * (結構化改變指的是那些改變list大小，或者除此之外的麻煩的，在迭代過程中正確結果產出的方法)
 * a fashion that iterations in progress may yield incorrect results.)
 *
 * @throws IndexOutOfBoundsException {@inheritDoc}
 * @throws IllegalArgumentException {@inheritDoc}
 */
public List<E> subList(int fromIndex, int toIndex) {
    subListRangeCheck(fromIndex, toIndex, size);
    return new SubList(this, 0, fromIndex, toIndex);
}	
```














