#### CI/CD

![](https://raw.githubusercontent.com/fivge/hexo-pic/master/2019/1_YP1_fPxkfvqFEnI3Vo6JHw.png)

#### angular-cli

![](https://raw.githubusercontent.com/fivge/hexo-pic/master/2019/1_uUDKPGTkeNLHqqZ9WQhacw.png)

#### hot replace

在 `app.module` 通过 `DoBootstrap` 钩子，加载环境变量

```typescript
@NgModule({
  declarations: [AppComponent],
  //...
  entryComponents: [AppComponent]
})
export class AppModule implements DoBootstrap {

  ngDoBootstrap(appRef: ApplicationRef) {
    fetch('assets/config/environment.json', {
      method: 'GET'
    })
      .then(next => next.json())
      .then(next => (environment.application = next))
      .then(next =>
       // ...
       appRef.bootstrap(AppComponent);
      );
  }
}
```

---

#### ref

[Handling Angular environments in continuous delivery](https://blog.angularindepth.com/handling-angular-environments-in-continuous-delivery-eeaee96f0aae)
