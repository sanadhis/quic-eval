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
* One QUIC connection emulates N TCP connections.
* Pluggable module, such as Forward Error Correction (FEC).
* Pluggable **congestion control**, such as Cubic or BBR.
* Use connection ID, may support client-initiated connection migration in the future.
* Use forward-secure key.
* Connection-level **flow control** limits aggregated buffer that client can consume.

## Default settings
* 1350 bytes of payload size.
* Maximum congestion window (MACW) is 2000 (for QUIC 37).
* One connection emulates N=1 (QUIC 37) or N=2 (QUIC 34) connections.
* [Chrome] Maximum allowed congestion window size is 107.
* [Chrome] A bug in QUIC prevented slow start threshold from being updated.

## Streams
* Can be cancelled (cancelled streams will not be retransmitted when loss occurs).
* May be prioritized.
* Stream-level flow control, no greedy stream steals all receiver's buffer.

## FEC
* Small group implies high redudancy, vice versa.
* XORsum, only to recovers one packet at maximum.
* Takes roughly 33% of channel utilization (default group size is 3).
* Support was removed in early 2016.

## Congestion Control's State (Cubic)
* ApplicationLimited
* [Non-standard] CongestionAvoidanceMaxed
* CongestionAvoidance
* [Non-standard] Recovery
* SlowStart
* RetransmissionTimeout
* [Non-standard] TailLossProbe

## Comparison with TCP
* [Advantage] Unique packet number for better loss recovery by avoding TCP's retransimission ambiguity.
* [Advantage] Improved congestion control and loss recovery (since it eliminates ACK ambiguity), leading to more precise RTT and bandwidth estimation.
* [Advantage] Better performance when bandwidth fluctuates (achieve higher throughput).
* [Advantage] Better performance when RTTs are higher because of 0-RTT connection establishment.
* [Advantage] Congestion window exhibits smaller oscillations than TCP.
* [Disadvantage] Not fair when competing with TCP sources over bottleneck links because of the nature of UDP and mostly because of its congestion window (*Note: CUBIC*). This happens even when N is tuned. This is caused by QUIC ability to achieve a larger congestion window.
* [Disadvantage] UDP proxying is possible but not equivalent to TCP-terminating proxies, which in theory could improve loss recovery and reduce end-to-end delays.
* [Disadvantage] CPU consuming, approximately twice consuming as TLS/TCP stack.
* [Disadvantage] UDP may face UDP throttling in some ASs.
* [Disadvantage] Sensitive to out-of-order packet delivery. Perform worse than TCP in presence of re-ordering. QUIC's loss detection mechanism reports high numbers of false losses.
* [Disadvantage] QUIC is really weak to variable delays (jitter), compels to significantly worse performance than TCP since jitter makes packet re-ordering.

## Performance Issues
* QUIC seems to outperform TCP in every scenario except in the case of large numbers of small objects. This is actually biased because performance gain of QUIC is mainly due to 0-RTT connection establishment. QUIC does not really better for the case because of early exit of QUIC's Hybrid Slow Start. But nonetheless still outperform TCP.
* Increasing NACK thresholds improve QUIC's end-to-end performance especially when jitter is presence in the network.

## Related protocols
* SPDY
* Structured Stream Transport (SST)
* TCP Fast Open
* MinimaLT

## References
1. A. Langley et al., “The QUIC Transport Protocol: Design and Internet-Scale Deployment,” in Proceedings of the Conference of the ACM Special Interest Group on Data Communication, New York, NY, USA, 2017, pp. 183–196.
2. G. Carlucci, L. De Cicco, and S. Mascolo, “HTTP over UDP: An Experimental Investigation of QUIC,” in Proceedings of the 30th Annual ACM Symposium on Applied Computing, New York, NY, USA, 2015, pp. 609–614.
3. A. M. Kakhki, S. Jero, D. Choffnes, C. Nita-Rotaru, and A. Mislove, “Taking a Long Look at QUIC: An Approach for Rigorous Evaluation of Rapidly Evolving Transport Protocols,” in Proceedings of the 2017 Internet Measurement Conference, New York, NY, USA, 2017, pp. 290–303.
