# Getting Started
How to gettting started with Chromium project in Mac OSX.
<br>
* depot_tools (contains ninja, gn, etc)

## Notes
* Use system-wide python 2.7 (strictly) instead of python from conda (regardless of version 2.7, I don't know why)
* Use `--quic_response_cache_dir=/tmp/quic-data/` when starting quic_server and do not modify HTTP headers on index.html
* To reuse [google deprecated quic](https://github.com/google/proto-quic) follow the instructions **BUT please** use the latest version of depot_tools from official google repository: [depot_tools](https://chromium.googlesource.com/chromium/tools/depot_tools.git)

# Official Documentation
1. [Chromium Project](https://www.chromium.org/quic)