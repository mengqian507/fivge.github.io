## http

### `xmlHttpRequset`(`xhr`)

<https://angular.cn/guide/http>

要想使用 `HttpClient`，就要先导入 Angular 的 `HttpClientModule`。大多数应用都会在根模块 `AppModule` 中导入它。

```typescript
import { HttpClientModule } from "@angular/common/http";

@NgModule({
  imports: [
    BrowserModule,
    // import HttpClientModule after BrowserModule.
    HttpClientModule
  ]
})
export class AppModule {}
```

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
