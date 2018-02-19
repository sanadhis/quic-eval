# Brief Explanation about QUIC's Design and  Evaluation
QUIC is a cross-layer transport protocol over UDP and in fact it is being under rapid development by Google with extensive rewriting and version release over months.

## Warmed-up Explanation
* QUIC has been widely deployed by Google on thousands of their servers.
* Chrome, Google Search app, and Youtube app make use of QUIC.
* Google claims that 7% of internet traffic now QUIC [1].
* User-space / application layer transport layer protocol, support continued evolution without OS/kernel-level upgrades.
* UDP-based, allowing evolution without explicit upgrade to intermediary devices.

## Features
* Encrypted traffics, avoiding intervention by middleboxes.
* Low latency with maximum of 1-RTT handshake during connection establishment. Best performance is achieved with 0-RTT handshake (minimizes handshake latency).
* Communication over a single UDP connection, non-blocking (Head-of-line/HOL) by utilizing multiple streams for each packet.
* Pluggable module, such as Forward Error Correction (FEC).
* Pluggable **congestion control**, such as Cubic or BBR.
* Use connection ID, may support client-initiated connection migration in the future.
* Use forward-secure key.
* Connection-level **flow control** limits aggregated buffer that client can consume.

## Default settings
* 1350 bytes of payload size.

## Comparison with TCP
* Improved loss recovery.
* [Advantages] better performance when RTTs are higher.
* Congestion window exhibits smaller oscillations than TCP.
* Not fair when competing with TCP sources over bottleneck links because of the nature of UDP and mostly because of its congestion window (*Note: CUBIC*).
* Unique packet number for better loss recovery by avoding TCP's retransimission ambiguity.
* UDP proxying is possible but not equivalent to TCP-terminating proxies.
* [Disadvantages] CPU consuming, approximately twice consuming as TLS/TCP stack.
* [Disadvantages] UDP may face UDP throttling in some ASs.

## Streams
* Can be cancelled (cancelled streams will not be retransmitted when loss occurs).
* May be prioritized.
* Stream-level flow control, no greedy stream steals all receiver's buffer.

## FEC
* Small group implies high redudancy, vice versa.
* XORsum, only to recovers one packet at maximum.
* Takes roughly 33% of channel utilization (default group size is 3).
* Support was removed in early 2016.

## Related works
* SPDY
* Structured Stream Transport (SST)
* TCP Fast Open
* MinimaLT

## References
1. A. Langley et al., “The QUIC Transport Protocol: Design and Internet-Scale Deployment,” in Proceedings of the Conference of the ACM Special Interest Group on Data Communication, New York, NY, USA, 2017, pp. 183–196.
2. G. Carlucci, L. De Cicco, and S. Mascolo, “HTTP over UDP: An Experimental Investigation of QUIC,” in Proceedings of the 30th Annual ACM Symposium on Applied Computing, New York, NY, USA, 2015, pp. 609–614.
3. A. M. Kakhki, S. Jero, D. Choffnes, C. Nita-Rotaru, and A. Mislove, “Taking a Long Look at QUIC: An Approach for Rigorous Evaluation of Rapidly Evolving Transport Protocols,” in Proceedings of the 2017 Internet Measurement Conference, New York, NY, USA, 2017, pp. 290–303.
