---
id: uuid
title: uuid
---

### Install

```bash
yarn add uuid
yarn add @types/uuid --dev
```

### Use

```ts
import * as uuid from 'uuid/v4';

  /** 生成 uuid */
  public uuid(): string {
    return uuid();
  }
```
