---
title: FloodLightApi
date: 2018-04-19 16:03:02
tags:
- FloodLight
- SDN
categories:
- SDN
---

```bash
curl -X POST -d '{}' http://192.168.56.101:8080/
curl -X DELETE -d '{}' http://192.168.56.101:8080/

curl -X GET  http://192.168.56.101:8080/wm/device/

curl -X GET -d '{"src-switch"}' http://192.168.56.101:8080/wm/topology/links/json

"src-switch":"00:00:00:00:00:00:00:03","src-port":2,"dst-switch":"00:00:00:00:00:00:00:04","dst-port":4,"type":"internal","direction":"bidirectional","latency":3
```

### 获取设备信息

```bash
curl -X GET  http://192.168.56.101:8080/wm/device/ > device.json  ### 获取设备信息

curl -X GET  http://192.168.56.101:8080/wm/core/controller/switches/json > switches.json   ### 获取交换机信息

curl -X GET  http://192.168.56.101:8080/wm/core/controller/summary/json > summary.json ### 获取概要信息,交换机数量等

curl -X GET  http://192.168.56.101:8080/wm/topology/links/json > links.json   ### 链路连接信息
```

### 查看流表

```bash
curl -X GET  http://192.168.56.101:8080/wm/staticflowpusher/list/all/json
```



### 下发流表

```bash
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"flow-mod-1", "cookie":"0", "priority":"32768", "in_port":"1","active":"true", "actions":"output=2"}' http://192.168.56.101:8080/wm/staticentrypusher/json

curl -X POST -d '{"switch":"00:00:00:00:00:00:00:02", "name":"flow-mod-2", "cookie":"0", "priority":"32768", "in_port":"1","active":"true", "actions":"output=2"}' http://192.168.56.101:8080/wm/staticflowpusher/json

# TCP | UDP -> 0x06 | 0x11
### {TCP,h1,22}
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"deny-tcp-22","priority":"30022","eth_type":"0x0800","ipv4_src":"10.0.0.1","ipv4_dst":"10.0.0.3","ip_proto":"0x06","tp_dst":"22","actions":"drop"}' http://192.168.56.101:8080/wm/staticflowpusher/json
### {UDP,h2,123}
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:01", "name":"deny-udp-123","priority":"30123","eth_type":"0x0800","ipv4_src":"10.0.0.2","ipv4_dst":"10.0.0.3","ip_proto":"0x11","tp_dst":"123","actions":"drop"}' http://192.168.56.101:8080/wm/staticflowpusher/json
```

### 组表

```bash
curl -X POST -d '{"switch":"00:00:00:00:00:00:00:03", "entry_type":"group", "name":"group-mod-3", "active":"true", "group_type":"select", "group_id":"3",  "group_buckets":[ {"bucket_id":"1", "bucket_watch_group":"any", "bucket_weight":"50", "bucket_actions":"output=2"}, {"bucket_id":"2", "bucket_watch_group":"any", "bucket_weight":"50", "bucket_actions":"output=3"} ]}' http://192.168.56.101:8080/wm/staticflowpusher/json
```

### 删除流表

```bash
curl -X DELETE -d '{"name":"flow-mod-2"}'  http://192.168.56.101:8080/wm/staticflowpusher/json 
### TCP
curl -X DELETE -d '{"name":"deny-tcp-22"}' http://localhost:8080/wm/staticflowpusher/json 
### UDP 
curl -X DELETE -d '{"name":"deny-udp-123"}' http://localhost:8080/wm/staticflowpusher/json 
```

### meter

<https://floodlight.atlassian.net/wiki/spaces/floodlightcontroller/pages/15040523/How+to+Use+OpenFlow+Meters>



<https://floodlight.atlassian.net/wiki/spaces/floodlightcontroller/pages/21856267/How+to+Collect+Switch+Statistics+and+Compute+Bandwidth+Utilization#HowtoCollectSwitchStatistics(andComputeBandwidthUtilization)-Startupconfiguration>



<http://www.cnblogs.com/CasonChan/p/4623931.html>



**<https://www.sdnlab.com/16892.html>**



### http

| 方法    | 描述                                              |
| ------- | ------------------------------------------------- |
| HEAD    | 与 GET 相同，但只返回 HTTP 报头，不返回文档主体。 |
| PUT     | 上传指定的 URI 表示。                             |
| DELETE  | 删除指定资源。                                    |
| OPTIONS | 返回服务器支持的 HTTP 方法。                      |
| CONNECT | 把请求连接转换到透明的 TCP/IP 通道。              |
| GET     | 从指定的资源请求数据                              |
| POST    | 向指定的资源提交要被处理的数据                    |

<!--more-->

# Floodlight REST API

[Mar 14, 2018]() 

<https://floodlight.atlassian.net/wiki/spaces/floodlightcontroller/pages/1343539/Floodlight+REST+API>

- [ ] 0x01  Controller APIs
- [ ] 0x02  Role(HA) APIs
- [ ] 0x03  Role (Switch) APIs
- [ ] 0x04  OpenFlow Stats/Multipart APIs
- [ ] 0x05  Statistics APIs
- [ ] 0x06  Topology and Routing APIs
- [x] 0x07  Device APIs
- [x] 0x08  Static Entry Pusher APIs
- [ ] 0x09  Virtual Network Filter APIs
- [ ] 0x0A  Firewall APIs
- [ ] 0x0B  Access Control List APIs
- [ ] 0x0C  Controller Performance APIs

### 0x07 Device APIs

| URI         | Method | Description                                                  | Arguments                                                    | Controller Version |
| ----------- | ------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------ |
| /wm/device/ | GET    | List of all devices tracked by the controller. This includes MACs, IPs, and attachment points | Passed as GET parameters: **mac** (colon-separated hex-encoded), **ipv4** (dotted decimal), **vlan**, **dpid** attachment point DPID (colon-separated hex-encoded) and **port** the attachment point port. | all                |

### 0x08 Static Entry Pusher APIs

> 流量控制
>
> allows a user to manually insert flows and groups into an OpenFlow network
>
> 

| URI                                      | Method      | Description                                     | Arguments                                                    | Controller Version |
| ---------------------------------------- | ----------- | ----------------------------------------------- | ------------------------------------------------------------ | ------------------ |
| /wm/staticflowpusher/json                | POST/DELETE | Add/Delete static flow                          | HTTP POST data (add flow), HTTP DELETE (for deletion)        | all                |
| /wm/staticflowpusher/list/<switch>/json  | GET         | List static flows for a switch or all switches  | **switch**: Valid Switch DPID (XX:XX:XX:XX:XX:XX:XX:XX) or "all" | all                |
| /wm/staticflowpusher/clear/<switch>/json | GET         | Clear static flows for a switch or all switches | **switch**: Valid Switch DPID (XX:XX:XX:XX:XX:XX:XX:XX) or "all" | all                |

More information available on [How to Use Static Flow Pusher API](https://floodlight.atlassian.net/wiki/spaces/floodlightcontroller/pages/1343518/Static+Entry+Pusher+API)

------

### 0x01 Controller APIs

### 0x02 Role(HA) APIs

### 0x03 Role (Switch) APIs

### 0x04 OpenFlow Stats/Multipart APIs

### 0x05 Statistics APIs

### 0x06 Topology and Routing APIs

### 0x09 Virtual Network Filter APIs

### 0x0A Firewall APIs

### 0x0B Access Control List APIs

### 0x0C Controller Performance APIs















| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

| URI  | Method | Description | Arguments | Controller Version |
| ---- | ------ | ----------- | --------- | ------------------ |
|      |        |             |           |                    |

