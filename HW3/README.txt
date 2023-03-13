Task 1
mininet> h1 ping h8

64 bytes from 10.0.0.8: icmp_seq=1 ttl= time=42.1
64 bytes from 10.0.0.8: icmp_seq=2 ttl= time=6.01
64 bytes from 10.0.0.8: icmp_seq=3 ttl= time=0.987
64 bytes from 10.0.0.8: icmp_seq=4 ttl= time=0.912
64 bytes from 10.0.0.8: icmp_seq=5 ttl= time=0.955
64 bytes from 10.0.0.8: icmp_seq=6 ttl= time=0.881
64 bytes from 10.0.0.8: icmp_seq=7 ttl= time=0.702
64 bytes from 10.0.0.8: icmp_seq=8 ttl= time=0.909
64 bytes from 10.0.0.8: icmp_seq=9 ttl= time=0.395

Ans 1) 
Output of nodes: 
mininet> nodes
available nodes are: 
c0 h1 h2 h3 h4 h5 h6 h7 h8 s1 s2 s3 s4 s5 s6 s7

Output of net:
mininet> net
h1 h1-eth0:s3-eth2
h2 h2-eth0:s3-eth3
h3 h3-eth0:s4-eth2
h4 h4-eth0:s3-eth3
h5 h5-eth0:s6-eth2
h6 h6-eth0:s6-eth3
h7 h7-eth0:s7-eth2
h8 h8-eth0:s7-eth3
s1 lo:  s1-eth1:s2-eth1 s1-eth2:s5-eth1
s2 lo:  s2-eth1:s1-eth1 s2-eth2:s3-eth1 s2-eth3:s4-eth1
s3 lo:  s3-eth1:s2-eth2 s3-eth2:h1-eth0 s3-eth3:h2-eth0 
s4 lo:  s4-eth1:s2-eth3 s4-eth2:h3-eth0 s4-eth3:h4-eth0
s5 lo:  s5-eth1:s1-eth2 s5-eth2:s6-eth1 s5-eth3:s7-eth1
s6 lo:  s6-eth1:s5-eth2 s6-eth2:h5-eth0 s6-eth3:h6-eth0
s7 lo:  s7-eth1:s5-eth3 s7-eth2:h7-eth0 s7-eth3:h8-eth0
c0

Ans 2)
Output of h7 ifconfig
mininet> h7 ifconfig
h7-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.7  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::8062:fdff:fe22:c578  prefixlen 64  scopeid 0x20<link>
        ether 82:62:fd:22:c5:78  txqueuelen 1000  (Ethernet)
        RX packets 46  bytes 3212 (3.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 13  bytes 1006 (1kB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


Task 2

Ans 1) When the packet comes the order of function execution is 
_handle_PacketIn() 
act_like_hub() 
resend_packet() 
send message to the port

Ans 2)
- 10.0.0.2 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 99417ms
rtt min/avg/max/mdev = 0.2333/1.187/43.948/4.348 ms

--- 10.0.0.8 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 99523ms
rtt min/avg/max/mdev = 0.258/2.220/88.327/9.847 ms


a) 
It takes average 1.187ms to ping h1 to h2
It takes average 2.220ms to ping h1 to h8

b) 
Minimum ping from h1 and h2 - 0.2333
Minimum ping from h1 and h8 - 0.258
Maximum ping from h1 and h2 - 43.948
Maximum ping from h1 and h8 - 88.327

c) The time to ping between h1 and h2 is less as it has to switch only once. 
In contrast, the ping between h1 and h8 is higher because it has to make multiple switches i.e from s3->s2->s1->s5->s7. 


Ans 3)

a) IPERF is a tool used to measure network bandwith such that it creates TCP and UDP data streams to measure the throughput of the network carrying it. It also has various parameters used to tune network or optimzation.

b) 
mininet> iperf h1 h2
*** Iperf: testing TCP bandwidth between h1 and h2 
*** Results: ['1.33 Gbits/sec', '1.33 Gbits/sec']

mininet> iperf h1 h8
*** Iperf: testing TCP bandwidth between h1 and h8 
*** Results: ['1.14 Gbits/sec', '2.07 Gbits/sec']

c) As explained above due to higher number of switches between h1 and h8 it takes more time to send message from either side of host as compared to h1->h2 which has just one switch between them. 
Hence higher the time lesser is throughput. Thus h1->h2 has higher thoughput than h1->h8.

Ans 4) 
Once we add the log.info("Traffic info %s" % (self.connection) in the line number 95 "of_tutorial") controller and run the file we will get all the information about network traffic. 
From the result we can clearly say that all the switches receives the traffic as the message from h1->h8 passes through all the switch nodes.


Task 3
Ans 1)
When the packet arrives, the code first checks for the port associated with the MAC address of incoming packet. It checks in the dictionary it created i.e `mac_to_port`. If the the dictionary does not have the 
MAC address and its associated key, it adds the MAC address and key. 
If the source MAC address is already present in dictionary, then it simply passes the packet to port associated with this MAC address using resend_packet() function. If the MAC key exist but the port is unknown
it floods out the packets to all ports using OFPP_ALL flag.

Ans 2)

a)
--- 10.0.0.2 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 99532ms
rtt min/avg/max/mdev = 0.1526/2.015/47.157/4.679 ms

--- 10.0.0.8 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 99657ms
rtt min/avg/max/mdev = 0.437/3.715/82.157/7.243 ms


It takes average 2.015 to ping h1 to h2
It takes average 3.715 to ping h1 to h8

b) 
Minimum ping from h1 and h2 - 0.1526
Minimum ping from h1 and h8 - 0.437
Maximum ping from h1 and h2 - 47.157
Maximum ping from h1 and h8 - 82.157

c) From the above experimental results we can say thatm when controller are introduce it perfoms worse compared to normal hubs as controller creates the forwading rule which takes some time and hence pings are slower in Task 3

Ans 3)
a)
mininet> iperf h1 h2
*** Iperf: testing TCP bandwidth between h1 and h2 
*** Results: ['1.89 Gbits/sec', '1.87 Gbits/sec']

mininet> iperf h1 h8
*** Iperf: testing TCP bandwidth between h1 and h8 
*** Results: ['1.21 Gbits/sec', '2.35 Gbits/sec']


b) 
In the MAC learning controller approach, it initially creates dictionary (mac_to_port) for the new arriving packets. This take some time initially as it has perform checks and add the key and value.
Hence we get lower throughput in task 3 as compared to task 2