title: Collections Framework Overview -- (一) 
date: 2015-11-25 11:40:13
tags:
 - JAVA
 - JDK1.7
 - TRANSLATING
---
> 簡介：Collections Framework. JDK1.7 集合框架系統學習 (一) 概覽
> 集合框架API DOC簡介英文翻譯練習。
> ※ 注：此翻譯僅僅為個人學習JDK文檔及補習英文所做，如果您希望看到更加準確的翻譯，請自行搜尋中文文檔
>       因英文水平不足為您帶來的不便請諒解.

<!--more-->  

# JDK 1.7 API Collections Framework
* The collections framework is a unified architecture for representing and manipulating***[mə'nɪpjulet]*** collections
 - 集合框架是一個統一的描述和操作集合的架構,
* enabling them to be manipulated independently of the details of their representation.
 - 使得他們能夠被獨立操作他們所描述的細節.
* It reduces programming effort while increasing performance.
 - 他降低編程精力當越來越多的執行性能.
* It enables interoperability among unrelated APIs, 
 - 他使得無關的API相互操作成為可能,
* reduces effort in designing and learning new APIs, 
 - 降低設計和學習新API的精力,
* and fosters software reuse. 
 - 并促進軟體的複用.
* The framework is based on more than a dozen collection interfaces.
 - 這個框架以多餘十二個集合的接口為基礎. 
* It includes implementations of these interfaces and algorithms to manipulate them.
 - 他包含了一些接口的實現和算法來操作他們. 
# Collections Framework Overview
## Introduction
* The Java platform includes a collections framework. 
  - JAVA平台包含一個集合框架.
* A collection is an object that represents a group of objects (such as the classic Vector class). 
  - 集合是一個描述一組實例（例如類型Vector類）的一個實體.
* A collections framework is a unified architecture for representing and manipulating collections, 
  - 集合框架是一個描述和操作集合的統一架構,
* enabling collections to be manipulated independently of implementation details. 
  - 使得集合被不依賴實現細節的操作成為可能.
* The primary advantages of a collections framework are that it:
  集合框架最主要的特點如下:
  - **Reduces programming effort** by providing data structures and algorithms so you don't have to write them yourself.
    - **降低程式開發精力** 以數據結構和算法為條件以至於你無需自己編寫他們.  
  - **Increases performance** by providing high-performance implementations of data structures and algorithms. 
    - **提高性能** 以高性能的數據結構和算法實現為條件.
      Because the various implementations of each interface are interchangeable, 
      因為每一個接口多樣的實現是可交換的, 
      programs can be tuned by switching implementations.
      程序能夠備調整由可轉換的實現.       
  - **Provides interoperability between unrelated APIs** by establishing***[ɪˈstæblɪʃ]*** a common language to pass collections back and forth.
    - **提供無關API之間的相互操作** 建立一個通用的可環繞操作集合的語言  
  - **Reduces the effort required to learn APIs** by requiring you to learn multiple ad hoc collection APIs.
    - **降低必要學習API的精力** 必須使得你不得不學習多種特定的集合API  
  - **Reduces the effort required to design and implement APIs** by not requiring you to produce ad hoc collections APIs.
    - **降低必須設計和實現API的精力** 是你不必要產出特定集合API  
  - **Fosters software reuse** by providing a standard interface for collections and algorithms with which to manipulate them.
    - **促進軟體的複用** 為集合提供一個基本的接口和操作他們的算法
* The collections framework consists of:
  集合框架包含:
  - **Collection interfaces.** Represent different types of collections, such as sets, lists, and maps. 
    - **集合接口.** 描述不同的集合類型,如sets,lists,與maps
      These interfaces form the basis of the framework.
      這些接口表單基於框架.
  - **General-purpose implementations.** Primary implementations of the collection interfaces.
    - **通用實現.** 主要的集合接口實現
  - **Legacy implementations.** The collection classes from earlier releases, Vector and Hashtable, were retrofitted to implement the collection interfaces.
    - **遺留實現.** 早期的releases版本的集合類,Vector,Hashtable被重新實現了集合接口.
  - **Special-purpose implementations.** Implementations designed for use in special situations. 
    - **特定實現.** 被設計的實現用於特定的狀況.
      These implementations display nonstandard performance characteristics, usage restrictions, or behavior.
      這些實現展示了非標準的執行字符,使用限制或行為.
  - **Concurrent implementations.** Implementations designed for highly concurrent use.
    - **並發的實現.** 實現被設計應用於高並發.
  - **Wrapper implementations.** Add functionality, such as synchronization, to other implementations.
    - **包裝的實現.** 為其他實現添加功能,例如synchronization.
  - **Convenience implementations.** High-performance "mini-implementations" of the collection interfaces.
    - **便捷的實現.** 高性能的集合接口的“小實現”.
  - **Abstract implementations.** Partial implementations of the collection interfaces to facilitate custom implementations.
    - **抽象的實現.** 局部的集合的實現促進定制的實現.
  - **Algorithms.** Static methods that perform useful functions on collections, such as sorting a list.
    - **算法.** 在集合中存在靜態的對平台有用的方法,例如排序的list.
  - **Infrastructure.** Interfaces that provide essential support for the collection interfaces.
    - **底層** 接口針對於集合接口的私有的必要支持.
  - **Array Utilities.** Utility functions for arrays of primitive types and reference objects. 
    - **數組工具** 針對於原始類型的數組和引用實體的工具方法.
      Not, strictly speaking, a part of the collections framework, 
      哦,不，嚴格的來說,是集合框架的一部分,
      this feature was added to the Java platform at the same time as the collections framework and relies on some of the same infrastructure.
      這些特色是在同一時間作為集合框架和可信賴的一些相同的底層被添加於JAVA平台的.
## Collection Interfaces
  - The collection interfaces are divided into two groups. 
    集合接口被分為兩組.
    The most basic interface, java.util.Collection, has the following descendants:
    最基礎的接口,java.util.Collection,包含了以下子節點:
```java
    java.util.Set
    java.util.SortedSet
    java.util.NavigableSet
    java.util.Queue
    java.util.concurrent.BlockingQueue
    java.util.concurrent.TransferQueue
    java.util.Deque
    java.util.concurrent.BlockingDeque
```
  - The other collection interfaces are based on java.util.Map and are not true collections.
    另外的集合接口以 java.util.Map 為基礎並不是一個真實的集合.
    However, these interfaces contain collection-view operations, 
    儘管如此,這些接口包含了集合視圖操作,
    which enable them to be manipulated as collections.
    能夠使得他們像集合一樣備操作.
    Map has the following offspring:
    Map有以下子節點:
```java
    java.util.SortedMap
    java.util.NavigableMap
    java.util.concurrent.ConcurrentMap
    java.util.concurrent.ConcurrentNavigableMap
```
  - Many of the modification methods in the collection interfaces are labeled optional. 
    在集合接口中許多修改的方法被標記為可選的.
    Implementations are permitted to not perform one or more of these operations,
    實現是被准許不執行這些操作中的一個或更多,
    throwing a runtime exception (UnsupportedOperationException) if they are attempted.
    如果他們被企圖則會拋出一個運行時異常(不被支持的操作異常).
    The documentation for each implementation must specify which optional operations are supported.
    每一個實現文檔必須制定哪一個可選的操作是被支持的.
    Several terms are introduced to aid in this specification:
    在這個說明中幾個術語有助於被介紹:
    * Collections that do not support modification operations (such as add, remove and clear) are referred to as unmodifiable.
      不支持修改操作的集合(例如:add,remove,clear)作為不可修改的參考.
      Collections that are not unmodifiable are modifiable.
      可修改的集合是可修改的.
    * Collections that additionally guarantee that no change in the Collection object will be visible are referred to as immutable.
      集合實體中無變化的額外保證可視化的集合是不可變的參考.
      Collections that are not immutable are mutable.
      可變的集合是可改變的.
    * Lists that guarantee that their size remains constant even though the elements can change are referred to as fixed-size.
      保證儘管元素能改變但是他們的大小是恆定的列表是固定大小的參考.
      Lists that are not fixed-size are referred to as variable-size.
      不是固定大小的列表是可變大小的參考.
    * Lists that support fast (generally constant time) indexed element access are known as random access lists.
      支持快速(恆定時間)索引元素訪問的列表作為一個隨機訪問的列表被了解. 
      Lists that do not support fast indexed element access are known as sequential access lists.
      不支持快速索引元素訪問的列表做為一個連續訪問的列表被了解.
      The RandomAccess marker interface enables lists to advertise the fact that they support random access.
      隨機訪問標籤接口能夠使得列表突出他們支持隨機訪問的事實.
      This enables generic algorithms to change their behavior to provide good performance when applied to either random or sequential access lists.
      這使得通常的算法改變他們的習慣當申請隨機或序列的訪問列表時提供好的性能.
  - Some implementations restrict what elements (or in the case of Maps, keys and values) can be stored.
    一些實現限定元素(或者Maps的類型,鍵,值)別存儲.
    Possible restrictions include requiring elements to:
    也許限定包含必須的元素:
    * Be of a particular type.
      一個特殊的類型.
    * Be not null.
      不能為空.
    * Obey some arbitrary predicate.
      遵從一些特定的術語.
  - Attempting to add an element that violates an implementation's restrictions results in a runtime exception,
    嘗試添加一個違反一個實現限制元素的結果元素在運行時異常中,
    typically a ClassCastException, an IllegalArgumentException, or a NullPointerException.
    代表 ClassCastException, IllegalArgumentException, NullPointerException.
    Attempting to remove or test for the presence of an element that violates an implementation's restrictions can result in an exception.
    嘗試溢出或者測試一個對於一個存在的違反實現限制元素的結果元素在一個異常中,
    Some restricted collections permit this usage.
    一些受限的集合允許這樣的使用.
## Collection Implementations
  - Classes that implement the collection interfaces typically have names in the form of <Implementation-style><Interface>.
    實現了集合接口的類在表格中有特色名稱.
    The general purpose implementations are summarized in the following table:
    一般用途的實現總結如下表格:
<table>
    <tr> <td> Interface </td> <td> Hash Table </td> <td> Resizable Array </td> <td> Balanced Tree </td> <td> Linked List </td> <td> Hash Table + Linked List </td> </tr>
  	<tr> <td> Set </td> <td> HashSet </td> <td> </td> <td> TreeSet </td> <td> </td> <td> LinkedHashSet </td> </tr> <tr> <td> List </td> <td> </td> <td> ArrayList </td> <td> </td> <td> LinkedList </td> <td> </td> </tr>
  	<tr> <td> Deque </td> <td> </td> <td> ArrayDeque </td> <td> </td> <td> LinkedList </td> <td> </td> </tr> <tr> <td> Map </td> <td> HashMap </td> <td> </td> <td> TreeMap </td> <td> </td> <td> LinkedHashMap </td> </tr>
</table>
  - The general-purpose implementations support all of the optional operations in the collection interfaces
    一般用途的實現支持所有在集合接口中的任意操作
    and have no restrictions on the elements they may contain.
    並且在他們所包含的元素中沒有限制條件.
    They are unsynchronized,
    他們是非同步化的,
    but the Collections class contains static factories called synchronization wrappers that can be used to add synchronization to many unsynchronized collections. 
    但是集合類包含靜態的因子被同步封裝的能夠備用於添加同步化為許多非同步的集合.
    ***All of the new implementations have fail-fast iterators***,
    所有新的實現都包含fail-fast迭代器,
    which detect invalid concurrent modification, and fail quickly and cleanly (rather than behaving erratically).
    監視無效的並發修改,快速失敗以及清除(而不是不規律的表現)    
  - The AbstractCollection, AbstractSet, AbstractList, AbstractSequentialList and AbstractMap classes 
    抽象的 AbstractCollection, AbstractSet, AbstractList, AbstractSequentialList 以及 AbstractMap 類
    provide basic implementations of the core collection interfaces,
    准許基本的核心接口的實現,
    to minimize the effort required to implement them.
    最小化必須實現他們的精力. 
    The API documentation for these classes describes precisely how each method is implemented so the implementer knows which methods must be overridden,
    API文檔對於這些類精準的描述了每一個方法是如何被實現的如實現者知道哪個方法必須被複寫,
    given the performance of the basic operations of a specific implementation.
    給性能一個基本的的操作基於特定的實現.
## Concurrent Collections
  - Applications that use collections from more than one thread must be carefully programmed. 
    應用多餘一條線程的應用程序必須被小心的編寫.
    In general, this is known as concurrent programming.
    通常,這是被了解的作為並發編程.
    The Java platform includes extensive support for concurrent programming.
    JAVA平台包含應用於支持並發編程的擴展.
    See Java Concurrency Utilities for details.
    細節請查看JAVA並發工具.
  - Collections are so frequently used that various concurrent friendly interfaces and implementations of collections are included in the APIs.
    集合被如此頻繁的用於友好的接口及集合的實現包含其中的多變的並發中.
    These types go beyond the synchronization wrappers discussed previously to provide features that are frequently needed in concurrent programming.
    這些類型超出先前討論的提供給將來的頻繁應用於並發編程的同步封裝.
    These concurrent-aware interfaces are available:
    這些並發知識是可以獲取的:
     * BlockingQueue
     * TransferQueue
     * BlockingDeque
     * ConcurrentMap
     * ConcurrentNavigableMap
  - The following concurrent-aware implementation classes are available.
    包含並發知識的實現類是可獲取的.
    See the API documentation for the correct usage of these implementations.
    針對於正確使用這些實現請查看API文檔.
     * LinkedBlockingQueue
     * ArrayBlockingQueue
     * PriorityBlockingQueue
     * DelayQueue
     * SynchronousQueue
     * LinkedBlockingDeque
     * LinkedTransferQueue
     * CopyOnWriteArrayList
     * CopyOnWriteArraySet
     * ConcurrentSkipListSet
     * ConcurrentHashMap
     * ConcurrentSkipListMap
## Design Goals
- The main design goal was to produce an API that was small in size and, more importantly, in "conceptual weight".
  主要的公共設計是創建一個在大小上更小的,在概念重要性上更重要的API.
  It was critical that the new functionality not seem too different to current Java programmers;
  他是重要的在新的功能上是的當前JAVA開發人員開起來不是太難;
  it had to augment current facilities, rather than replace them. 
  他增加當前的條件,而不是替換他們.
  At the same time, the new API had to be powerful enough to provide all the advantages described previously.
  與此同時,新的API使得所有以前的有益的描述更加的給力.
    
- To keep the number of core interfaces small,
  保持大量的核心小接口,
  the interfaces do not attempt to capture such subtle distinctions as mutability, modifiability, and resizability.
  這些接口不能嘗試捕獲諸如異變的,可編輯的以及真實的細小的描述,
  Instead, certain calls in the core interfaces are optional,
  與之替換的,確保呼叫核心接口是可選的,
  enabling implementations to throw an UnsupportedOperationException to indicate that they do not support a specified optional operation.
  授權實現拋出UnsupportedOperationException異常來表明他們不能支持一個特定的可選的操作.
  Collection implementers must clearly document which optional operations are supported by an implementation.
  集合實現必須明確文檔表名可選的操作是被支持于一個實現的.
    
- To keep the number of methods in each core interface small, an interface contains a method only if either:
  保持大量的方法在每一個核心的小接口內,一個接口包含一個方法當且僅當:
    
  * It is a truly fundamental operation: a basic operations in terms of which others could be reasonably defined,
    他是一個真實的基本操作:一組其他的可被作為結果定義的一個基礎的操作
  * There is a compelling performance reason why an important implementation would want to override it.
    一個強制的平台原因一個重要的實現想要複寫他
    
- It was critical that all reasonable representations of collections interoperate well.
  他是起決定性作用的在所有合理的集合很好交互的代表中.
  This included arrays, which cannot be made to implement the Collection interface directly without changing the language.
  這個包含不能實現集合接口確保不能改變語言的數組.
  Thus, the framework includes methods to enable collections to be moved into arrays,
  因此,這個框架包含的放阿飛能夠使得集合被移入數組,
  arrays to be viewed as collections, and maps to be viewed as collections. 
  數組能夠備看做為集合,以及Map可以被看作為集合.
  
# [***官方API頁面***](http://docs.oracle.com/javase/7/docs/technotes/guides/collections/overview.html)截圖:

<img src="/images/2015-11-26_173951.png"  />
