# Android Build Path (AOSP)

The **Android build path** contains everything needed to flash and run your device/emulator.  
Main image files include:

- **system.img & system/**
  - Contains most of the operating system libraries and core components.
- **product.img & product/**
  - Holds device-specific and customizable components (apps, features).
- **super.img**
  - A container image that can hold `system`, `product`, `vendor`, and other partitions together in a dynamic partition setup.

---

## Example: System Directory Layout

Path:
```
aosp/out/target/product/vsoc_x86_64_only/system/
```

Directory listing:
```
total 124
drwxrwxr-x 13 mourad mourad  4096 Aug 16 17:06 ./
drwxrwxr-x 24 mourad mourad  4096 Aug 16 20:30 ../
drwxrwxr-x  2 mourad mourad  4096 Aug 16 20:29 apex/
drwxrwxr-x 23 mourad mourad  4096 Aug 16 20:09 app/
drwxrwxr-x  4 mourad mourad 16384 Aug 16 20:09 bin/
-rw-rw-r--  1 mourad mourad  5356 Aug 16 17:06 build.prop
drwxrwxr-x 17 mourad mourad  4096 Aug 16 20:29 etc/
drwxrwxr-x  2 mourad mourad 12288 Aug 16 17:06 fonts/
drwxrwxr-x  4 mourad mourad 12288 Aug 16 20:12 framework/
drwxrwxr-x  2 mourad mourad  4096 Aug 16 17:06 lib/
drwxrwxr-x  4 mourad mourad 36864 Aug 16 20:09 lib64/
drwxrwxr-x 44 mourad mourad  4096 Aug 16 20:09 priv-app/
lrwxrwxrwx  1 mourad mourad     8 Aug 16 17:06 product -> /product
lrwxrwxrwx  1 mourad mourad    11 Aug 16 17:06 system_ext -> /system_ext
drwxrwxr-x  7 mourad mourad  4096 Aug 16 20:04 usr/
lrwxrwxrwx  1 mourad mourad     7 Aug 16 17:06 vendor -> /vendor
drwxrwxr-x  2 mourad mourad  4096 Aug 16 17:06 xbin/
```

---

## Directory Explanations

### `app/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/app/```
- Contains the standard Android applications that are built for the target (in this case, **cuttlefish emulator**).
---
### `priv-app/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/priv-app/```
- Contains **privileged applications** with higher permissions than normal apps.
- Examples: `Shell`, `ProxyHandler`, `Wifi`, `Settings`.
---
### `framework/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/framework/```
- Holds all the **Java libraries** (`.jar`) that make up the Android framework APIs used by apps.
---
### `lib/` & `lib64/`
Path: 
```aosp/out/target/product/vsoc_x86_64_only/system/lib/```
```aosp/out/target/product/vsoc_x86_64_only/system/lib64/```
- Contains **C/C++ shared libraries** (`.so` files).
- `lib/`: 32-bit libraries.
- `lib64/`: 64-bit libraries.
---
### `bin/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/bin/```
- Contains **native command-line utilities** and executables.
- Examples: `zip`, `make`, `sdcard`, `sh`, etc.
- Used to interact with the target through shell/ADB.
---
### `apex/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/apex/```
- APEX modules (modular system components).
- Delivers core components (e.g., ART runtime, media framework) as updatable packages.
- Primarily for **OS developers**.
---
### `etc/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/etc/```
- System-wide configuration files and preloaded classes (e.g., `zygote` startup configs).
- Used by both system services and app developers indirectly.
---
### `usr/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/usr/```
- Contains **user-related system data**:
  - Keyboard layouts
  - Timezone information
  - Locale data
  - Public resources used by frameworks and apps
---
### `fonts/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/fonts/```
- Contains system fonts (`.ttf`, `.otf`).
- Used across the UI, apps, and rendering system.
---
### `xbin/`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/xbin/```
- Legacy directory (similar to `bin/`).
- Historically contained advanced user binaries, but nowadays mostly empty or symlinked.
---
### `build.prop`
Path: ```aosp/out/target/product/vsoc_x86_64_only/system/build.prob/```
- A properties file with **system-wide configuration flags**.
- Examples: device model, Android version, API level, build info.
---
### Symlinks
- `product -> /product`
- `system_ext -> /system_ext`
- `vendor -> /vendor`

These point to other partitions/directories that extend the system image:
- **product/**: Device-specific apps/features.
- **system_ext/**: Extensions for the system partition (separates AOSP system from OEM modifications).
- **vendor/**: Hardware vendor-specific binaries, HALs, drivers.

---

## Notes

- **system/** = Base Android OS (framework, core libraries, apps).
- **product/** = Device-specific customizations.
- **vendor/** = Hardware-specific components (GPU drivers, audio HAL, etc.).
- **system_ext/** = OEM extensions for system components.

---

