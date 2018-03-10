# Testing QUIC Toy Server performance
Some raw and dirty testing for QUIC toy server.

# A. Multiple Concurrent Connections
1. Install [GNU parallel](https://www.gnu.org/software/parallel/). Note: Check my other repo for an automated installation script [here](https://github.com/sanadhis/kube-ubuntu-utils)

2. Ensure you have compiled `quic_client` and `quic_server` in some `CHROMIUM_PROJECT_DIR/src/out/Default`. Also, make sure both have been working correctly.

3. Export CHROMIUM_PROJECT_DIR environment variable (**the root path, exclude src**).
```bash
export CHROMIUM_PROJECT_DIR=/path/to/your/chromium_dir
```

3. Execute:
```bash
./quic_concurrent_bench.sh $NUMBER_OF_DESIRED_CONCURRENT_REQUESTS
```
Example:
```bash
./quic_concurrent_bench.sh 2
```