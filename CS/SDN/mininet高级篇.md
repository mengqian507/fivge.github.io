---
title: mininet高级篇
date: 2018-05-14 22:45:58
tags:
- mininet
- SDN
categories:
- SDN
---

### mininet



`self.addLink( node1, node2, bw=10, delay='5ms', max_queue_size=1000, loss=10, use_htb=True)`: adds a bidirectional link with bandwidth, delay and loss characteristics, with a maximum queue size of 1000 packets using the Hierarchical Token Bucket rate limiter and netem delay/loss emulator. The parameter `bw` is expressed as a number in Mbit; `delay` is expressed as a string with units in place (e.g. '5ms', '100us', '1s'); `loss` is expressed as a percentage (between 0 and 100); and `max_queue_size` is expressed in packets.

<!--more-->

You may find it useful to create a Python dictionary to make it easy to pass the same parameters into multiple method calls, for example:

```py
     linkopts = dict(bw=10, delay='5ms', loss=10, max_queue_size=1000, use_htb=True)
     # (or you can use brace syntax: linkopts = {'bw':10, 'delay':'5ms', ... } )
     self.addLink(node1, node2, **linkopts)
     
     带宽bw、延迟delay、最大队列的大小max_queue_size、损耗率loss
```

This same technique `(**dict)` is useful for passing options to Matplotlib and other libraries.

`net.get()`: retrieves a node (host or switch) object by name. This is important if you want to send a command to a host (e.g. using `host.cmd()`) and get its output.

Note: In the current master branch of Mininet, you can simply use braces (e.g. `net['h1']`) to retrieve a given node by name.



```
实验中设定叶节点交换机带宽为200 MB/s，核心交换机带宽为 1 GB / s，交换机转发阈值上限缺省值为60%;链路带宽为100 MB/s，核心层到汇聚层链路最 大负载缺省值为 70% ，汇聚层到边缘层链路最大负载 缺省值为 60% ; 
```

```
核心
1G
70%
汇聚
200M
60%
边缘
100M
60%
主机
```

