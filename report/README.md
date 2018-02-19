# Brief Explanation about QUIC's Design and  Evaluation
QUIC is a cross-layer transport protocol over UDP and in fact it is being under rapid development by Google with extensive rewriting and version release over months.

## Warmed-up Explanation
* Quic has been widely deployed by Google on thousands of their servers.
* Chrome, Google Search app, and Youtube app make use of QUIC.
* Google claims that 7% of internet traffic now QUIC [1].

## Features
* Encrypted traffics, avoiding intervention by middleboxes.
* Low latency with maximum of 1-RTT handshake during connection establishment.
* Connection over single connection, non-blocking (Head-of-line/HOL) by utilizing multiple streams on each packet.
* Pluggable module, such as Forward Error Correction (FEC)
* Pluggable congestion control, such as Cubic or BBR.

## References
1. A. Langley et al., “The QUIC Transport Protocol: Design and Internet-Scale Deployment,” in Proceedings of the Conference of the ACM Special Interest Group on Data Communication, New York, NY, USA, 2017, pp. 183–196.
2. G. Carlucci, L. De Cicco, and S. Mascolo, “HTTP over UDP: An Experimental Investigation of QUIC,” in Proceedings of the 30th Annual ACM Symposium on Applied Computing, New York, NY, USA, 2015, pp. 609–614.
3. A. M. Kakhki, S. Jero, D. Choffnes, C. Nita-Rotaru, and A. Mislove, “Taking a Long Look at QUIC: An Approach for Rigorous Evaluation of Rapidly Evolving Transport Protocols,” in Proceedings of the 2017 Internet Measurement Conference, New York, NY, USA, 2017, pp. 290–303.
