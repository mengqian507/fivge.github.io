---
title: SDN 综述
date: 2018-04-23 19:19:46
tags:
- SDN
categories:
- SDN
---

## 0x01 mininet

### 1.安装

```shell
git clone https://github.com/mininet/mininet.git
mininet/util/install.sh -n3V 2.7.0
mn --test pingall
```

### 2.文件结构

- bin/mm 主运行文件
- mininet/ 核心代码
- custom/  自定义Python文件
- util/ 辅助文件
- examples/ 案例

### 3.命令

> 网络构建启动参数

> > --topo



> > --custom

自定义拓扑

```shell
mn --custom topo-2sw-2host.py  --topo mytopo --controller=remote
```

<!--more-->

```python
"two switchs with three hosts"

from mininet.topo import Topo

class MyTopo( Topo ):
    "Simple topology example."

    def __init__( self ):
        "Create custom topo."

        # Initialize topology
        Topo.__init__( self )

        # Add hosts and switches
        host1 = self.addHost( 'h1' )
        host2 = self.addHost( 'h2' )
        host3 = self.addHost( 'h3' )
        switch1 = self.addSwitch( 's1' )
        switch2 = self.addSwitch( 's2' )

        # Add links
        self.addLink( host1, switch1 )
        self.addLink( host2, switch1 )
        self.addLink( host3, switch2 )
        self.addLink( switch1, switch2 )


topos = { 'mytopo': ( lambda: MyTopo() ) }
```



> > --switch



> > --controller



> > --mac

> 内部交互命令

- dump
- net
- nodes
- links
- dpctl
- iperf


- ...

![](http://ww4.sinaimg.cn/large/006tNc79ly1ffpni8jb0uj30iu0dzwfv.jpg)

![](http://ww3.sinaimg.cn/large/006tNc79ly1ffpnjbya6bj307h03h74c.jpg)

> 外部运行参数

> > -c
> >
> > -h

### 4.流表

> 查看流表

```shell
dpctl dump-flows ### 查看静态流表
```

> 添加流表

```shell
dpctl del-flows  ### 删除全部流表
### 使h1,h2之间ping通
dpctl add-flow in_port=1,actions=output:2
dpctl add-flow in_port=2,actions=output:1
```

> 删除流表

```shell
dpctl del-flows in_port=1
dpctl del-flows in_port=2    ### 删除1,2号端口的流表
# 或
sh ovs-ofctl del-fllows s1 in_port=2
```

> 添加丢弃数据包的流表

```bash
dpctl add-flow in_port=2,actions=drop  ### 交换机丢弃所有从2号端口发来的所有数据包
```

------

## 0x02 控制器

### 1. floodlight

> #### api
>
> <https://floodlight.atlassian.net/wiki/spaces/floodlightcontroller/pages/1343539/Floodlight+REST+API>

###### 准备

```bash
sudo apt install default-jdk
sudo apt install ant
```

###### 安装

```bash
git clone https://github.com/floodlight/floodlight.git
cd floodlight 
ant ### 初始化Java环境
java -jar target/floodlight.jar
mn --controller=remote
```

###### 错误解决

```bash
git pull origin master
git submodule init
git submodule update
```



<http://192.168.56.101:8080/ui/pages/index.html>

### 2. Ryu

> ryu
>
> <http://ryu-zhdoc.readthedocs.io/>
>
> <http://ryu-zhdoc.readthedocs.io/api_ref.html>
>
> <https://osrg.github.io/ryu/>

###### 1. 安装pip

```shell
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py
```

###### 2. 安装ryu

```shell
git clone git://github.com/osrg/ryu.git
cd ryu
pip install .
```

### 3. opendaylight

<http://www.sdnlab.com/1931.html>

###### 安装

<https://github.com/opendaylight/integration-distribution>

```shell
./bin/karaf
```



