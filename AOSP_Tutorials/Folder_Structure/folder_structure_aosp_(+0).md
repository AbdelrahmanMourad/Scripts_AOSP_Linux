# Android Open Source Project (AOSP) Folder Structure

The **AOSP source tree** is large and modular. Each top-level folder has a clear purpose, from core framework code to device-specific configuration. Below is a hierarchy diagram followed by explanations.

---

## 📂 High-Level Folder Hierarchy
```
AOSP_ROOT
├── art/                # Android Runtime (ART) and garbage collector
├── bionic/             # C standard library (libc), libm, dynamic linker
├── bootable/           # Bootloader, recovery sources
├── build/              # Core build system (Soong, Makefiles, configs)
├── cts/                # Compatibility Test Suite
├── dalvik/             # Legacy Dalvik VM (replaced by ART, but kept for ref)
├── developers/         # Developer tools, samples, and docs
├── device/             # Device-specific configurations (BoardConfig.mk, etc.)
│   └── google/…        # Pixel devices configs
├── external/           # Third-party open-source libraries (zlib, skia, etc.)
├── frameworks/         # Core Android framework (Java APIs, services)
│   ├── base/           # Core framework classes (Activity, ContentProvider, etc.)
│   │   ├── core/       # Core Java framework code (android.*, java.*)
│   │   ├── graphics/   # Graphics & rendering
│   │   ├── media/      # Media framework (legacy parts)
│   │   ├── services/   # System services (ActivityManager, WindowManager)
│   │   ├── telephony/  # Telephony framework
│   │   ├── wifi/       # Wi-Fi framework
│   │   └── keystore/   # Keystore and security services
│   ├── av/             # Media framework (audio, video, codecs, Stagefright)
│   ├── native/         # Native framework (C++ system services)
│   ├── opt/            # Optional framework features
│   └── webview/        # Chromium-based WebView implementation
├── hardware/           # Hardware Abstraction Layer (HAL) implementations
│   ├── interfaces/     # HAL interface definitions (HIDL, AIDL)
│   ├── libhardware/    # Shared HAL libraries
│   └── google/…        # Vendor-specific HALs
├── kernel/             # Kernel sources (only if provided; usually separate repo)
├── libcore/            # Core Java libraries (java.*, javax.* packages)
├── packages/           # Default Android apps (Settings, Launcher, etc.)
│   ├── apps/           # Core apps (Email, Browser, Music, etc.)
│   └── providers/      # Content providers (ContactsProvider, MediaProvider)
├── platform_testing/   # Test frameworks for platform validation
├── prebuilts/          # Prebuilt binaries & toolchains (clang, JDK, etc.)
├── sdk/                # Android SDK build targets
├── system/             # Core Android system components
│   ├── core/           # Init, logd, system services in C++
│   ├── bt/             # Bluetooth stack
│   ├── netd/           # Network daemon
│   ├── vold/           # Volume daemon (storage, encryption, etc.)
│   └── sepolicy/       # SELinux policies
├── test/               # Unit tests, integration tests
├── tools/              # Build and developer tools
└── vendor/             # Vendor-specific drivers, binaries, proprietary code
    └── google/…        # Pixel vendor blobs
```
---

## 📖 Folder Explanations

### 🔹 art/
- Contains **Android Runtime (ART)**, the replacement for Dalvik.
- Manages:
  - JIT & AOT compilation
  - Garbage Collection (GC)
  - Dex file parsing & optimization

### 🔹 bionic/
- Android’s **custom C library (libc)**.
- Includes:
  - libc (standard C library)
  - libm (math library)
  - Dynamic linker (linker/)
- Optimized for low memory and performance.

### 🔹 bootable/
- Sources for boot-related tools.
- Includes:
  - Recovery system
  - Bootloader helpers
  - Fastboot tools

### 🔹 build/
- The **build system** for Android.
- Contains Soong (build/soong/) and Makefiles.
- Defines product configurations, board setup, etc.

### 🔹 cts/
- Compatibility Test Suite.
- Ensures apps and devices meet Android compatibility standards.

### 🔹 dalvik/
- Legacy Dalvik VM (kept for reference, ART is now default).

### 🔹 developers/
- Guides, docs, and sample projects for Android developers.

### 🔹 device/
- Device-specific code and configurations.
- Example:
  - device/google/pixel → Pixel device config
- Contains:
  - BoardConfig.mk
  - init scripts
  - vendor partition setup

### 🔹 external/
- Third-party open-source libraries used by Android.
- Examples:
  - zlib/
  - skia/ (graphics)
  - openssl/
  - protobuf/

### 🔹 frameworks/
- Core Android framework implementation.
- Subfolders:
  - base/ → Java APIs, Activity Manager, Content Providers, Services
    - core/ → android.*, java.*, javax.*
    - graphics/ → rendering and surface handling
    - media/ → legacy media framework
    - services/ → ActivityManager, WindowManager, PowerManager
    - telephony/ → phone services
    - wifi/ → Wi-Fi handling
    - keystore/ → key management
  - av/ → Media framework (AudioFlinger, Camera, Stagefright codecs)
  - native/ → Native system services (C++)
  - opt/ → Optional features
  - webview/ → Chromium WebView

### 🔹 hardware/
- Hardware Abstraction Layer (HAL) implementations.
- Interfaces between framework and drivers.
- Subfolders:
  - interfaces/ → HAL definitions (HIDL/AIDL)
  - libhardware/ → Common HAL functions
  - vendor-specific HALs (hardware/google/)

### 🔹 kernel/
- Contains Linux kernel sources (only if repo cloned with kernel).
- Often kept in separate repos for each device.

### 🔹 libcore/
- Java core libraries (java.*, javax.*).
- Based on OpenJDK with Android-specific modifications.

### 🔹 packages/
- Contains default Android apps:
  - apps/ → Settings, Music, Launcher
  - providers/ → ContactsProvider, MediaProvider
  - inputmethods/ → LatinIME (default keyboard)

### 🔹 platform_testing/
- Internal test frameworks for platform components.

### 🔹 prebuilts/
- Prebuilt toolchains and binaries:
  - GCC/Clang
  - JDK
  - Binaries needed for building without recompiling everything

### 🔹 sdk/
- Android SDK-related files.
- API stubs and libraries for app developers.

### 🔹 system/
- Core Android system daemons & services (C/C++).
- Subfolders:
  - core/ → init, logd, system_server C++ parts
  - bt/ → Bluetooth stack
  - netd/ → Network daemon
  - vold/ → Volume daemon
  - sepolicy/ → SELinux policies

### 🔹 test/
- Unit tests, integration tests, regression tests.

### 🔹 tools/
- Developer tools for building, debugging, flashing devices.

### 🔹 vendor/
- Vendor-specific binaries and drivers.
- Proprietary code from OEMs (Qualcomm, Samsung, Google).

---

## 📌 Summary

- Frameworks → Core Android APIs and services  
- System → Low-level system daemons  
- Device/Vendor/Hardware → Device-specific and HAL implementations  
- External/Prebuilts/Libcore → External libraries and prebuilt toolchains  
- Build/Tools → Build system and developer tools  
- CTS/Test → Testing infrastructure  
