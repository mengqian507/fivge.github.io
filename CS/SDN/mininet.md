---
title: mininet
date: 2018-04-16 20:34:11
tags:
- mininet
- SDN
categories:
- SDN
---

<http://192.168.56.101:8080/ui/pages/index.html>

```bash
### vim插入缩进问题
vim
:set paste
:set nopaste
```

<!--more-->

# mininet

### 0x01 自定义topo

```bash
mn --custom topo-2sw-2host.py  --topo mytopo --controller=remote
```

`topo1.py`

```python
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

`topo2.py`

```python
from mininet.topo import Topo

class MyTopo( Topo ):
    "Simple topology example."

    def __init__( self ):
        "Create custom topo."

        # Initialize topology
        Topo.__init__( self )

        # Add hosts and switches
        host1 = self.addHost( 'h1',mac='00:00:00:00:00:01',ip='10.0.0.1/8' )
        host2 = self.addHost( 'h2',mac='00:00:00:00:00:02',ip='10.0.0.2/8' )
        host3 = self.addHost( 'h3',mac='00:00:00:00:00:03',ip='10.0.0.3/8' )
        switch1 = self.addSwitch( 's1' )
        switch2 = self.addSwitch( 's2' )

        # Add links
        self.addLink( host1, switch1 )
        self.addLink( host2, switch1 )
        self.addLink( host3, switch2 )
        self.addLink( switch1, switch2 )


topos = { 'mytopo': ( lambda: MyTopo() ) }
```

`topo3.py`

```python
from mininet.topo import Topo

class MyTopo( Topo ):
    "Simple topology example."

    def __init__( self ):
        "Create custom topo."

        # Initialize topology
        Topo.__init__( self )

        # Add hosts and switches
        host1 = self.addHost( 'h1',mac='00:00:00:00:00:01',ip='10.0.0.1/8' )
        host2 = self.addHost( 'h2',mac='00:00:00:00:00:02',ip='10.0.0.2/8' )
        host3 = self.addHost( 'h3',mac='00:00:00:00:00:03',ip='10.0.0.3/8' )
        host4 = self.addHost( 'h4',mac='00:00:00:00:00:04',ip='10.0.0.4/8' )
        switch1 = self.addSwitch( 's1' )
        switch2 = self.addSwitch( 's2' )
        switch3 = self.addSwitch( 's3' )
        switch4 = self.addSwitch( 's4' )

        # Add links
        self.addLink( host1, switch1 )
        self.addLink( host2, switch1 )
        self.addLink( host3, switch4 )
        self.addLink( host4, switch4 )
        self.addLink( switch1, switch2 )
        self.addLink( switch1, switch3 )
        self.addLink( switch2, switch4 )
        self.addLink( switch3, switch4 )


topos = { 'mytopo': ( lambda: MyTopo() ) }
```

![](https://ws2.sinaimg.cn/large/006tNc79gy1fqi79qcyawj30fj0b83zw.jpg)

### 0x02 内部交互命令

![](https://ws3.sinaimg.cn/large/006tNc79gy1fqi8gp2ga3j30x60fb49i.jpg)

##### pingall

> Ping between all hosts.

##### net

##### dump

##### links

##### nodes

##### iperf

##### dpctl

> Run dpctl (or ovs-ofctl) command on all switches.
>
> ​           Usage: dpctl command \[arg1\]\[arg2\] ...

流表

> ###### 查看流表

```shell
dpctl dump-flows ### 查看静态流表
### 执行pingall后可看到全部流表信息
```

> ###### 添加流表

```shell
dpctl del-flows  ### 删除全部流表
### 使h1,h2之间ping通
dpctl add-flow in_port=1,actions=output:2
dpctl add-flow in_port=2,actions=output:1


