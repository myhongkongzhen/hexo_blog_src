title: Collections -- List -- (五) 
date: 2015-12-03 14:17:27
tags: 
- JAVA
- JDK1.7
---
> 簡介：JDK 1.7 Collections 之 List 接口詳解 (二) 
> 這一節主要學習集合框架中的Collection接口、相關子接口、實現類以及成員屬性、方法等具體實現
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)

<!--more-->  

#### List接口分析

> List接口包含方法:

<img src="/images/Collection-List.png"  />

```
boolean contains(Object o); // (o == null ? e == null : o.equals(e)) ***(NullPointerException)if the specified element is null and this list does not permit null elements
Object[] toArray(); //(in proper sequence). In other words, this method must allocate a new array even if this list is backed by an array
boolean addAll(int index, java.util.Collection<? extends E> c); // IndexOutOfBoundsException (index < 0 || index > size())
boolean retainAll( java.util.Collection<?> c); // removes from this list all of its elements that are not contained in the specified collection
boolean equals(Object o); // (e1 == null ? e2 == null : eq.equals(e2))
int hashCode(); // This ensures that list1.equals(list2) implies that list1.hashCode()==list2.hashCode() for any two lists
E get(int index); // IndexOutOfBoundsException (index < 0 || index >= size())
E set(int index, E element); // Replaces the element  替換指定位置的元素用指定的元素
void add(int index, E element); //Inserts the specified element 在指定的位置添加指定的元素.改變元素當前的位置.任何後續的元素在其右邊
E remove(int index); //Returns the element that was removed from the list.
int indexOf(Object o); //the index of the first occurrence ,More formally, returns the lowest index i such that (o==null ? get(i)==null : o.equals(get(i))), or -1 if there is no such index
ListIterator<E> listIterator(int index); // The specified index indicates the first element that would be returned by an initial call to next. An initial call to previous would return the element with the specified index minus one.
List<E> subList(int fromIndex, int toIndex); // low endpoint (inclusive) of the subList,high endpoint (exclusive) of the subList(IndexOutOfBoundsException) (fromIndex < 0 || toIndex > size || fromIndex > toIndex)
```
