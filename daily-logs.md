# Working Log
[Mon Feb 19 11:55:57 CET 2018] Finished reading three papers, start to seek for codes (especially in terms of implementations) and another references. Initiated the repository and wrote some summary from the papers.

[Fri Feb 23 16:58:34 CET 2018] Attempted to build chromium project, facing problem with Xcode license agreement. Attempted to build go-based quic by [lucas-clemente](https://github.com/lucas-clemente/quic-go), but to no avail because of go-mac problem.

[Sun Feb 25 19:50:23 CET 2018] Successfully built toy quic_server and quic_client from chromium project, but could not make the client get HTTP 200 response. Still stuck with go package environment.

[Mon Feb 26 11:11:37 CET 2018] Successfully made client to get 200 HTTP request. Decided not to go further with go implementation of QUIC. Migrating work to ubuntu virtual machine and trying [google/proto-quic](https://github.com/google/proto-quic).

[Thu Mar  1 21:38:19 CET 2018] Setting environment for shared project directory between host (MacOSX) and guest (Ubuntu) OS, tried to getting used to chromium project.

[Fri Mar  2 15:00:19 CET 2018] Evaluated several crashes when performing `gclient sync`: (1) Need more CPU & RAM, (2) need more space, (3) download should not be interrupted.

[Sun Mar  4 16:53:12 CET 2018] Wrap-up problems: (1) Virtual Box does not support symlink in shared dir (solved); (2) Hardlinks cannot be performed between different partition files (unsolved). Solution: going manual with `/net/tools/quic` dir. Started to inspect the code.

[Fri Mar  9 14:49:40 CET 2018] Getting used to gn and ninja, build and link customized QUIC toy client and server.

[Sat Mar 10 13:39:13 CET 2018] Creating test scripts for multiple concurrent requests to QUIC toy server.

[Sat Mar 10 20:24:55 CET 2018] Attempting to modify QUIC client to use persistent connection. Currently, it is known that QUIC always close the UDP socket at the end of request. QUIC send FIN=true flag when making the request.

[Fri Mar 16 18:00:00 CET 2018] Created two QUIC client: A persistent client and a client with multiple connections. Captured the traffic with wireshark but did not find a way to decrypt the traffic.

[Tue Mar 20 11:02:45 CET 2018] Inspected the log of QUIC client and figured out that the cause of CHLO (Client Hello) rejection was because of QUIC versioning mismatch between client and server. By default, client use the latest one (99) while server implements v41. To overcome this, pass: `--quic-version=41` **(with dash instead of underscore)** when executing the client.

[Mon Apr  2 22:02:26 CEST 2018] Trying two approaches for investigating QUIC traffic: (1) Making log more verbose -> Successfully discover streams' creations in detail. (2) Wireshark 2.5.2 with decryption for [QUIC IETF](https://github.com/ngtcp2/ngtcp2), details [here](https://github.com/ngtcp2/ngtcp2/pull/67).

[Thu Apr  5 21:36:50 CEST 2018] Cannot extract key from decrypter->getKey(). QuicStringPiece returns non-standard hex leads to non-ASCII characters. Trying to make the log of stream data more verbose.

[Fri Apr  6 15:42:42 CEST 2018] Done trying approach [here](https://github.com/ngtcp2/ngtcp2/pull/67), cannot be implemented to QUIC's toy server and client because: (1) This only works for IETF definition of SH (short header) packets. (2) Works with TLS1.3 from patched OpenSSL, while QUIC toy server and client implement their own TLS cryptographic handshake.

[Fri Apr 13 21:50:04 CEST 2018] Exploring [QUIC IETF Implementation](https://github.com/ngtcp2/ngtcp2) and discovering: (1) Repository is relatively small, but there is dependency to [OpenSSL](https://github.com/openssl/openssl). (2) Tried resumption (resuming QUIC's connection session), this reduces initial handshake's packet size. (3) Attempted HTTP request-response over QUIC, unlike Google's QUIC toy server and client, this emphasizes the properties of QUIC as transport-layer protocol. (4) However, it is unstable and Wireshark cannot decrypt the latest version (commit) of QUIC IETF packets, which suppose to work perfectly fine starting from [this commit](https://github.com/ngtcp2/ngtcp2/commit/7c9fbb411597e9484a7a73f274d351bce8feaca8).

[Sun Apr 15 23:06:21 CEST 2018] Inspecting `examples/client.cc` code and manipulating stream sending procedure. In this project, the example QUIC client can send multiple request over same stream but there is a need to modify server code to accept request over same stream and give response in accordance.

[Tue Apr 17 11:22:40 CEST 2018] Manipulated QUIC IETF's client and server code: (1) Multiple request over same streams on Client & (2) Multiple request over multiple streams on Client (3) Making server's logs more verbose. [Code](https://github.com/sanadhis/ngtcp2)

[Fri Apr 20 19:58:05 CEST 2018] (1) Explored about QUIC IETF/ngtcp2's congestion control. The congestion control is initiated roughly from this [point](https://github.com/ngtcp2/ngtcp2/commit/af477fad36887239f90b9822ae773ef5f4706b42), which was later commit from support to wireshark decryption. However it was still immature implementation and has been constantly revised until now. The update to draft-10 tls changes causes decryption method to no avail, latest supported commit with decryption is [here](https://github.com/ngtcp2/ngtcp2/commit/7efa8562dda26a40e3e4624c538699b64a00234e). (2) Attempted to try [picoquic](https://github.com/private-octopus/picoquic), which is another implementation of QUIC IETF. [picoquic](https://github.com/private-octopus/picoquic) is implemented by [Christian Huitema](https://github.com/huitema?tab=repositories) and has yet implemented congestion control. But it has no documentation at all and does not really mechanism to support encryption to wireshark. Information about [QUIC IETF](https://github.com/quicwg/base-drafts/wiki) and its [implementations](https://github.com/quicwg/base-drafts/wiki/Implementations).