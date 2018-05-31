# General Packet Exchanges for QUIC Toy Server and Client
![package_exchanges1](https://raw.githubusercontent.com/sanadhis/quic-eval/master/report/packetexchanges/img/QUICChromium_Normal-Request.png)

How to reproduce the packets on Wireshark (almost) similar to the graph:
<br>Client
```bash
./quic_client \
    --quic-version=41 \
    --host=127.0.0.1 --port=6121 \
    https://www.example.org/index.html --v=2
```
<br>Server
```bash
./quic_server \
    --quic_response_cache_dir=/tmp/quic-data/ \
    --certificate_file=net/tools/quic/certs/out/leaf_cert.pem \
    --key_file=net/tools/quic/certs/out/leaf_cert.pkcs8 --v=2
```

**Disclaimer**
1. Packet 4,5 are optional. By default the client will try to verify the server's credibility. The first ack (packet 3) is sent to indicate that the client has successfully acknowledged the trust for the given origin.
2. Packet 3 is the continuation for the packet 2. We can avoid this packet to be sent by increasing the initial_mtu when executing the client (see next graph and explanation).
3. Some random delay in both client and server may change the order of the certain packets, especially the 10th packet onward. The delay may be caused by some verbose logging that either client or server applies.

# 0-RTT Test QUIC Toy Server and Google Chrome
![package_exchanges2](https://raw.githubusercontent.com/sanadhis/quic-eval/master/report/packetexchanges/img/ChromeSubsequentRequest_0-RTT.png)

How to reproduce the packets on Wireshark (almost) similar to the graph:
<br>Client (Google Chrome) (Repeat and observe the 2nd request to the same server)
```bash
chrome \
    --user-data-dir=/tmp/chrome-profile \
    --no-proxy-server --enable-quic --origin-to-force-quic-on=www.example.org:443 \
    --host-resolver-rules='MAP www.example.org:443 127.0.0.1:6121' \
    https://www.example.org/index.html --v=2
```
<br>Server
```bash
./quic_server \
    --quic_response_cache_dir=/tmp/quic-data/ \
    --certificate_file=net/tools/quic/certs/out/leaf_cert.pem \
    --key_file=net/tools/quic/certs/out/leaf_cert.pkcs8 --v=2
```

**Disclaimer**
1. Again, some random delay in both client and server may change the order of the certain packets, especially the 5th packet onward.

# Reducing Packets and Disabling Logging in Both Sides
![package_exchanges3](https://raw.githubusercontent.com/sanadhis/quic-eval/master/report/packetexchanges/img/QUICChromium_Normal_Request_reducedpacket.png)

How to reproduce the packets on Wireshark (almost) similar to the graph:
<br>Client (now disable certificate validation and set the initial mtu)
```bash
./quic_client \
    --quic-version=41 \
    --host=127.0.0.1 --port=6121 \
    https://www.example.org/index.html \
    --disable-certificate-verification \
    --initial_mtu=1500
```
<br>Server
```bash
./quic_server \
    --quic_response_cache_dir=/tmp/quic-data/ \
    --certificate_file=net/tools/quic/certs/out/leaf_cert.pem \
    --key_file=net/tools/quic/certs/out/leaf_cert.pkcs8
```

**Disclaimer**
1. Now you can see packet exchanges close to the theory.
