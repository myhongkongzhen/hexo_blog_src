---
title: UML class diagram
categories: technology
date: 2017-07-31 18:23:52
tags:
- UML
---
> - Unified Modeling Language

<!--more-->

# UML class diagram
------
```puml
@startuml
package uml_class_extends_implements <<Frame>>{
   
    Animal <|--d-- Dog : extends / 泛化 （繼承）
    note "泛化是一種一般與特殊、一般與具體之間關係的描述，\n具體描述建立在一般描述的基礎之上，並對其進行了擴展。 \n在程序中是通過繼承類實現的。\n比如狗是對動物的具體描述，在面向對象設計的時候一般把狗設計為動物的子類。 \n表示方法：空心三角形箭頭的實線，子類指向父類" as N1
    Animal .. N1
    N1 .. Dog
    
    interface IDog{
    }
    IDog <|.d. Dog : implements / 實現 （接口）
    
    note "實現是一種類與接口的關係，表示類是接口所有特徵和行為的實現，\n在程序中一般通過類實現接口來描述.\n 表示方法：空心三角形箭頭的虛線，實現類指向接口" as N2
    IDog .. N2
    N2 .. Dog
}
@enduml
```
IMG download => [uml_class_extends_implements](/images/elasticsearch/021_uml_class_01.png)

```puml
@startuml
package uml_class_dependency <<Frame>>{
    
    class People {
        +crossRiver(Boat boat)
    }
    
    People .right.> Boat : 依賴 （需要協助）\n<color:red><b>There is no 'Boat' instance in class 'People'.
    note "是一種使用的關係，即一個類的實現需要另一個類的協助，所以要儘量不使用雙向的互相依賴，\n在程序中一般表現為類A中的方法需要類B的實例作為其參數或者變量，\n而類A本身並不需要引用類B的實例作為其成員變量。\n表示方法：虛線箭頭，類A指向類B。" as N3
    People .. N3
    N3 .. Boat
    
}
@enduml
```
IMG download => [uml_class_dependency](/images/elasticsearch/021_uml_class_02.png)

```puml
@startuml
package uml_class_association_aggregation <<Frame>>{
   
    class Teacher{
        -course : Cource
        -students : Student
    }
    Teacher --> Course : 關聯 （我知道你）
    note "表示類與類之間的聯接,它使一個類知道另一個類的屬性和方法，\n這種關係比依賴更強、不存在依賴關係的偶然性、關係也不是臨時性的，\n一般是長期性的，在程序中被關聯類B以類屬性的形式出現在關聯類A中，\n也可能是關聯類A引用了一個類型為被關聯類B的全局變量\n 表示方法：實線箭頭，類A指向類B" as N4
    Teacher .. N4
    N4 .. Course
    
   
    Teacher o--> Student : 聚合 （has-a 有）<color:red><b>strong
    note "聚合關聯關係的一種特例，是強的關聯關係。\n聚合是整體和個體之間的關係，即has-a的關係，\n整體與個體可以具有各自的生命周期，\n部分可以屬於多個整體對象，也可以為多個整體對象共享。\n程序中聚合和關聯關係是一致的，只能從語義級別來區分;\n表示方法：尾部為空心菱形的實線箭頭（也可以沒箭頭），類A指向類B" as N5
    Teacher .. N5
    N5 .. Student
    note "<color:red><size:20>被聚合的類可以單獨存在,獨立存在的意思是在某個應用的問題域中這個類的存在有意義\n自己構造函數中不使用" as N6
    Student .. N6
    
}
@enduml
```
IMG download => [uml_class_association_aggregation](/images/elasticsearch/021_uml_class_03.png)

```puml
@startuml
package uml_class_composition <<Frame>>{
  
    Human "1" *--> "2" Leg : 組合 （contains-a 包含）\n<color:red><b>strong strong
    Human "1" *--> "1" Head : 組合 （contains-a 包含）\n<color:red><b>strong strong
    note "組合也是關聯關係的一種特例。組合是一種整體與部分的關係，即contains-a的關係，比聚合更強。\n部分與整體的生命周期一致，整體的生命周期結束也就意味著部分的生命周期結束，組合關係不能共享。\n程序中組合和關聯關係是一致的，只能從語義級別來區分。\n 表示方法：尾部為實心菱形的實現箭頭（也可以沒箭頭），類A指向類B" as N7
    Human .. N7
    N7 .. Leg
    N7 .. Head
    note "<color:red><size:20>被組合的類不會單獨存在(視問題域而定)(自己構造函數中使用)\n<color:red><size:20>在《敏捷開發》中還說到，A組合B，則A需要知道B的生存周期，\n<color:red><size:20>即可能A負責生成或者釋放B，\n<color:red><size:20>或者A通過某種途徑知道B的生成和釋放" as N8
    Leg .. N8
    Head .. N8
    
    note "<color:red><size:20>被聚合的類可以單獨存在,獨立存在的意思是在某個應用的問題域中這個類的存在有意義\n自己構造函數中不使用" as N6
    note "聚合和組合：\n 問題域的語義上：組合中被組合類單獨存在沒有意義;\n 聚合中被聚合類在可以有單獨存在的意義。\n 生命期上：組合中必須要負責被組合類的生命期;\n 聚合中可不負責被聚合類的聲明期，可以由外部程序來創建和消亡（可用賦值）。" as N9
    N6 .. N9
    N8 .. N9
}
@enduml
```
IMG download => [uml_class_composition](/images/elasticsearch/021_uml_class_04.png)







