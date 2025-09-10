# Android AOSP Folder Structure

This presentation explains the **Android Open Source Project (AOSP) folder structure**, its components, and how everything connects from **hardware to framework to apps**. It is structured into clear sections, resembling slides, but presented as a Markdown document for easier review and editing.

---

## AOSP Root Directory Overview

- The AOSP root directory is the **top-level folder** after cloning AOSP using `repo init` and `repo sync`.
- It contains multiple subdirectories, each representing a **major subsystem of Android**.
- Examples:
  - `build/`
  - `system/`
  - `frameworks/`
  - `hardware/`
  - `packages/`

---

## Android Architecture Layers - Simple Breakdown

1. **Linux Kernel** → hardware abstraction, drivers.
2. **HAL (Hardware Abstraction Layer)** → standard APIs for hardware components.
3. **Native Libraries** → C/C++ libraries like `libc`, `libm`, multimedia.
4. **ART (Android Runtime)** → Dalvik/ART virtual machine, core Java APIs.
5. **Framework Layer** → APIs for app developers (Java/Kotlin).
6. **Applications** → Prebuilt system apps + user-installed apps.

---

## Source Code Flow

- **Hardware drivers** (kernel, HAL) → exposed via standardized interfaces.
- **System services** (C++/Java) in `system/` and `frameworks/`.
- **Framework APIs** in `frameworks/base/`.
- **Applications** in `packages/apps/`.
- **Build system** integrates everything into system images.

---

## Hardware → System → Framework → App

- **Hardware (C, Assembly, Kernel modules)**  
- **System (HAL, Native daemons in C/C++)**  
- **Framework (Java/Kotlin APIs)**  
- **App (Java/Kotlin + XML UI)**  

---

## Overview (framework, design, system, device, hardware, packages, external, build, libcore, art, cts, platform_testing)

- `frameworks/` → core Android framework libraries & APIs.
- `system/` → system services, daemons, init scripts.
- `device/` → board-specific configurations (e.g., Pixel, Nexus).
- `hardware/` → HAL implementations for components (camera, sensors).
- `packages/` → stock apps (Settings, Phone, Contacts).
- `external/` → third-party open-source libraries.
- `build/` → build system scripts, configuration, makefiles.
- `libcore/` → Java core libraries.
- `art/` → Android Runtime (ART/Dalvik).
- `cts/` → Compatibility Test Suite.
- `platform_testing/` → automated tests and test frameworks.
- `design/` → guidelines, resources.
- `ionic/` → experimental/legacy placeholder (not always present).

---

## Root-Level Directories: Purpose and Contents

- `bionic/` → Android’s libc implementation.
- `bootable/` → Bootloader code.
- `dalvik/` → Legacy Dalvik VM (pre-ART).
- `development/` → SDK and developer tools.
- `kernel/` → Linux kernel sources.
- `ndk/` → Native Development Kit.

---

## More Root-Level Directories

- `prebuilts/` → Precompiled binaries & tools (e.g., Clang).
- `repo/` → Repo tool for source management.
- `test/` → Test sources.
- `tools/` → Development tools and scripts.
- `vendor/` → Proprietary/vendor-specific binaries.

---

## Additional Important Directories

- `docs/` → Documentation.
- `examples/` → Sample code.
- `pdk/` → Platform Development Kit for OEMs.

---

## Visual Tree Diagram: Key Subdirectories

```text
AOSP/
├── art/              # Android Runtime
├── bionic/           # C library
├── build/            # Build system
├── device/           # Device-specific configs
├── external/         # External libraries
├── frameworks/       # Android APIs & frameworks
├── hardware/         # Hardware Abstraction Layer
├── libcore/          # Core Java libraries
├── packages/         # Default Android apps
├── platform_testing/ # Test infrastructure
├── system/           # System daemons/services
└── vendor/           # Vendor-specific binaries
```
---
## Android.bp and Android.mk Placement Strategy

- `Android.bp` → New build system (Soong).
- `Android.mk` → Legacy Make-based build.
- *Placement:*
    - Each module/subsystem has its own `Android.bp` or `Android.mk`.
    - Example:
        - `frameworks/base/Android.bp`
        - `packages/apps/Settings/Android.bp`
---
## Key Class Locations and Examples

- `frameworks/base/core/java/android/os/` → Core Android classes (`Handler`, `Looper`).
- `frameworks/base/services/` → System services (ActivityManagerService).
- `packages/apps/Settings/src/` → System Settings app code.

---
## HAL Module Locations

- Camera HAL → `hardware/interfaces/camera/`
- Audio HAL → `hardware/interfaces/audio/`
- Sensors HAL → `hardware/interfaces/sensors/`

---
## Hands-on Demo: Navigating AOSP Source Tree

1. **Basic navigation commands**
``` bash
cd ~/WORKSPACE/AOSP_15.0.0_36   # go to AOSP root
ls -d */                       # list top-level directories
```

2. **Locate specific classes**
``` bash
find frameworks/base -name "*ActivityManagerService*"
```

3. **Search for specific patterns**
```bash
grep -R "onCreate" frameworks/base/core/java/android/
```


4. **Explore specific directories**
```bash 
cd packages/apps/Settings
tree -L 2                      # show directory structure (2 levels deep)
```

5. **Find build files**
```bash
find . -name "Android.bp"
find . -name "Android.mk"
```
---

## Real-World Examples: Finding System Components

1. ***Find System Settings app***
``` bash
cd packages/apps/Settings
ls -R | grep Android.bp
```

2. ***Find Camera HAL interface***
``` bash
cd hardware/interfaces/camera
ls
```
---

## Understanding the Build System Integration

- Soong (Android.bp) → modern build system.
- Make (Android.mk) → legacy system.
- Ninja → final build execution.
- Build artifacts → stored under `out/`.
---

## Module Discovery

- Modules are defined in Android.bp/Android.mk.
- Types: apps, libraries, executables, services.
---

## Module Types and Locations

- App Modules → `packages/apps/`
- Library Modules → `frameworks/`, `libcore/`
- HAL Modules → `hardware/interfaces/`
---

## Build Output Locations

- `out/target/product/<device>/system/` → system image.
- `out/target/product/<device>/vendor/` → vendor image.
- `out/host/linux-x86/` → host tools.
---

## Common Patterns

- Services: found in `frameworks/base/services/`.
- Apps: in `packages/apps/`.
- Tests: under `cts/` or `platform_testing/`.
- HALs: under `hardware/interfaces/`.
---

## References and Further Reading

- Official AOSP Documentation (https://source.android.com/docs)
- AOSP Source Search (http://newandroidbook.com/)
---

## 

- 
- 
- 
---