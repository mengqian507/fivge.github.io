#### Class

###### 重载

发生在同一个类中，方法名必须相同，参数类型不同、个数不同、顺序不同，方法返回值和访问修饰符可以不同。

### Types

[int 和 Integer 的区别](https://www.cnblogs.com/guodongdidi/p/6953217.html)

https://github.com/Snailclimb/JavaGuide/blob/master/docs/java/Basis/Arrays%2CCollectionsCommonMethods.md

https://www.cnblogs.com/linkworld/p/7819270.html

https://my.oschina.net/cloudcoder/blog/362974

https://www.cnblogs.com/nullzx/p/5270233.html

---

https://www.cnblogs.com/coprince/p/8692972.html

https://zacard.net/2016/05/31/mybatis-batch-java8/

https://www.cnblogs.com/jian0110/p/9452592.html

https://blog.csdn.net/dm_vincent/article/details/46801311

#### int

##### String to int

```java
第一种方法：i=Integer.parseInt(s);//直接使用静态方法，不会产生多余的对象，但会抛出异常
第二种方法：i=Integer.valueOf(s).intValue();//Integer.valueOf(s) 相当于 new Integer(Integer.parseInt(s))，也会抛
```

---

#### List

#### Map

#### Set

---

### Collections 工具类

#### Collections

1. 排序
2. 查找,替换操作
3. 同步控制(不推荐，需要线程安全的集合类型时请考虑使用 JUC 包下的并发集合)

#### 排序操作

```java
void reverse(List list)//反转
void shuffle(List list)//随机排序
void sort(List list)//按自然排序的升序排序
void sort(List list, Comparator c)//定制排序，由Comparator控制排序逻辑
void swap(List list, int i , int j)//交换两个索引位置的元素
void rotate(List list, int distance)//旋转。当distance为正数时，将list后distance个元素整体移到前面。当distance为负数时，将 list的前distance个元素整体移到后面。
```

```java
import java.util.Collections;

	Collections.reverse(arrayList);
    Collections.rotate(arrayList, 4);
// 定制排序-冒泡排序
    Collections.sort(arrayList, (Integer o1, Integer o2) -> o2.compareTo(o1));
```

#### 查找、替换操作

```java
int binarySearch(List list, Object key)//对List进行二分查找，返回索引，注意List必须是有序的
int max(Collection coll)//根据元素的自然顺序，返回最大的元素。 类比int min(Collection coll)
int max(Collection coll, Comparator c)//根据定制排序，返回最大元素，排序规则由Comparatator类控制。类比int min(Collection coll, Comparator c)
void fill(List list, Object obj)//用指定的元素代替指定list中的所有元素。
int frequency(Collection c, Object o)//统计元素出现次数
int indexOfSubList(List list, List target)//统计target在list中第一次出现的索引，找不到则返回-1，类比int lastIndexOfSubList(List source, list target).
boolean replaceAll(List list, Object oldVal, Object newVal)//用新元素替换旧元素
```

```java
Collections.replaceAll(arrayList, 3, -3);
Collections.indexOfSubList(arrayList, arrayList2)
Collections.binarySearch(arrayList, 7)
```

#### 同步控制

Collections 提供了多个`synchronizedXxx()`方法·，该方法可以将指定集合包装成线程同步的集合，从而解决多线程并发访问集合时的线程安全问题。

我们知道 HashSet，TreeSet，ArrayList,LinkedList,HashMap,TreeMap 都是线程不安全的。Collections 提供了多个静态方法可以把他们包装成线程同步的集合。

**最好不要用下面这些方法，效率非常低，需要线程安全的集合类型时请考虑使用 JUC 包下的并发集合。**

方法如下：

```java
synchronizedCollection(Collection<T>  c) //返回指定 collection 支持的同步（线程安全的）collection。
synchronizedList(List<T> list)//返回指定列表支持的同步（线程安全的）List。
synchronizedMap(Map<K,V> m) //返回由指定映射支持的同步（线程安全的）Map。
synchronizedSet(Set<T> s) //返回指定 set 支持的同步（线程安全的）set。
```

```java
        Map<String, String> map = Collections.synchronizedMap(new HashMap<String, String>());
        Map<String, String> map2 = new HashMap<String, String>();
        List<String> list = Collections.synchronizedList(new ArrayList<String>());
        List<String> list2 = new ArrayList<String>();
        Set<String> set = Collections.synchronizedSet(new HashSet<String>());
        Set<String> set2 = new HashSet<String>();
```

Collections 还可以设置不可变集合，提供了如下三类方法：

```
emptyXxx(): 返回一个空的、不可变的集合对象，此处的集合既可以是List，也可以是Set，还可以是Map。
singletonXxx(): 返回一个只包含指定对象（只有一个或一个元素）的不可变的集合对象，此处的集合可以是：List，Set，Map。
unmodifiableXxx(): 返回指定集合对象的不可变视图，此处的集合可以是：List，Set，Map。
上面三类方法的参数是原有的集合对象，返回值是该集合的”只读“版本。
```

```java
List<Object> list = Collections.emptyList();
Set<Object> objects = Collections.emptySet();
Map<Object, Object> objectObjectMap = Collections.emptyMap();

List<ArrayList<Integer>> arrayLists = Collections.singletonList(arrayList);

List<Integer> integers = Collections.unmodifiableList(arrayList);
```

### Arrays 工具类

---

### 参数传递

[Java调用函数传递参数到底是值传递还是引用传递](https://www.cnblogs.com/wutianqi/p/8723582.html)

### JUC

#### JUC

---

### Thread

```java
// 线程 sleep(200)
Thread.sleep(200);
```

### BigDecimal

**二、构造器描述**
BigDecimal(int) 创建一个具有参数所指定整数值的对象。
BigDecimal(double) 创建一个具有参数所指定双精度值的对象。
BigDecimal(long) 创建一个具有参数所指定长整数值的对象。
BigDecimal(String) 创建一个具有参数所指定以字符串表示的数值的对象。

**三、方法描述**
add(BigDecimal) BigDecimal 对象中的值相加，然后返回这个对象。
subtract(BigDecimal) BigDecimal 对象中的值相减，然后返回这个对象。
multiply(BigDecimal) BigDecimal 对象中的值相乘，然后返回这个对象。
divide(BigDecimal) BigDecimal 对象中的值相除，然后返回这个对象。
toString() 将 BigDecimal 对象的数值转换成字符串。
doubleValue() 将 BigDecimal 对象中的值以双精度数返回。
floatValue() 将 BigDecimal 对象中的值以单精度数返回。
longValue() 将 BigDecimal 对象中的值以长整数返回。
intValue() 将 BigDecimal 对象中的值以整数返回。

```java
    BigDecimal a = new BigDecimal("1");
    BigDecimal b = new BigDecimal("2");

a.add(b);
a.subtract(b);
```
