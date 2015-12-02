title: Collections -- Collection 詳解 -- (四) 
date: 2015-12-01 14:46:35
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 Collection 接口詳解 (一) 
> 這一節主要學習集合框架中的Collection接口、相關子接口、實現類以及成員屬性、方法等具體實現

<!--more-->  

#### Collection接口分析：
> Collection接口繼承了Iterable接口，Iterable接口存在一個Iterator對象.

```
Iterator接口與Enumeration類似,都用於遍歷.
Iterator接口增加了remove方法,可以修改集合內部元素.
Iterator接口中的方法命名具有更好的語義定義.
```

> Collection接口包含方法:

<img src="/images/Collection-functions.png"  />

```
int size(); //集合元素大小,最大返回Integer.MAX_VALUE
boolean isEmpty(); //如果集合沒有包含任何元素，則返回true
boolean contains( Object o ); //當且僅當集合包含至少一個元素符合(o == null ? e == null : o.equals(s))規則時返回true
Iterator<E> iterator(); //返回一個集合的迭代器,通常不保證元素迭代順序，除非實現類提供了排序保證
Object[] toArray(); //返回包含集合所有元素的數組,如果集合的迭代有保證順序，那麼這個方法也要保證元素的順序
<T> T[] toArray( T[] a ); //返回指定類型的包含集合元素的數組,如果指定數組為null則會拋出異常
boolean add( E e ); //添加指定元素，集合添加元素改變返回ｔｒｕｅ，如果已存在或者重複情況下，返回ｆａｌｓｅ，或者拋出相應異常.
boolean remove( Object o ); //移除指定元素從集合中,如果集合因此方法調用結果改變了則返回true
boolean containsAll( Collection<?> c ); //判定當前集合是否包含指定集合的所有元素,包含了則返回true
boolean addAll( Collection<? extends E> c ); //添加指定集合的所有元素到這個集合中
boolean removeAll( Collection<?> c ); //將集合中的所有與指定集合匹配的元素移出
boolean retainAll( Collection<?> c ); //將當前集合中所有不含在指定集合中的元素移出
void clear(); //清空集合，empty
// Comparison and hashing
boolean equals( Object o );
int hashCode();
```
