### 原理

- [x] cookie-httpOnly

- [x] Expires/Max-Age

  > expires 参数是当年网景公司推出 Cookies 原有的一部分。在 HTTP1.1 中，expires 被弃用并且被更加易用的 max-age 所替代。你只需说明这个 Cookie 能够存活多久就可以了，而不用像之前那样指定一个日期。设置二者中的一个，Cookie 会在它过期前一直保存，如果你一个都没有设置，这个 Cookie 将会一直存在直到你关闭浏览器，这种称之为 Session Cookie。

[Http Cookies 中 Max-age 和 Expires 有什么区别？](https://jpanj.com/2017/cookies-max-age-vs-expires)

### 应用

#### npm 包

[CookieService](https://www.npmjs.com/package/ngx-cookie-service)
