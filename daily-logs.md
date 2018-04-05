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