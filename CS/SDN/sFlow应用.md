---
title: sFlow 应用
date: 2018-05-25 21:21:12
tags:
- sFlow
- SDN
categories:
- SDN
---



<!--more-->

> ### Mininet flow analytics
>
> Mininet 流量分析
>
> 
>
> <https://blog.sflow.com/2016/05/mininet-flow-analytics.html>

> mininet dashboard
>
> https://blog.sflow.com/2016/05/mininet-dashboard.html
>
> https://github.com/sflow-rt/mininet-dashboard

### sflow

sFlow流量监控之DDoS防御

https://www.sdnlab.com/sflow-ddos/

http://www.qingpingshan.com/pc/aq/231452.html

基于Mininet的网络流量监控

https://www.sdnlab.com/3760.html



https://sflow.org/using_sflow/index.php

https://blog.sflow.com

https://sflow.org/using_sflow/index.php

 [【Mininet 流量分析工具 — 使用 sFlow-RT】](https://ting-kuan.blog/2018/05/08/%e3%80%90mininet-%e6%b5%81%e9%87%8f%e5%88%86%e6%9e%90%e5%b7%a5%e5%85%b7-%e4%bd%bf%e7%94%a8-sflow-rt%e3%80%91/)

##### 泛洪

```bash
h1 ping -f h2

iperf -s

while true; do iperf -c 10.0.0.2 -t 30; sleep 30; done
```

### sFlow-RT

<https://sflow-rt.com/download.php>



#### Mininet Dashboard

<https://github.com/sflow-rt/mininet-dashboard>

[Mininet flow analytics](https://blog.sflow.com/2016/05/mininet-flow-analytics.html)

```bash
sudo pip install requests
```

> 国内镜像源
>
> <https://mirrors.tuna.tsinghua.edu.cn/help/pypi/>

```bash
sudo mn --custom sflow.py,FatTree/fattree1.py --link tc,bw=10 --topo mytopo --controller=remote
```

##### REST API

```shell
# Latest Values
curl -X GET http://192.168.56.101:8008/app/mininet-dashboard/scripts/metrics.js/metric/json
# Trends
curl -X GET http://192.168.56.101:8008/app/mininet-dashboard/scripts/metrics.js/trend/json
# Topology
curl -X GET http://192.168.56.101:8008/topology/json
```



---

### 其他应用

<http://liushy.com/2015/01/27/sflow-ddos/>

