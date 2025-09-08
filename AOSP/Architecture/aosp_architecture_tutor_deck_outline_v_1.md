# AOSP Architecture — Tutor Deck Outline (v1)

> Trainer-ready, modular deck you can expand into slides. Each section lists: key ideas, code paths, commands/demos, and speaking notes.

---
## 0) Title & Objectives
- What you’ll learn
  - Big‑picture architecture of Android (AOSP)
  - Roles of each layer & how they interact
  - Where the code lives in AOSP
  - How to trace a feature end‑to‑end (e.g., a touch → frame on screen)

**Demo ideas**
- `adb shell getprop ro.build.version.release` / `adb shell getenforce`
- `adb shell dumpsys activity broadcasts` (quick glimpse)

---
## 1) High‑Level Stack (the 7 layers)
- Applications (user/system/privileged)
- Framework (Java/Kotlin APIs + system_server services)
- System APIs (hidden @SystemApi) & privileged apps
- Android Runtime (ART / Zygote / dex2oat / JIT/AOT)
- Native services & libraries (libbinder, libandroid_runtime, Skia, media)
- HALs (AIDL/HIDL, VINTF)
- Linux Kernel (drivers, cgroups/BPF, SELinux)

**Diagram placeholder**: overall stack

**Speaking notes**: emphasize Treble split (system vs vendor), partitions, and mainline modules/APEX.

---
## 2) Partitions, Treble & Updateability
- Partitions: `/system`, `/system_ext`, `/product`, `/vendor`, `/odm`, `/data`, `/metadata`
- Project Treble
  - VINTF (compatibility matrix + manifests)
  - VNDK & vendor interface stability
- Mainline (APEX modules: ART, Media, NNAPI, etc.)
- AVB & A/B OTA (very high level)

**Code paths**
- `system/`, `system/core/`, `packages/modules/`, `vendor/` (device specific)

**Demos**
- `adb shell cat /system/etc/vintf/compatibility_matrix.xml`
- `adb shell pm list packages --apex`

---
## 3) Boot Flow & Process Model
- Boot ROM → Bootloader → Kernel → `init` → `zygote` → `system_server`
- Service start via init `.rc` files
- App process creation via Zygote (fork)
- SELinux domains & sandboxing

**Code paths**
- `system/core/init/`, `frameworks/base/services/`, `frameworks/base/core/java/android/app/ActivityThread.java`

**Demos**
- `adb shell ps -A | head`
- `adb shell cat /init.rc | head -n 80`

**Speaking notes**: highlight cold vs warm start, preloading classes/resources in Zygote.

---
## 4) IPC via Binder (Glue of Android)
- Binder concepts: client ↔ service, proxy ↔ stub, handle, threadpool
- AIDL (app/framework) vs AIDL‑HAL/HIDL (vendor)
- servicemanager & servicelocator patterns

**Code paths**
- `frameworks/native/libs/binder/`, `frameworks/base/core/java/android/os/`

**Demos**
- `adb shell service list`
- `adb shell dumpsys activity services | head -n 50`

**Speaking notes**: why Binder (capabilities, zero‑copy-ish, refcounting).

---
## 5) Framework & system_server Services
- Core services: AMS, PMS, WMS, InputManager, PowerManager, Connectivity, Media, Location, Sensor, Telephony
- Role of Context, SystemServiceRegistry
- Permission checks (appops vs runtime perms)

**Code paths**
- `frameworks/base/services/core/java/com/android/server/`
- `frameworks/base/core/java/android/app/`

**Demos**
- `adb shell dumpsys activity`, `dumpsys package`, `dumpsys window`

**Speaking notes**: lifecycle & message queues (Looper/Handler), ANR tracing basics.

---
## 6) Graphics Pipeline
- App → Choreographer → RenderThread (Skia) → BufferQueue → SurfaceFlinger → HWC
- Composition modes: GLES / MIXED / HWC

**Code paths**
- `frameworks/base/libs/hwui/`, `frameworks/native/services/surfaceflinger/`, `hardware/interfaces/graphics/`

**Demos**
- `adb shell dumpsys SurfaceFlinger --latency`
- `adb shell cmd gfxinfo <pkg> framestats`

**Speaking notes**: VSYNC, triple buffering, jank sources.

---
## 7) Input Stack
- Kernel evdev → InputReader → InputDispatcher → View hierarchy
- Touch latency & event batching

**Code paths**
- `frameworks/native/services/inputflinger/`, `frameworks/base/core/java/android/view/`

**Demos**
- `adb shell getevent -l`

**Speaking notes**: IME, window focus & input routing.

---
## 8) Media & Camera
- Media: MediaServer, MediaCodec, Extractors, AudioFlinger, AAudio
- Camera: CameraServer, Camera2 API, HAL v3 pipeline

**Code paths**
- `frameworks/av/`, `frameworks/base/media/`, `hardware/interfaces/camera/`

**Demos**
- `adb shell dumpsys media.audio_flinger`
- `adb shell dumpsys media.camera`

**Speaking notes**: buffer queues, zero‑copy paths, timestamps.

---
## 9) Networking
- netd, ConnectivityService, VPN, tethering
- iptables/eBPF, DNS resolver, captive portal

**Code paths**
- `system/netd/`, `packages/modules/Connectivity/`

**Demos**
- `adb shell cmd connectivity status`
- `adb shell dumpsys connectivity`

---
## 10) Storage & Filesystems
- Partitions and FDE/FBE (file‑based encryption)
- vold, storaged, sdcardfs/FUSE, app sandboxes

**Code paths**
- `system/vold/`, `frameworks/base/core/java/android/os/storage/`

**Demos**
- `adb shell sm list-volumes all`

---
## 11) Security Model
- Permissions (normal/dangerous/signature), AppOps
- SELinux per‑domain enforcement
- Keystore/Keymaster, Gatekeeper

**Code paths**
- `system/security/keystore2/`, `hardware/interfaces/keymaster/`, `hardware/interfaces/gatekeeper/`

**Demos**
- `adb shell dumpsys package <pkg> | grep granted`

**Speaking notes**: attack surfaces & hardening.

---
## 12) Build System & Tree Navigation
- Soong (Blueprint), Ninja, Android.bp/Android.mk legacy
- lunch/targets, product/product_services
- Typical bring‑up: device/, vendor/, kernel/

**Code paths**
- `build/soong/`, `build/make/`, `device/<oem>/<product>/`

**Demos**
- `lunch aosp_cf_x86_64_only-userdebug`
- `m -j$(nproc)`

---
## 13) Automotive (AAOS) Add‑On Section (optional)
- CarService, Car HAL, VHAL properties, audio focus in IVI
- Boot time constraints & RVC

**Code paths**
- `packages/services/Car/`, `hardware/interfaces/automotive/vehicle/`

---
## 14) Labs & Tracing (hands‑on)
- systrace/perfetto basics
- `atrace -z -b 4096 gfx view sched freq idle am wm`
- logcat tags for SurfaceFlinger/Input/ActivityManager

---
## 15) Appendix: Cheat Sheets
- Common `dumpsys` commands
- Useful `adb shell` snippets
- Directory map (what lives where)

---
## TODO for Review
- Drop in your current slides → we’ll map each slide to this outline
- Decide target audience (framework, HAL, or app‑dev heavy?)
- Choose 2–3 live demos suitable for your machine
- Add custom diagrams for: Binder, Graphics, Boot & Zygote

