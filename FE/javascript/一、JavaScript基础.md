## 一、JavaScript 基础

### 变量和类型

1. `JavaScript`规定了几种语言类型

   > JavaScript 有七种内置类型：
   > `null`、`undefined`、`boolean`、`string`、`number`、`object`、`symbol`。
   > 通过`typeof`检测`null`和`function`，返回的分别是`object`和`function`。
   > 已声明未赋值(`undefined`)和未声明未赋值(`undeclared`)

2. JavaScript`对象的底层数据结构是什么

   参考：https://zhuanlan.zhihu.com/p/26388217

3. `Symbol`类型在实际开发中的应用

应用场景 1：使用 Symbol 来作为对象属性名(key)

> const PROP_NAME = Symbol()
> const PROP_AGE = Symbol()
> let obj = {

> [PROP_NAME]: "一斤代码"
> }
> obj[PROP_AGE] = 18
> obj[PROP_NAME] // '一斤代码'
> obj[PROP_AGE] // 18

但是，当使用了 Symbol 作为对象的属性 key 后，Symbol 类型的 key 是不能通过`Object.keys()`或者`for...in`来枚举的，它未被包含在对象自身的属性名集合(property names)之中。所以，利用该特性，我们可以把一些不需要对外操作和访问的属性使用 Symbol 来定义。

> let obj = {

> [Symbol('name')]: '一斤代码',
> age: 18,
> title: 'Engineer'
> }
> Object.keys(obj) // ['age', 'title']
> for (let p in obj) {
> console.log(p) // 分别会输出：'age' 和 'title'
> }
> Object.getOwnPropertyNames(obj) // ['age', 'title']

也正因为这样一个特性，当使用`JSON.stringify()`将对象转换成 JSON 字符串的时候，Symbol 属性也会被排除在输出内容之外：我们可以利用这一特点来更好的设计我们的数据对象，让“对内操作”和“对外选择性输出”变得更加优雅。

如果要获得 Symbol 方式定义的对象属性：

> // 使用 Object 的 API
> Object.getOwnPropertySymbols(obj) // [Symbol(name)]
> // 使用新增的反射 API
> Reflect.ownKeys(obj) // [Symbol(name), 'age', 'title']

应用场景 2：使用 Symbol 来替代常量

const TYPE_AUDIO = Symbol()

应用场景 3：使用 Symbol 定义类的私有属性/方法

以上内容参考：https://www.cnblogs.com/linziwei/p/10818101.html ，写的比较全面。

4. 手动实现一个简单的 `Symbol`

   需要搞清楚 symbol 有哪些特性，才能通过代码实现

   参考：https://blog.csdn.net/weixin_34004750/article/details/88811449

5. JavaScript`中的变量在内存中的具体存储形式

   参考：https://www.jianshu.com/p/80bb5a01857a

6.基本类型对应的内置对象，以及他们之间的装箱拆箱操作

> js 的基本数据类型：（7 种）
>
> Undefined、Null、Boolean、Number、String、Object 新增:Symbol(创建后独一无二且不可变的数据类型)
>
> 内置对象：
>
> Object 是 JavaScript 中所有对象的父对象 数据封装类对象：Object、Array、Boolean、Number 和 String 其他对象：Function、Arguments、Math、Date、RegExp、Error。

7.理解值类型和引用类型

​ 和第五问答案差不多，可参考

8.`null`和 `undefined`的区别

> **Null：**
>
> null 是 js 中的关键字，表示空值，null 可以看作是 object 的一个特殊的值，如果一个 object 值为空，表示这个对象不是有效对象。
>
> **Undefined:**
>
> undefined 不是 js 中的关键字，其是一个全局变量，是 Global 的一个属性，以下情况会返回 undefined:
>
> 1）使用了一个未定义的变量；var i;
>
> 2）使用了已定义但未声明的变量；
>
> 3）使用了一个对象属性，但该属性不存在或者未赋值；
>
> 4)调用函数时，该提供的参数没有提供：
>
> ```
> `function func(a){``   ``console.log(a);      ``}``func();``//undefined`
> ```
>
> 5)函数没有返回值时，默认返回 undefined
>
> ```
> `var` `aa=func();``aa;``//undefined`
> ```
>
> **相同点：**
>
> 都是原始类型的值，保存在栈中变量本地
>
> **两者的区别：**
>
> 1.类型不一样：
>
> ```
> `console.log(typeOf undefined);``//undefined` `console.log(typeOf ``null``);``//object`
> ```
>
> 2.转化为值时不一样：undefined 为 NaN ,null 为 0
>
> ```
> `console.log(Number(undefined));``//NaN``console.log(Number(10+undefined));``//NaN` `console.log(Number(``null``));``//0``console.log(Number(10+``null``));``//10`
> ```
>
> 3.undefined===null;//false
>
> ​ undefined==null;//true
>
> **何时使用：**
>
> **null 当使用完一个比较大的对象时，需要对其进行释放内存时，设置为 null;**

> ```
> `var` `arr=[``"aa"``,``"bb"``,``"cc"``];``arr=``null``;``//释放指向数组的引用`
> ```

9.至少可以说出三种判断 `JavaScript`数据类型的方式，以及他们的优缺点，如何准确的判断数组类型

​ typeOf ,instanceOf ,object.prototype.tostring.call()

- 1、typeof:（可以对基本类型（包括 function）做出准确的判断，但对于引用类型，用它就有点力不从心了）
  - typeof 返回一个表示数据类型的字符串，返回结果包括：number、boolean、string、object、undefined、function、Symbol6 种数据类型。
  - 对于引用类型，返回的都是 object，其实返回 object 也没有错，因为所有对象的原型链最终都指向了 Object,Object 是所有对象的`祖宗`。 但当我们需要知道某个对象的具体类型时，typeof 就显得有些力不从心了。
  - 注意：typeof null 也是返回 object
- 2、instanceof

  - 判断对象和构造函数在原型链上是否有关系，如果有关系，返回真，否则返回假

- 3、Object.prototype.toString(可以说不管是什么类型，它都可以立即判断出)
  - toString 是 Object 原型对象上的一个方法，该方法默认返回其调用者的具体类型，更严格的讲，是 toString 运行时 this 指向的对象类型, 返回的类型
  - 格式为[object xxx],xxx 是具体的数据类型，其中包括：
  - String,Number,Boolean,Undefined,Null,Function,Date,Array,RegExp,Error,HTMLDocument,... 基本上所有对象的类型都可以通过这个方法获取到。

10.可能发生隐式类型转换的场景以及转换原则，应如何避免或巧妙应用

​ toSting（）Number（）“+” “==” “===” 等等

​ 详细参考：https://blog.csdn.net/seven_7d/article/details/88085423#JS_2

```js
let a = 1;
```
