# Experiment on QUIC's Toy Client and Server
1. Custom build using gn and ninja
Read briefly about [gn](https://chromium.googlesource.com/chromium/src/+/master/tools/gn/docs/quick_start.md) and then define the custom quic_client and quic_server by editing:
```bash
vim net/BUILD.gn
```
Add structures for executable `quic_client_dummy` and `quic_server_dummy` alongside with their dependencies. You may mimic the ones that already defined e.g. `quic_client` or `quic_server`.

2. Make sure that the **sources** in previous point refer to the new custom codes for QUIC toy cliend and server. E.g. `net/tools/quic/quic_simple_client_bin_dummy.cc`

3. Define your corresponding codes for QUIC client and server:
```bash
vim net/tools/quic/quic_simple_client_bin_dummy.cc
```

4. Compile, link, and build using Ninja:
```bash
ninja -C out/Default quic_client_dummy
```
Note that there is no need to re-generate build files using gn, ninja will automtically regenerating ninja files.

5. Test