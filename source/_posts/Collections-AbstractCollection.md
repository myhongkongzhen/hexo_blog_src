title: Collectionsr -- AbstractCollection -- (六) 
date: 2015-12-07 12:08:05
categories: 技術
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 AbstractCollection 頂層抽象類詳解 (三) 
> 這一節主要學習集合框架中的AbstractCollection頂層抽象類的成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->  

#### AbstractCollection Collection接口頂層抽象類
> 定義了最小化的一般通用的方法實現

AbstractCollection抽象類包含方法:
<img src="/images/Collections/Collection-AbstractCollection.png"  />

實現類源碼解析:
```
/**
 * {@inheritDoc}
 * <p>This implementation iterates over the elements in the collection,
 * 這個實現迭代集合中的所有元素
 * checking each element in turn for equality with the specified element.
 * 依次檢查每一個元素與指定元素相等性
 *
 * @throws ClassCastException   {@inheritDoc}
 * @throws NullPointerException {@inheritDoc}
 */
public boolean contains( Object o )
{
    /* 在此抽象類中,iterator()方法為抽象方法,因此此方法要更具具體實現類中的迭代實現算法返回迭代器 */
    Iterator<E> it = iterator(); 
    if ( o == null ) //判斷指定元素是否為null
    {
        /* 為空,依次判斷本集合中的元素是否為null,存在，則返回true */
        /* 說明此方法，可以包含null元素,且存在null元素時，判定為包含*/
        while ( it.hasNext() ) if ( it.next() == null ) return true;
    }
    else
    {
        /* 如果指定元素不為null,依次判斷集合中的元素與指定元素是否相等 */
        while ( it.hasNext() ) if ( o.equals( it.next() ) ) return true;
    }
    return false;
}
	
/**
 * {@inheritDoc}
 * <p>This implementation returns an array containing all the elements
 * 這個實現返回一個數組，包含了所有的元素.
 * returned by this collection's iterator, in the same order, stored in
 * 由這個集合的迭代器,按照相同的順序,
 * consecutive elements of the array, starting with index {@code 0}.
 * 從索引0開始的連貫的數組中的元素.
 * The length of the returned array is equal to the number of elements
 * 返回的數組的長度等於由迭代器返回的元素的個數,
 * returned by the iterator, even if the size of this collection changes
 *                           甚至這個集合的大小在迭代過程中改變了
 * during iteration, as might happen if the collection permits
 * 如果集合允許在迭代中並發的改變是可發生的.
 * concurrent modification during iteration.  The {@code size} method is
 * called only as an optimization hint; the correct result is returned
 * size方法僅僅作為一個優化的提示被調用;正確的結果可返回
 * even if the iterator returns a different number of elements.
 * 儘管迭代者返回一個不同元素個數
 * <p>This method is equivalent to:
 *                   等價的
 * <pre> {@code
 * List<E> list = new ArrayList<E>(size());
 * for (E e : this)
 *     list.add(e);
 * return list.toArray();
 * }</pre>
 */
public Object[] toArray()
{
    // Estimate size of array; be prepared to see more or fewer elements
    // 預估數組的大小
    Object[]    r  = new Object[ size() ];
    Iterator<E> it = iterator();
    for ( int i = 0 ; i < r.length ; i++ )
    {
        if ( !it.hasNext() ) // fewer elements than expected
            //當集合中不存在下一個元素時，返回一個新的拷貝的數組.
            return Arrays.copyOf( r, i );
        r[ i ] = it.next(); //將集合迭代元素依次放入臨時Obj[]中
    }
    /* 如果size為0，判斷集合是否有下一個元素 */
    /* 如果不存在，返回一個空的數組 */
    /* 如果存在，進行finishToArray()操作 */
    return it.hasNext() ? finishToArray( r, it ) : r;
}
	
/**
 * Copies the specified array, truncating or padding with nulls (if necessary)
 * 拷貝指定的數組，用null截斷或者填充(如果必須的)
 * so the copy has the specified length.  For all indices that are
 * 因此這個拷貝有一個指定的長度.
 * valid in both the original array and the copy, the two arrays will
 * 對於所有的在元array與拷貝array中有效的指數,
 * contain identical values.  For any indices that are valid in the
 * 兩個數組將包含相同的值.
 * copy but not the original, the copy will contain <tt>null</tt>.
 * 對於一些在copy中但不在元數組中的指標,拷貝將包含null.
 * Such indices will exist if and only if the specified length
 * 一些指標當且僅當在指定的長度時存在比起元數組更長
 * is greater than that of the original array.
 * The resulting array is of exactly the same class as the original array.
 * 返回的數組恰好與元數組相同的類.
 *
 * @param original the array to be copied
 *                 要拷貝的原數組
 * @param newLength the length of the copy to be returned
 *                  拷貝數組要返回的長度
 * @return a copy of the original array, truncated or padded with nulls
 *         返回一個原數組的拷貝,
 *     to obtain the specified length
 *     用null截斷或者填充來獲得一個指定的長度.
 * @throws NegativeArraySizeException if <tt>newLength</tt> is negative
 *                                    如果長度為負數
 * @throws NullPointerException if <tt>original</tt> is null
 *                              如果元數組為null
 * @since 1.6
 */
public static <T> T[] copyOf(T[] original, int newLength) {
    return (T[]) copyOf(original, newLength, original.getClass());
}

/**
 * Copies the specified array, truncating or padding with nulls (if necessary)
 * so the copy has the specified length.  For all indices that are
 * valid in both the original array and the copy, the two arrays will
 * contain identical values.  For any indices that are valid in the
 * copy but not the original, the copy will contain <tt>null</tt>.
 * Such indices will exist if and only if the specified length
 * is greater than that of the original array.
 * The resulting array is of the class <tt>newType</tt>.
 *
 * @param original the array to be copied
 * @param newLength the length of the copy to be returned
 * @param newType the class of the copy to be returned
 * @return a copy of the original array, truncated or padded with nulls
 *     to obtain the specified length
 * @throws NegativeArraySizeException if <tt>newLength</tt> is negative
 * @throws NullPointerException if <tt>original</tt> is null
 * @throws ArrayStoreException if an element copied from
 *     <tt>original</tt> is not of a runtime type that can be stored in
 *     an array of class <tt>newType</tt>
 * @since 1.6
 */
public static <T,U> T[] copyOf(U[] original, int newLength, Class<? extends T[]> newType) {
    /* 類型判斷 */
    T[] copy = ((Object)newType == (Object)Object[].class)
               ? (T[]) new Object[newLength]
               : (T[]) Array.newInstance( newType.getComponentType(), newLength);
    /* native 本地數組拷貝算法 */
    System.arraycopy(original, 0, copy, 0,
                     Math.min(original.length, newLength));
    return copy;
}	
	
/**
 * Reallocates the array being used within toArray when the iterator
 * 重新分配數組用於在toArray內，迭代器返回比期望更多的元素時，
 * returned more elements than expected, and finishes filling it from
 *                                       并完成從迭代器填充.
 * the iterator.
 *
 * @param r  the array, replete with previously stored elements
 *           一個數組，充滿了先前的元素的
 * @param it the in-progress iterator over this collection
 *           迭代這個集合的迭代器
 *
 * @return array containing the elements in the given array, plus any
 *         返回數組包含了在特定數組中的元素,
 * further elements returned by the iterator, trimmed to size
 * 由迭代器返回添加任意將來的元素,消減規模
 */
private static <T> T[] finishToArray( T[] r, Iterator<?> it )
{
    int i = r.length;
    while ( it.hasNext() )
    {
        int cap = r.length;
        if ( i == cap )
        {
            int newCap = cap + ( cap >> 1 ) + 1;
            // overflow-conscious code
            // 合理的溢出代碼
            if ( newCap - MAX_ARRAY_SIZE > 0 ) newCap = hugeCapacity( cap + 1 );
            r = Arrays.copyOf( r, newCap );
        }
        r[ i++ ] = ( T ) it.next();
    }
    // trim if overallocated
    return ( i == r.length ) ? r : Arrays.copyOf( r, i );
}

/*最小容量校驗，負值判斷,0x7fffffff最大整數判斷*/
private static int hugeCapacity( int minCapacity )
{
    if ( minCapacity < 0 ) // overflow
        throw new OutOfMemoryError( "Required array size too large" );
    return ( minCapacity > MAX_ARRAY_SIZE ) ? Integer.MAX_VALUE : MAX_ARRAY_SIZE;
}

/**
 * {@inheritDoc}
 * <p>This implementation returns an array containing all the elements
 * returned by this collection's iterator in the same order, stored in
 * consecutive elements of the array, starting with index {@code 0}.
 * 連貫的數
 * If the number of elements returned by the iterator is too large to
 * 如果由迭代器返回的元素的個數太大了
 * fit into the specified array, then the elements are returned in a
 * 而不適合指定的數組,
 * newly allocated array with length equal to the number of elements
 * 那麼在一個重新分配的由迭代者返回元素的個數相等的長度的數組中返回元素
 * returned by the iterator, even if the size of this collection
 * changes during iteration, as might happen if the collection permits
 * 儘管集合在迭代中改變了大小,
 * concurrent modification during iteration.  The {@code size} method is
 * 如果集合允許在迭代中並發修改的發生.
 * called only as an optimization hint; the correct result is returned
 *                   優化的提示
 * even if the iterator returns a different number of elements.
 * <p>This method is equivalent to:
 * <pre> {@code
 * List<E> list = new ArrayList<E>(size());
 * for (E e : this)
 *     list.add(e);
 * return list.toArray(a);
 * }</pre>
 *
 * @throws ArrayStoreException  {@inheritDoc}
 * @throws NullPointerException {@inheritDoc}
 */
public <T> T[] toArray( T[] a )
{
    // Estimate size of array; be prepared to see more or fewer elements
    int         size = size();
                                              //創建一個新的數組，由指定類型，底層由native方法newArray實現數組的創建
    T[]         r    = a.length >= size ? a : ( T[] ) java.lang.reflect.Array.newInstance( a.getClass().getComponentType(), size );
    Iterator<E> it   = iterator();

    for ( int i = 0 ; i < r.length ; i++ )
    {
        if ( !it.hasNext() )
        { // fewer elements than expected
            if ( a == r )
            {
                r[ i ] = null; // null-terminate
            }
            else if ( a.length < i )
            {
                return Arrays.copyOf( r, i );
            }
            else
            {
                System.arraycopy( r, 0, a, 0, i );
                if ( a.length > i )
                {
                    a[ i ] = null;
                }
            }
            return a;
        }
        r[ i ] = ( T ) it.next();
    }
    // more elements than expected
    return it.hasNext() ? finishToArray( r, it ) : r;
}
	
/**
 * The maximum size of array to allocate.
 * Some VMs reserve some header words in an array.
 * 一些vm在數組里提供某些header信息
 * Attempts to allocate larger arrays may result in
 * 嘗試分配更大的數組會拋出OutOfMemoryError.
 * OutOfMemoryError: Requested array size exceeds VM limit
 *                   請求的數組大小超過vm的限制
 */
private static final int MAX_ARRAY_SIZE = Integer.MAX_VALUE - 8;	//因此，某些vm的數組頭信息大小為 8 ？

/**
 * {@inheritDoc}
 * <p>This implementation always throws an
 * 這個實現總是拋出一個UnsupportedOperationException
 * <tt>UnsupportedOperationException</tt>.
 *
 * @throws UnsupportedOperationException {@inheritDoc}
 * @throws ClassCastException            {@inheritDoc}
 * @throws NullPointerException          {@inheritDoc}
 * @throws IllegalArgumentException      {@inheritDoc}
 * @throws IllegalStateException         {@inheritDoc}
 */
public boolean add( E e )
{
    throw new UnsupportedOperationException(); // 留下個以為，為何總是拋出異常，是不是在具體的實現類里重寫了此方法 ？ 
}	

/**
 * Returns a string representation of this collection.  The string
 * 返回這個集合的字符串表示.
 * representation consists of a list of the collection's elements in the
 * 這個字符串表示包含集合元素的列表
 * order they are returned by its iterator, enclosed in square brackets
 * 由他的迭代器返回的順序的列表,在封閉的括號內
 * (<tt>"[]"</tt>).  Adjacent elements are separated by the characters
 *                   合適的元素由逗號和空格分離
 * <tt>", "</tt> (comma and space).  Elements are converted to strings as
 *                                   由String.valueOf()方法轉換為字符串.
 * by {@link String#valueOf(Object)}.
 *
 * @return a string representation of this collection
 */
public String toString()
{
    Iterator<E> it = iterator();
    if ( !it.hasNext() ) return "[]";

    StringBuilder sb = new StringBuilder();
    sb.append( '[' );
    for ( ; ; )
    {
        E e = it.next();
        sb.append( e == this ? "(this Collection)" : e );
        if ( !it.hasNext() ) return sb.append( ']' ).toString();
        sb.append( ',' ).append( ' ' );
    }
}	

/* Note that this implementation will throw an UnsupportedOperationException 
   if the iterator returned by the iterator method does not implement the remove method 
   and this collection contains one or more elements in common with the specified collection */
/* 如果是實現類沒有實現remove方法,以下方法在調用時將會拋出異常 UnsupportedOperationException */
public boolean remove( Object o ){ .. }
public boolean addAll( java.util.Collection<? extends E> c ){ .. }
public boolean retainAll( java.util.Collection<?> c ){ .. }
public boolean removeAll( java.util.Collection<?> c ){ .. }
public void clear(){ .. }
```
