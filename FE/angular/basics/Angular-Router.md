---
id: route
title: Angular Route
---

```ts
constructor(
  private route: ActivatedRoute,
  private router: Router
) {}

```

[下面是一些*路由器*中的关键词汇及其含义：](https://angular.cn/guide/router#summary)

| 路由器部件                         | 含义                                                                                                                               |
| :--------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| `Router`（路由器）                 | 为激活的 URL 显示应用组件。管理从一个组件到另一个组件的导航                                                                        |
| `RouterModule`                     | 一个独立的 NgModule，用于提供所需的服务提供商，以及用来在应用视图之间进行导航的指令。                                              |
| `Routes`（路由数组）               | 定义了一个路由数组，每一个都会把一个 URL 路径映射到一个组件。                                                                      |
| `Route`（路由）                    | 定义路由器该如何根据 URL 模式（pattern）来导航到组件。大多数路由都由路径和组件类构成。                                             |
| `RouterOutlet`（路由出口）         | 该指令（`<router-outlet>`）用来标记出路由器该在哪里显示视图。                                                                      |
| `RouterLink`（路由链接）           | 这个指令把可点击的 HTML 元素绑定到某个路由。点击带有 `routerLink` 指令（绑定到*字符串*或*链接参数数组*）的元素时就会触发一次导航。 |
| `RouterLinkActive`（活动路由链接） | 当 HTML 元素上或元素内的`routerLink`变为激活或非激活状态时，该指令为这个 HTML 元素添加或移除 CSS 类。                              |
| `ActivatedRoute`（激活的路由）     | 为每个路由组件提供的一个服务，它包含特定于路由的信息，比如路由参数、静态数据、解析数据、全局查询参数和全局碎片（fragment）。       |
| `RouterState`（路由器状态）        | 路由器的当前状态包含了一棵由程序中激活的路由构成的树。它包含一些用于遍历路由树的快捷方法。                                         |
| **\*链接参数数组\***               | 这个数组会被路由器解释成一个路由操作指南。你可以把一个`RouterLink`绑定到该数组，或者把它作为参数传给`Router.navigate`方法。        |
| **\*路由组件\***                   | 一个带有`RouterOutlet`的 Angular 组件，它根据路由器的导航来显示相应的视图。                                                        |

### route

> 激活的路由

```ts
this.route.snapshot.params["key"];

this.route.snapshot.paramMap.get("id");

// paramMap
// queryParamMap
// this.route.paramMap.get()
this.route.paramMap.subscribe(params => {
  // params.get()
  console.log(params);
});
```

| `has(name)`    | 如果参数名位于参数列表中，就返回 `true` 。                                                                                     |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `get(name)`    | 如果这个 map 中有参数名对应的参数值（字符串），就返回它，否则返回 `null`。如果参数值实际上是一个数组，就返回它的*第一个*元素。 |
| `getAll(name)` | 如果这个 map 中有参数名对应的值，就返回一个字符串数组，否则返回空数组。当一个参数名可能对应多个值的时候，请使用 `getAll`。     |
| `keys`         | 返回这个 map 中的所有参数名组成的字符串数组。                                                                                  |

### router

> 路由器

```ts
this.router.navigate(["/result/failure"], { foo: "Bob", bar: "Tom" });

this.router.navigate([{ foo: "Bob" }]);
```

### forRoot(routes)/forChild(routes)

> 根路由

模块懒加载：在根路由中配置

```ts
// angular 8+
const routes: Routes = [
  {
    path: "admin",
    loadChildren: () => import("./admin/admin.module").then(mod => mod.AdminModule)
  }
];
```

```ts
// angular 2~7
const routes: Routes = [
  {
    path: "route",
    loadChildren: "./route/route.module#RouteModule"
  }
];
```

并导入路由模块为根路由/子路由

```ts
  imports: [BrowserModule, RouterModule.forRoot(routes)],
```

路由器出口

```html
<router-outlet></router-outlet>
```

### location

```ts
import { Location } from '@angular/common';

    private location: Location

  back() {
    this.location.back();
  }
```

### 路由传参 TODO:

> /heroes/12138

> /heroes?id=12138

> /heroes:id=12138

> 隐式路由对象

从 routes 中获取路由参数

`instance-routing.module.ts`

```ts
  {
    path: "list",
    component: ListComponent,
    data: {
      code: "CBH",
      name: "云堡垒机"
    }
  }
```

`list.component.ts`

```ts
ngOnInit() {
    this.productCode = this.route.snapshot.data['code'];
    this.instanceName = this.route.snapshot.data['name'];
}
```

### 第二路由 TODO:
