# Android Open Source Project (AOSP) Folder Structure — Deep Dive

The AOSP source tree is modular and huge. This document provides a **hierarchical breakdown** and detailed explanations for the most important folders, including one deeper level where necessary.

---

## 📂 High-Level Folder Hierarchy

AOSP_ROOT
├── art/                
├── bionic/             
├── bootable/           
├── build/              
├── cts/                
├── dalvik/             
├── developers/         
├── device/             
├── external/           
├── frameworks/         
├── hardware/           
├── kernel/             
├── libcore/            
├── packages/           
├── platform_testing/   
├── prebuilts/          
├── sdk/                
├── system/             
├── test/               
├── tools/              
└── vendor/             

---

## 📖 Folder Explanations with Deep Dive

---

### 🔹 art/ (Android Runtime)
- Replacement for Dalvik VM.
- Handles **dex bytecode execution, JIT/AOT compilation, GC**.

Subfolders:
- `compiler/` → ART JIT/AOT compiler.
- `runtime/` → VM runtime, GC, thread scheduler.
- `dex2oat/` → Dex-to-OAT converter (precompiled app binaries).
- `tools/` → Debugging & profiling tools.

---

### 🔹 bionic/ (C Library)
- Custom lightweight libc for Android.
- Optimized for performance and small footprint.

Subfolders:
- `libc/` → Standard C functions.
- `libm/` → Math functions.
- `linker/` → Dynamic linker/loader.
- `tests/` → Unit tests for libc/m.

---

### 🔹 bootable/ (Boot-related Sources)
- Code for bootloader, recovery, fastboot.

Subfolders:
- `bootloader/` → Device boot code.
- `recovery/` → Recovery environment (factory reset, OTA update).
- `fastboot/` → Fastboot protocol implementation.

---

### 🔹 build/ (Build System)
- Defines the build infrastructure.

Subfolders:
- `make/` → Legacy Android makefiles.
- `soong/` → Modern build system (Go-based).
- `blueprint/` → Build language parser (used by Soong).
- `core/` → Build rules, product definitions.

---

### 🔹 cts/ (Compatibility Test Suite)
- Ensures API and behavior compliance.

Subfolders:
- `tests/` → Individual compatibility tests.
- `tools/` → Test harness and runners.

---

### 🔹 device/ (Device Configurations)
- Contains per-device definitions.

Example: `device/google/cuttlefish/`
- `BoardConfig.mk` → Board build config.
- `init/` → Device init scripts.
- `overlay/` → Resource overlays (XML modifications).
- `sepolicy/` → SELinux policies for device.

---

### 🔹 external/ (Third-party Libraries)
- External open-source dependencies used by Android.

Examples:
- `zlib/` → Compression.
- `skia/` → 2D graphics library.
- `openssl/` → Cryptography.
- `protobuf/` → Protocol Buffers.

---

### 🔹 frameworks/ (Android Framework APIs)
- Core Android Java and C++ APIs.
- Backbone of Android app development.

Deep dive:
- `base/` → Core Android framework.
  - `core/` → Java framework (android.*, java.* APIs).
  - `graphics/` → Rendering, surfaces, UI pipeline.
  - `media/` → Media services (legacy).
  - `services/` → Java system services:
    - ActivityManagerService
    - WindowManagerService
    - PackageManagerService
    - PowerManagerService
  - `telephony/` → Phone and SMS APIs.
  - `wifi/` → Wi-Fi services.
  - `keystore/` → Security APIs.
- `av/` → Modern media framework (Stagefright, audio, codecs).
- `native/` → Native system services (C++).
- `opt/` → Optional features (carrier services, permissions).
- `webview/` → Chromium-based WebView.

---

### 🔹 hardware/ (HAL Implementations)
- Hardware Abstraction Layer: bridges hardware and Android framework.

Subfolders:
- `interfaces/` → HAL definitions (HIDL, now AIDL).
- `libhardware/` → Shared HAL utilities.
- `google/` → Google-specific HALs.
- Vendor-specific HALs (Qualcomm, etc.).

---

### 🔹 kernel/ (Linux Kernel)
- The Linux kernel source (if synced).
- Often kept in a separate repo per device.
- Includes device drivers, scheduler, memory mgmt.

---

### 🔹 libcore/ (Java Core Libraries)
- Core Java classes (java.*, javax.*).
- Includes Android-optimized implementations.
- Works closely with ART.

---

### 🔹 packages/ (Default Apps)
- Houses default system apps.

Subfolders:
- `apps/` → Core Android apps:
  - `Settings/`
  - `Launcher3/`
  - `Music/`
  - `Email/`
  - `Gallery/`
- `providers/` → Core content providers:
  - `ContactsProvider/`
  - `MediaProvider/`
- `inputmethods/` → Keyboards (LatinIME).

---

### 🔹 platform_testing/
- Internal test frameworks for AOSP components.
- Used mainly by Android engineers.

---

### 🔹 prebuilts/
- Toolchains and precompiled binaries for building Android.

Subfolders:
- `clang/` → LLVM/Clang toolchain.
- `gcc/` → GCC toolchain (legacy).
- `jdk/` → Prebuilt Java Development Kit.

---

### 🔹 sdk/
- SDK build targets.
- Provides stubs and libraries for app developers.

---

### 🔹 system/ (Core System Daemons and Services)
- Native daemons and core services.

Deep dive:
- `core/` → Critical C/C++ system components:
  - `adb/` → Android Debug Bridge.
  - `init/` → Init process (first userspace process).
  - `libcutils/` → Common utilities.
  - `liblog/` → Android logging system.
  - `logd/` → Log daemon.
- `bt/` → Bluetooth stack.
- `netd/` → Network daemon.
- `vold/` → Volume manager (storage, encryption).
- `sepolicy/` → SELinux security policies.

---

### 🔹 test/
- Unit and integration test infrastructure.

---

### 🔹 tools/
- Developer and build tools.

Examples:
- `apkzlib/` → APK processing.
- `emulator/` → Emulator code.
- `tradefed/` → Test harness.

---

### 🔹 vendor/ (Proprietary Code)
- Vendor/OEM-specific files.
- Contains:
  - Drivers (GPU, audio, modem).
  - Proprietary binaries.
  - Vendor HALs.
  - Vendor sepolicy extensions.

---

## 📌 Summary

- **frameworks/** → App-facing APIs, system services.  
- **system/** → Native daemons, init, adb, netd, vold.  
- **hardware/** → HAL definitions and implementations.  
- **device/** → Device configs (BoardConfig, init).  
- **vendor/** → OEM binaries and drivers.  
- **art/libcore** → Runtime + Java core libraries.  
- **bionic** → libc, linker.  
- **build/prebuilts/tools** → Build infrastructure.  
