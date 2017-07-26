title: Outline of the Collection Framework -- (二) 
date: 2015-11-30 12:23:26
categories: 技術
tags:
 - JAVA
 - JDK1.7
 - TRANSLATING
---
> 簡介：Collections Framework. JDK1.7 集合框架系統學習 (二) 概述 
> 集合框架API DOC簡介英文翻譯練習。
> 相關源碼分析及詳細api文檔移路→[Collection接口https://github.com/myhongkongzhen/pro-study-jdk/](https://github.com/myhongkongzhen/pro-study-jdk/tree/master/src/main/java/z/z/w/jdk/collections)
> ※ 注：此翻譯僅僅為個人學習JDK文檔及補習英文所做，如果您希望看到更加準確的翻譯，請自行搜尋中文文檔
>       因英文水平不足為您帶來的不便請諒解.

<!--more-->

# API Specification
  API詳述
* API Reference - An annotated outline of the classes and interfaces comprising the collections framework, with links into the JavaDoc.
  API參考 - 一個有注釋的類和接口的概述組成集合框架,連接至JavaDoc.
## The collections framework consists of: 
   集合框架包含:
   
#### **Collection interfaces** - The primary means by which collections are manipulated. 
  **集合接口** - 通過集合操作的主要手段.
  
  - **Collection** - A group of objects. 
    **Clollection** - 一組對象.
    No assumptions are made about the order of the collection (if any) or whether it can contain duplicate elements.
    沒有假設關於排序的集合是可用的,如果有的話,或者集合包含重複的元素.
  - **Set** - The familiar set abstraction. 
    **Set** - 常見的抽象set.
    No duplicate elements permitted. 
    不允許重複的元素.
    May or may not be ordered.
    可排序的.
    Extends the Collection interface.
    擴展Collection接口. 
  - **List** - Ordered collection, also known as a sequence. 
    **List** - 排序的集合,同時作為一個已知的序列.
    Duplicates are generally permitted.
    通常允許重複.
    Allows positional access.
    允許定位存取.
    Extends the Collection interface.
    擴展自Collection接口.
  - **Queue** - A collection designed for holding elements before processing.
    **Queue** - 集合可以在處理前保存元素.
    Besides basic Collection operations,
    包含基本的集合操作以外的操作, 
    queues provide additional insertion, extraction, and inspection operations.
    隊列提供可添加的插入,提取和檢視操作.
  - **Deque** - A double ended queue, supporting element insertion and removal at both ends.
    **Deque** - 一個雙向的queue,支持元素在兩端插入和移除.
    Extends the Queue interface.
    擴展自Queue接口.
  - **Map** - A mapping from keys to values. Each key can map to one value.
    **Map** - 一個k-v影射Map.每個Key影射一個Value.
  - **SortedSet** - A set whose elements are automatically sorted,
    **SortedSet** - 元素自動排序的集合set,
    either in their natural ordering (see the Comparable interface) or by a Comparator object provided when a SortedSet instance is created.
    要麼使用自然排序(請看Comparable接口)要麼在SortedSet實例在創建時,由Comparator對象提供排序.
    Extends the Set interface.
    擴展自Set接口.
  - **SortedMap** - A map whose mappings are automatically sorted by key,
    **SortedMap** - 一個自動根據Key進行排序的Map,
    either using the natural ordering of the keys or by a comparator provided when a SortedMap instance is created.
    要麼使用key的自然排序,要麼在一個SortedMap實例創建時由Comparator提供排序.
    Extends the Map interface.
    擴展自Map接口.
  - **NavigableSet** - A SortedSet extended with navigation methods reporting closest matches for given search targets.
    **NavigableSet** - 一個SortedSet的擴展,給搜索目標報告由導航方法搜索到的最近的方法.
    A NavigableSet may be accessed and traversed in either ascending or descending order.
    一個NavigableSet可以存取和訪問遞增或遞減的集合.
  - **NavigableMap** - A SortedMap extended with navigation methods returning the closest matches for given search targets.
    **NavigableMap** - 一個SortedMap的擴展,給所搜索的目標返回導航方法搜索到的最近的方法. 
    A NavigableMap can be accessed and traversed in either ascending or descending key order.
    一個NavigableMap能夠存取和訪問按照Key排序遞增或遞減的集合.
  - **BlockingQueue** - A Queue with operations 
    **BlockingQueue** - queue操作,
    that wait for the queue to become nonempty when retrieving an element 
    在隊列恢復一個元素成為非空時進行操作, 
    and that wait for space to become available in the queue when storing an element. 
    在隊列中存儲一個元素,成為可用隊列是進行操作.
    (This interface is part of the java.util.concurrent package.)
    (這個接口是java.util.concurrent包下的一部分.)
  - **TransferQueue** - A BlockingQueue in which producers can wait for consumers to receive elements.
    **TransferQueue** - 一個BlockingQueue,能夠讓生產者等待消費者接收elements.
    (This interface is part of the java.util.concurrent package.)
    (這個接口是java.util.concurrent包的一部分.)
  - **BlockingDeque** - A Deque with operations 
    **BlockingDeque** - Deque操作
    that wait for the deque to become nonempty when retrieving an element 
    在隊列恢復一個元素成為非空隊列時操作
    and wait for space to become available in the deque when storing an element.
    在隊列存儲一個元素成為可操作隊列時操作.
    Extends both the Deque and BlockingQueue interfaces.
    擴展自Deque與BlockingQueue兩個接口.
    (This interface is part of the java.util.concurrent package.)
    (這個接口是java.util.concurrent包的一部分.)
  - **ConcurrentMap** - A Map with atomic putIfAbsent, remove, and replace methods.
    **ConcurrentMap** - 原子操作,刪除,替換方法的Map.
    (This interface is part of the java.util.concurrent package.)
    (這個接口是java.util.concurrent包的一部分.)
  - **ConcurrentNavigableMap** - A ConcurrentMap that is also a NavigableMap.
    **ConcurrentNavigableMap** - 同樣是一個NavigableMap的ConcurrentMap.
    
#### **General-purpose implementations** - The primary implementations of the collection interfaces.
  **通用的實現** - 集合接口主要的實現
  
  - **HashSet** - Hash table implementation of the Set interface.
    **HashSet** - 實現了set接口的Hash table.
    The best all-around implementation of the Set interface.
    set接口最完整的實現.
  - **TreeSet** - Red-black tree implementation of the NavigableSet interface.
    **TredSet** - NavigableSet接口的Red-black樹實現
  - **LinkedHashSet** - Hash table and linked list implementation of the Set interface.
    **LinkedHashSet** - Set接口的哈希表與鏈錶的實現
    An insertion-ordered Set implementation that runs nearly as fast as HashSet.
    如同HashSet一樣快速的插入排序的set集合
  - **ArrayList** - Resizable array implementation of the List interface (an unsynchronized Vector).
    **ArrayList** - List接口的可變大小的數組實現(一個非同步的Vector).
    The best all-around implementation of the List interface.
    List接口最完整的實現.
  - **ArrayDeque** - Efficient, resizable array implementation of the Deque interface.
    **ArrayDeque** - Deque接口的高效的,可變大小的數組實現.
  - **LinkedList** - Doubly-linked list implementation of the List interface.
    **LinkedList** - List接口的雙向鏈錶實現的接口
    Provides better performance than the ArrayList implementation if elements are frequently inserted or deleted within the list.
    提供比ArrayList實現更高性能的實現,如果在list內部元素是序列的插入或者刪除. 
    Also implements the Deque interface. When accessed through the Queue interface, LinkedList acts as a FIFO queue.
    同樣實現于Deque接口.當存儲訪問Queue接口時,LinkedList當做是一個FIFO的queue.
  - **PriorityQueue** - Heap implementation of an unbounded priority queue.
    **PriorityQueue** - 一個不受限制的優先級queue的堆實現.
  - **HashMap** - Hash table implementation of the Map interface (an unsynchronized Hashtable that supports null keys and values).
    **HashMap** - Map接口的哈希表實現(允許null的key和value的非同步的HashTable).
    The best all-around implementation of the Map interface.
    Map接口的最完整的實現.
  - **TreeMap** Red-black tree implementation of the NavigableMap interface.
    **TreeMap** NavigableMap接口的Red-black樹的實現.
  - **LinkedHashMap** - Hash table and linked list implementation of the Map interface.
    **LinkedHashMap** - Map接口的哈希表與鏈錶的實現.
    An insertion-ordered Map implementation that runs nearly as fast as HashMap.
    如同HashMap一樣快速的的插入排序的Map.
    Also useful for building caches (see removeEldestEntry(Map.Entry) ).
    也可用於構建caches(看 moveEldestEntry(Map.Entry)).
    
#### **Wrapper implementations** - Functionality-enhancing implementations for use with other implementations.
  **封裝的實現** - 一些其他的實現用於功能增強的實現.
    Accessed solely through static factory methods.
    僅僅通過靜態工廠方法進行存儲訪問.
    
  - **Collections.unmodifiableInterface** - Returns an unmodifiable view of a specified collection 
    **Collections.unmodifiableInterface** - 返回一個特定集合的不可修改的視圖.
    that throws an UnsupportedOperationException if the user attempts to modify it.
    如果用戶視圖修改這個視圖，將會拋出一個UnsupportedOperationException異常.
  - **Collections.synchronizedInterface** - Returns a synchronized collection 
    **collections.synchronizedInterface** - 返回一個同步化的集合
    that is backed by the specified (typically unsynchronized) collection.
    這個集合由特定的接口支持(典型的代表非同步化的).
    As long as all accesses to the backing collection are through the returned collection,
    所有通過這個返回的集合存儲訪問的支持的接口,  
    thread safety is guaranteed.
    線程安全是課保證的.
  - **Collections.checkedInterface** - Returns a dynamically type-safe view of the specified collection,
    **Collections.checkedInterface** - 返回特定集合的動態的類型安全的視圖,
    which throws a ClassCastException if a client attempts to add an element of the wrong type.
    如果客戶端視圖添加一個錯誤類型的元素，將會破出一個ClassCastException異常.
    The generics mechanism in the language provides compile-time (static) type checking,
    這種在語言中的泛型機制提供編譯時(靜態)類型檢查,
    but it is possible to bypass this mechanism.
    但是其是可以繞過這種機制的. 
    Dynamically type-safe views eliminate this possibility.
    動態類型安全視圖排除這種可能.
    
#### **Adapter implementations** - Implementations that adapt one collections interface to another:
  **適配器實現** - 適配一個集合接口或者其他的實現:
  
  - **newSetFromMap(Map)** - Creates a general-purpose Set implementation from a general-purpose Map implementation.
    **newSetFromMap(Map)** - 通過一個通用的Map集合創建一個通用的Set集合實現.
  - **asLifoQueue(Deque)** - Returns a view of a Deque as a Last In First Out (LIFO) Queue.
    **asLifoQueue(Deque)** - 返回一個作為後勁先出(LIFO)的Queue的Deque的視圖.
    
#### **Convenience implementations** - High-performance "mini-implementations" of the collection interfaces.
  **方便的實現** - 集合接口中的高性能,小實現
  
  - **Arrays.asList** - Enables an array to be viewed as a list.
    **Array.asList** - 將一個array看做一個list
  - **emptySet, emptyList and emptyMap** - Return an immutable empty set, list, or map.
    **emptySet, emptyList and emptyMap** - 返回一個不變的空的set,list或者map.
  - **singleton, singletonList, and singletonMap** - Return an immutable singleton set, list, or map,
    **singleton, singletonList, and singletonMap** - 返回一個不變的單實例的set,list或者map,
    containing only the specified object (or key-value mapping).
    僅僅包含特定的object(或是key-value影射).
  - **nCopies** - Returns an immutable list consisting of n copies of a specified object.
    **nCopies** - 返回一個由特定object的N個備份組成的不變的list
    
#### **Legacy implementations** - Older collection classes were retrofitted to implement the collection interfaces.
  **遺留實現** - 實現集合的接口翻新舊的集合類.
  
  - **Vector** - Synchronized resizable array implementation of the List interface with additional legacy methods.
    **Vector** - 用於添加遺留方法的List接口中的同步化的可變大小的數組實現.
  - **Hashtable** - Synchronized hash table implementation of the Map interface that does not allow null keys or values,
    **Hashtable** - 同步化的Map接口哈希表實現,這個類型不允許空的key和value,
    plus additional legacy methods.
    加上額外的遺留方法.
    
#### **Special-purpose implementations**
  **特殊的實現**

  - **WeakHashMap** - An implementation of the Map interface that stores only weak references to its keys.
    **WeakHashMap** - 僅僅存儲了弱引用作為key的map接口的一個實現.
    Storing only weak references enables key-value pairs to be garbage collected when the key is no longer referenced outside of the WeakHashMap.
    僅僅存儲弱引用是的key-value鍵值對能夠垃圾回收,當Key值在WeakHashMap外沒有更長的引用時.
    This class is the easiest way to use the power of weak references.
    這個列是弱引用使用精力中最簡單的方法.
    It is useful for implementing registry-like data structures,
    對於實現註冊表狀的數據結構是有用的.
    where the utility of an entry vanishes when its key is no longer reachable by any thread.
    一個實體的功能消失是他的Keys在任何線程中不會獲取到.
  - **IdentityHashMap** - Identity-based Map implementation based on a hash table.
    **IdentityHashMap** - 基於一個哈希表的以Map身份出現的實現. 
    This class is useful for topology-preserving object graph transformations (such as serialization or deep copying).
    這個類有助於保留圖形變換的拓撲行的實體(例如序列化或者深拷貝).
    To perform these transformations, you must maintain an identity-based "node table" that keeps track of which objects have already been seen.
    要執行這些轉換,你必須維護一個基於身份標示的"node table",持續追蹤這些以觀察到的實體.
    Identity-based maps are also used to maintain object-to-meta-information mappings in dynamic debuggers and similar systems.
    基於map的身份標示同樣擁有保持元實體meta信息在動態的調試和簡單的系統中影射.
    Finally, identity-based maps are useful in preventing "spoof attacks" resulting from intentionally perverse equals methods.
    最後,基於maps的身份標示有效防止故意造成的"欺騙攻擊"方法.
    (IdentityHashMap never invokes the equals method on its keys.) An added benefit of this implementation is that it is fast.
    (IdentityHashMap 永遠不能在他的keys中調用equals方法.)
  - **CopyOnWriteArrayList** - A List implementation backed by an copy-on-write array.
    **CopyOnWriteArrayList** - 一個基於copy-on-write數組實現的List實現.
    All mutative operations (such as add, set, and remove) are implemented by making a new copy of the array.
    所有的變化的操作(例如add,set和remove)都是在一個新的拷貝的數組中作用的.
    No synchronization is necessary, even during iteration, and iterators are guaranteed never to throw ConcurrentModificationException.
    在迭代中同步化是非必須的,迭代因子收到保護永遠都不回拋出ConcurrentModificationExceptoin.
    This implementation is well-suited to maintaining event-handler lists
    這個實先非常適合維護事件處理列表.
    (where change is infrequent, and traversal is frequent and potentially time-consuming).
    (改變是稀有的,遍歷是頻繁的而且可能耗時的).
  - **CopyOnWriteArraySet** - A Set implementation backed by a copy-on-write array.
    **CopyOnWriteArraySet** - 一個基於copy-on-write數組實現的set實現.
    This implementation is similar to CopyOnWriteArrayList.
    這個實現類似於CopyOnWriteArrayList.
    Unlike most Set implementations, the add, remove, and contains methods require time proportional to the size of the set.
    和大多數set實現不同的是, add, remove, contains方法需要set大小的時間均衡.
    This implementation is well suited to maintaining event-handler lists that must prevent duplicates.
    這個實先非常適合維護事件處理那些必須防止副本的列表.
  - **EnumSet** - A high-performance Set implementation backed by a bit vector.
    **EnumSet** - 基於一個bit的vector實現的高性能的set實現.
    All elements of each EnumSet instance must be elements of a single enum type.
    每一個EnumSet的實體的所有元素必須是一個單實例的enum類型的元素.
  - **EnumMap** - A high-performance Map implementation backed by an array.
    **EnumMap** - 基於一個數組實現的的高性能的Map實現.
    All keys in each EnumMap instance must be elements of a single enum type.
    每一個EnumMap的實體中的所有keys都必須是一個單實例的enum類型的元素.
    
#### **Concurrent implementations** - These implementations are part of java.util.concurrent.
  **並發的實現** - 這些實現是java.util.concurrent包的一部分.
  
  - **ConcurrentLinkedQueue** - An unbounded first in, first out (FIFO) queue based on linked nodes.
    **ConcurrentLinkedQueue** - 一個基於linked節點的不受限制的先進先出隊列.
  - **LinkedBlockingQueue** - An optionally bounded FIFO blocking queue backed by linked nodes.
    **LinkedBlockingQueue** - 一個基於linked節點的隨意限制的先進先出阻塞隊列.
  - **ArrayBlockingQueue** - A bounded FIFO blocking queue backed by an array.
    **ArrayBlockingQueue** - 一個基於數組的受限制的先進先出的阻塞隊列.
  - **PriorityBlockingQueue** - An unbounded blocking priority queue backed by a priority heap.
    **PriorityBlockingQueue** - 一個基於優先級堆的不受限制的阻塞隊列.
  - **DelayQueue** - A time-based scheduling queue backed by a priority heap.
    **DelayQueue** - 一個基於優先級堆的基於時間安排的隊列.
  - **SynchronousQueue** - A simple rendezvous mechanism that uses the BlockingQueue interface.
    **SynchronousQueue** - 一個用於BlockingQueue接口的簡單機制
  - **LinkedBlockingDeque** - An optionally bounded FIFO blocking deque backed by linked nodes.
    **LinkedBlockingDeque** - 一個由linked節點支持的隨意有界的先進先出的阻塞deque.
  - **LinkedTransferQueue** - An unbounded TransferQueue backed by linked nodes.
    **LinkedTransferQueue** - 一個由linked節點支持的不受限制的TransferQueue.
  - **ConcurrentHashMap** - A highly concurrent, high-performance ConcurrentMap implementation based on a hash table.
    **ConcurrentHashMap** - 一個由哈希表支持的高並發，高性能的ConcurrentMap實現.
    This implementation never blocks when performing retrievals and enables the client to select the concurrency level for updates.
    這個是實現在執行檢索時永遠不會阻塞,並且能夠使客戶端在更新時選擇並發級別.
    It is intended as a drop-in replacement for Hashtable.
    這個類可以作為HashTable的替代類.
    In addition to implementing ConcurrentMap,
    除了添加實現ConcurrentMap,
    it supports all of the legacy methods of Hashtable.
    它支持所有的Hashtable中的遺留方法.
  - **ConcurrentSkipListSet** - Skips list implementation of the NavigableSet interface.
    **ConcurrentSkipListSet** - NavigableSet接口中的滑過list接口.
  - **ConcurrentSkipListMap** - Skips list implementation of the ConcurrentNavigableMap interface.
    **ConcurrentSkipListMap** - ConcurrentNavigableMap接口中的滑過list接口
    
#### **Abstract implementations** - Skeletal implementations of the collection interfaces to facilitate custom implementations.
  **抽象的實現** - 集合接口的實現骨架方便自定義的實現.
    
  - **AbstractCollection** - Skeletal Collection implementation that is neither a set nor a list (such as a "bag" or multiset).
    **AbstractCollection** - 集合實現的骨架既不是一個set也不是一個list(例如一個"bag"或者多重集合).
  - **AbstractSet** - Skeletal Set implementation.
    **AbstractSet** - Set實現的骨架.
  - **AbstractList** - Skeletal List implementation backed by a random access data store (such as an array).
    **AbstractList** - 支持隨機存儲訪問數據倉庫的List實現的骨架(例如一個array).
  - **AbstractSequentialList** - Skeletal List implementation backed by a sequential access data store (such as a linked list).
    **AbstractSequentialList** - 支持序列存儲訪問數據倉庫的List實現骨架(例如一個linked list).
  - **AbstractQueue** - Skeletal Queue implementation.
    **AbstractQueue** - Queue實現的骨架.
  - **AbstractMap** - Skeletal Map implementation.
    **AbstractMap** - Map實現的骨架.

#### **Algorithms** - The Collections class contains these useful static methods.
  **算法** - Collections類包含一些有用的靜態方法.

  - **sort(List)** - Sorts a list using a merge sort algorithm,
    **sort(List)** - 使用合併排序算法排序一個list,
    which provides average case performance comparable to a high quality quicksort,
    提供一個平均水平下的堪比高性能快速排序的性能,
    guaranteed O(n*log n) performance (unlike quicksort),
    保證O(n*log n)性能(不像快速排序),
    and stability (unlike quicksort).
    和穩定性(不像快排).
    A stable sort is one that does not reorder equal elements.
    一個穩定的排序是不會重複排列相同元素的.
  - **binarySearch(List, Object)** - Searches for an element in an ordered list using the binary search algorithm.
    **binarySearch(List, Object)** - 使用二分法查找算法在一個已排序的list中查找一個元素.
  - **reverse(List)** - Reverses the order of the elements in a list.
    **reverse(List)** - 在一個list中反轉元素的順序.
  - **shuffle(List)** - Randomly changes the order of the elements in a list.
    **shuffle(List)** - 在一個list中隨意的改變元素的順序.
  - **fill(List, Object)** - Overwrites every element in a list with the specified value.
    **fill(List, Object)** - 使用特定的值重寫在list中的每一個元素.
  - **copy(List dest, List src)** - Copies the source list into the destination list.
    **copy(List dest, List src)** - 拷貝源list到目標list中.
  - **min(Collection)** - Returns the minimum element in a collection.
    **min(Collection)** - 返回一個集合中最小的元素.
  - **max(Collection)** - Returns the maximum element in a collection.
    **max(collection)** - 返回一個集合中最大的元素.
  - **rotate(List list, int distance)** - Rotates all of the elements in the list by the specified distance.
    **rotate(List list, int distance)** - 按照指定的距離來旋轉集合中所有的元素.
  - **replaceAll(List list, Object oldVal, Object newVal)** - Replaces all occurrences of one specified value with another.
    **replaceAll(List list, Object oldVal, oldVal newVal)** - 用另一個值替換所有發現的特定的值.
  - **indexOfSubList(List source, List target)** - Returns the index of the first sublist of source that is equal to target.
    **indexOfSubList(List source, List target)** - 返回等於目標列表的源list中的第一個list子列表索引.
  - **lastIndexOfSubList(List source, List target)** - Returns the index of the last sublist of source that is equal to target.
    **lastIndexOfSubList(List source, List target)** - 返回等於目標列表的源list中的最後一個子列表的索引.
  - **swap(List, int, int)** - Swaps the elements at the specified positions in the specified list.
    **swap(List, int, int)** - 在指定的list中交換指定位置的的元素.
  - **frequency(Collection, Object)** - Counts the number of times the specified element occurs in the specified collection.
    **frequency(collection, Object)** - 計數在指定集合中指定元素出現的次數.
  - **disjoint(Collection, Collection)** - Determines whether two collections are disjoint, in other words, whether they contain no elements in common.
    **disjoint(Collection)** - 判斷兩個結合是否是不相交的,換句話說,他們是否包含元素的不同之處.
  - **addAll(Collection<? super T>, T...)** - Adds all of the elements in the specified array to the specified collection.
    **addAll(collection<? super T>, T...)** - 將指定的數組中的所有元素添加至指定的集合.

#### **Infrastructure**
  **基礎結構**
  
  - **Iterators** - Similar to the familiar Enumeration interface, but more powerful, and with improved method names.
    **迭代器** - 與熟悉的Enumeration接口類型,但更加有力,改良方法名.
     - **Iterator** - In addition to the functionality of the Enumeration interface,
       **Iterator** - 在Enumeration接口添加功能,
       enables the user to remove elements from the backing collection with well-defined, useful semantics.
       是的用戶可以支持在更好的定義,有用的語意上移除元素.
     - **ListIterator** - Iterator for use with lists. In addition to the functionality of the Iterator interface,
       **ListIterator** - 對於list有用的迭代器.在Iterator接口中添加功能,
       supports bidirectional iteration, element replacement, element insertion, and index retrieval.
       支持雙向的迭代,元素的替換,元素的添加以及索引的檢索.
  - **Ordering**
    **排序**
     - **Comparable** - Imparts a natural ordering to classes that implement it.
       **Comparable** - 實現這個接口,可以使得classes按照自然排序.
       The natural ordering can be used to sort a list or maintain order in a sorted set or map.
       自然排序可以用於排序一個list或者維護一個已排序的set或者map.
       Many classes were retrofitted to implement this interface.
       許多類都已經改造為實現這個接口.
     - **Comparator** - Represents an order relation,
       **Comparator** - 代表一個排序關係,
       which can be used to sort a list or maintain order in a sorted set or map.
       可以用於排序一個list或者維護一個已排序的set或者map.
       Can override a type's natural ordering or order objects of a type that does not implement the Comparable interface.
       用於複寫一個類型的自然排序或者排序那些不能實現Comparable接口的類型的對象.
  - **Runtime exceptions**
    **運行時遺產**
     - **UnsupportedOperationException** - Thrown by collections if an unsupported optional operation is called.
       **UnsupportedOperationException** - 如果使用了一個不支持的可選操作會有集合拋出異常.
     - **ConcurrentModificationException** - Thrown by iterators and list iterators 
       **ConcurrentModificationException** - 迭代器和list的迭代器會拋出異常, 
       if the backing collection is changed unexpectedly while the iteration is in progress.
       當迭代過程中支持的集合發生了意外的改變. 
       Also thrown by sublist views of lists if the backing list is changed unexpectedly.
       同樣支持的list發生了意外的改變,list的自列表視圖也會拋出異常. 
  - **Performance**
    **執行**
     - **RandomAccess** - Marker interface that lets List implementations indicate that they support fast (generally constant time) random access.
       **隨機存儲訪問** - 標記接口,使得列表實現支持快速的隨機存儲訪問(一般恆定的時間).
       This lets generic algorithms change their behavior to provide good performance when applied to either random or sequential access lists.
       這使得通用的算法改變了他們的表現,無論應用使用隨機或是序列的存儲訪問list,都提供了很好的性能. 
       
#### **Array Utilities**
  **數組工具**

  - **Arrays** - Contains static methods to sort, search, compare, hash, copy, resize, convert to String, and fill arrays of primitives and objects.
    **Arrays** - 包含了靜態的方法:sort,search,compare,hash,copy,resize,轉換成字符串以及填充數組的基本類型與對象.

























