## angular/cli

### ng

```bash
### 全局安装 angular
yarn global add @angular/cli

### 安装特定版本
yarn init
yarn add @angular/cli@6.1.8

###
ng help

ng new --help

### with ivy
ng new ng-ivy --enable-ivy=true --inline-style=true --minimal=true --routing=true --skip-install=true --skip-tests=true

### without ivy
ng new ng-demo --inline-style=true --minimal=true --routing=true --skip-install=true --skip-tests=true
```

### module

```bash
ng g m core

ng g m shared

ng g m routes --routing

### 使用 RoutesModule 替换默认生成的 AppRoutingModule

### 创建业务模块
ng g m routes/user-info --routing
```

### component

```bash
ng g c routes/user-info/user-name
```

### service

```bash
ng g s routes/user-info/user-info
```

## angular.json

---

## tslint

```bash
yarn add codelyzer -D
```

## tsconfig

### @xx

`tsconfig.json`

```json
compilerOptions: {
    "baseUrl": "src/",
    "paths": {
      "@shared": ["app/shared"],
      "@shared/*": ["app/shared/*"],
      "@env": ["environments"],
      "@env/*": ["environments/*"],
      "@core": ["app/core"],
      "@core/*": ["app/core/*"]
    }
}
```

`tsconfig.app.json`

```json
compilerOptions: {
    "paths": {
      "@shared": ["app/shared"],
      "@shared/*": ["app/shared/*"],
      "@env": ["environments"],
      "@env/*": ["environments/*"],
      "@core": ["app/core"],
      "@core/*": ["app/core/*"]
    }
}
```

## package.json

```json
  "scripts": {
    "ng": "ng",
    "start": "ng serve --port 8071",
    "build": "ng build --prod --build-optimizer"
  },
```

---

## AntDesign

```bash
ng add ng-zorro-antd
```

### material

<https://material.angular.cn/>

## BootStrap

<https://github.com/valor-software/ngx-bootstrap>

<https://valor-software.com/ngx-bootstrap/#/documentation#getting-started>

### 安装

```bash
yarn add ngx-bootstrap
yarn add bootstrap
```

### 引用

angular.json 中添加 css

`angular.json`

```json
            "styles": [
              "node_modules/bootstrap/dist/css/bootstrap.min.css",
              "src/styles.css"
            ],
```

### 使用

按需引用，使用哪个组件，在 module 中引入相应的模块并注册为根组件

`.module.ts`

```ts
import { TooltipModule } from "ngx-bootstrap";
import { ButtonsModule } from "ngx-bootstrap";

  imports: [
    TooltipModule.forRoot(),
    ButtonsModule.forRoot()
  ],
```

`.component.html`

```html
<button type="button" class="btn btn-primary" tooltip="Vivamus sagittis lacus vel augue laoreet rutrum faucibus.">
  Simple demo
</button>
```

---

## http

### `xmlHttpRequset`(`xhr`)

### `fetch()`

<https://developer.mozilla.org/zh-CN/docs/Web/API/Fetch_API/Using_Fetch>

`.service.ts`

```tsx
import { from } from "rxjs";

// GET
  fetch() {
    return from(
      fetch("http://117.73.12.207:3000/mock/52/users", {
        method: "GET",
        headers: {
          Au: "xx"
        }
      })
    );
  }

// POST
  fetchPut() {
    return from(
      fetch("http://117.73.12.207:3000/mock/52/user", {
        method: "PUT",
        headers: {
          Au: "xx",
          "Content-Type": "application/json"
        },
        body: JSON.stringify([
          {
            userName: "laboris aliquip",
            phone: "culpa aliqua voluptate"
          },
          {
            userName: "elit nisi sint culpa nostrud",
            phone: "consectetur non"
          },
          {
            userName: "sint",
            phone: "Excepteur aute"
          },
          {
            userName: "magna",
            phone: "non"
          }
        ])
      })
    );
  }
```

`.component.ts`

```ts
  fetch() {
    this.service.fetch().subscribe();
  }
```

> Q&A

<https://stackoverflow.com/questions/36292537/what-is-an-opaque-response-and-what-purpose-does-it-serve>

```json
'mode': 'no-cors'
```
