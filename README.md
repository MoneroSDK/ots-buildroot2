# monero-ots Buildroot Package

This repository contains the Buildroot package definition for the Monero OTS (Offline-Transaction-Signing) library.

## Overview

The `monero-ots` library provides Offline-Transaction-Signing functionality for the Monero cryptocurrency. This package integrates the library into Buildroot-based systems.

## Repository Organization

This package is part of the MoneroSDK ecosystem:
- Core C++/C ABI library: Included in the [Monero source](https://github.com/DiosDelRayo/monero/tree/otslib) under the `ots` directory
- This buildroot package: [ots-buildroot2](https://github.com/MoneroSDK/ots-buildroot2)
- Python wrapper: [ots-python3](https://github.com/MoneroSDK/ots-python3)
- Python wrapper buildroot package: [ots-python3-buildroot2](https://github.com/MoneroSDK/ots-python3-buildroot2)

## Installation

### As an external buildroot package

1. Clone this repository
2. In your buildroot configuration, add this as an external package:
   ```
   make BR2_EXTERNAL=/path/to/ots-buildroot2 menuconfig
   ```
3. Select the package under "Package Selection for the target" → "MoneroSDK" → "monero-ots"
4. Build with:
   ```
   make
   ```

### Integrated into your buildroot configuration

1. Create a directory in your buildroot installation under `package/monero-ots/`
2. Copy the `monero-ots.mk`, `Config.in`, and `monero-ots.hash` files to that directory
3. Add the following line to `package/Config.in`:
   ```
   source "package/monero-ots/Config.in"
   ```
4. Run `make menuconfig` and select the package
5. Build with `make`

## Configuration Options

The package supports the following configuration options:

- Build options are set to minimize dependencies and build size:
  - Shared libraries are disabled
  - Tests are disabled
  - Documentation is not built
  - Additional tools (v1sign, blocktime, bin_header_macro) are disabled

## Dependencies

- Boost (filesystem, thread, system, chrono, serialization)
- OpenSSL
- C++ standard library
- Threads
- Wide character support

## License

This package is released under the BipCot NoGov License 1.3. See the LICENSE file for details.
