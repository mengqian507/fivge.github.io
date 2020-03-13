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

### `websocket`

`.service.ts`

```typescript
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";

@Injectable({
  providedIn: "root"
})
export class WebSocketService {
  ws: WebSocket;
  private wsUrl: string = `ws:localhost:8081`;

  createObservableSocket(): Observable<any> {
    this.ws = new WebSocket(this.wsUrl);

    return new Observable(observe => {
      this.ws.onmessage = event => observe.next(event.data);
      this.ws.onerror = event => observe.error();
      this.ws.onclose = event => observe.complete();
    });
  }

  sendMessage(message: string) {
    this.ws.send(message);
  }
}
```

`.component.ts`

```typescript
  constructor(private ws: WebSocketService) {}

  sendMessageToServer() {
    this.ws.sendMessage(`send message form angular to express ws server`);
  }

  ngOnInit() {
    this.ws.createObservableSocket().subscribe(
        data => console.log(data),
        err => console.log(err),
        () => console.log("ws has ended!")
      );
  }
```