dpctl add-flow in_port="s1-eth1",actions=output:"s1-eth2"
dpctl add-flow in_port="s1-eth2",actions=output:"s1-eth1"
```

> ###### 删除流表

```shell
dpctl del-flows in_port=1
dpctl del-flows in_port=2    ### 删除1,2号端口的流表
# 或
sh ovs-ofctl del-fllows s1 in_port=2
```

> ###### 添加丢弃数据包的流表

```bash
dpctl add-flow in_port=2,actions=drop  ### 交换机丢弃所有从2号端口发来的所有数据包
```





------

```http
mininet> dpctl dump-flows
*** s1 ------------------------------------------------------------------------
 cookie=0x20000082000000, duration=1.819s, table=0, n_packets=1, n_bytes=98, idle_timeout=5, priority=1,ip,in_port="s1-eth1",dl_src=00:00:00:00:00:01,dl_dst=00:00:00:00:00:02,nw_src=10.0.0.1,nw_dst=10.0.0.2 actions=output:"s1-eth2"
 cookie=0x20000083000000, duration=1.817s, table=0, n_packets=1, n_bytes=98, idle_timeout=5, priority=1,ip,in_port="s1-eth2",dl_src=00:00:00:00:00:02,dl_dst=00:00:00:00:00:01,nw_src=10.0.0.2,nw_dst=10.0.0.1 actions=output:"s1-eth1"
 cookie=0x20000084000000, duration=1.809s, table=0, n_packets=2, n_bytes=196, idle_timeout=5, priority=1,ip,in_port="s1-eth4",dl_src=00:00:00:00:00:03,dl_dst=00:00:00:00:00:01,nw_src=10.0.0.3,nw_dst=10.0.0.1 actions=output:"s1-eth1"
 cookie=0x20000085000000, duration=1.798s, table=0, n_packets=2, n_bytes=196, idle_timeout=5, priority=1,ip,in_port="s1-eth4",dl_src=00:00:00:00:00:04,dl_dst=00:00:00:00:00:01,nw_src=10.0.0.4,nw_dst=10.0.0.1 actions=output:"s1-eth1"
 cookie=0x20000086000000, duration=1.786s, table=0, n_packets=2, n_bytes=196, idle_timeout=5, priority=1,ip,in_port="s1-eth4",dl_src=00:00:00:00:00:03,dl_dst=00:00:00:00:00:02,nw_src=10.0.0.3,nw_dst=10.0.0.2 actions=output:"s1-eth2"
 cookie=0x20000087000000, duration=1.777s, table=0, n_packets=2, n_bytes=196, idle_timeout=5, priority=1,ip,in_port="s1-eth4",dl_src=00:00:00:00:00:04,dl_dst=00:00:00:00:00:02,nw_src=10.0.0.4,nw_dst=10.0.0.2 actions=output:"s1-eth2"
 cookie=0x0, duration=800.199s, table=0, n_packets=728, n_bytes=66394, priority=0 actions=CONTROLLER:65535
*** s2 ------------------------------------------------------------------------
 cookie=0x0, duration=800.210s, table=0, n_packets=725, n_bytes=67584, priority=0 actions=CONTROLLER:65535
*** s3 ------------------------------------------------------------------------
 cookie=0x20000084000000, duration=1.822s, table=0, n_packets=3, n_bytes=294, idle_timeout=5, priority=1,ip,in_port="s3-eth2",dl_src=00:00:00:00:00:03,dl_dst=00:00:00:00:00:01,nw_src=10.0.0.3,nw_dst=10.0.0.1 actions=output:"s3-eth1"
 cookie=0x20000085000000, duration=1.812s, table=0, n_packets=3, n_bytes=294, idle_timeout=5, priority=1,ip,in_port="s3-eth2",dl_src=00:00:00:00:00:04,dl_dst=00:00:00:00:00:01,nw_src=10.0.0.4,nw_dst=10.0.0.1 actions=output:"s3-eth1"
 cookie=0x20000086000000, duration=1.797s, table=0, n_packets=2, n_bytes=196, idle_timeout=5, priority=1,ip,in_port="s3-eth2",dl_src=00:00:00:00:00:03,dl_dst=00:00:00:00:00:02,nw_src=10.0.0.3,nw_dst=10.0.0.2 actions=output:"s3-eth1"
 cookie=0x20000087000000, duration=1.789s, table=0, n_packets=2, n_bytes=196, idle_timeout=5, priority=1,ip,in_port="s3-eth2",dl_src=00:00:00:00:00:04,dl_dst=00:00:00:00:00:02,nw_src=10.0.0.4,nw_dst=10.0.0.2 actions=output:"s3-eth1"
 cookie=0x0, duration=800.243s, table=0, n_packets=622, n_bytes=55975, priority=0 actions=CONTROLLER:65535
*** s4 ------------------------------------------------------------------------
 cookie=0x20000084000000, duration=1.828s, table=0, n_packets=1, n_bytes=98, idle_timeout=5, priority=1,ip,in_port="s4-eth1",dl_src=00:00:00:00:00:03,dl_dst=00:00:00:00:00:01,nw_src=10.0.0.3,nw_dst=10.0.0.1 actions=output:"s4-eth4"
 cookie=0x20000085000000, duration=1.816s, table=0, n_packets=1, n_bytes=98, idle_timeout=5, priority=1,ip,in_port="s4-eth2",dl_src=00:00:00:00:00:04,dl_dst=00:00:00:00:00:01,nw_src=10.0.0.4,nw_dst=10.0.0.1 actions=output:"s4-eth4"
 cookie=0x20000086000000, duration=1.801s, table=0, n_packets=1, n_bytes=98, idle_timeout=5, priority=1,ip,in_port="s4-eth1",dl_src=00:00:00:00:00:03,dl_dst=00:00:00:00:00:02,nw_src=10.0.0.3,nw_dst=10.0.0.2 actions=output:"s4-eth4"
 cookie=0x20000087000000, duration=1.794s, table=0, n_packets=1, n_bytes=98, idle_timeout=5, priority=1,ip,in_port="s4-eth2",dl_src=00:00:00:00:00:04,dl_dst=00:00:00:00:00:02,nw_src=10.0.0.4,nw_dst=10.0.0.2 actions=output:"s4-eth4"
 cookie=0x0, duration=800.226s, table=0, n_packets=738, n_bytes=67102, priority=0 actions=CONTROLLER:65535
```

### 清除缓存

```bash
sudo mn -c
```

