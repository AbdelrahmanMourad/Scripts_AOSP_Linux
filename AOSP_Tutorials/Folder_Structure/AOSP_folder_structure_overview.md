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

<details>
<!-- <summary>Note</summary> -->
👉 Say:

“When you clone AOSP for the first time, the root directory is where everything starts. It contains many subfolders, each representing a subsystem of Android. For example, 

- `frameworks` holds the APIs, 
- `system` has system services, and 
- `packages` has apps. 

Think of this as the city map of Android — each neighborhood has a function.”
</details>

---

## Android Architecture Layers - Simple Breakdown

1. **Linux Kernel** → hardware abstraction, drivers.
2. **HAL (Hardware Abstraction Layer)** → standard APIs for hardware components.
3. **Native Libraries** → C/C++ libraries like `libc`, `libm`, multimedia.
4. **ART (Android Runtime)** → Dalvik/ART virtual machine, core Java APIs.
5. **Framework Layer** → APIs for app developers (Java/Kotlin).
6. **Applications** → Prebuilt system apps + user-installed apps.

<details>
<!-- <summary>Note</summary> -->

**“Android is layered.”**
- At the bottom is 
  - the Linux kernel, then 
  - HALs that make hardware accessible. 
- On top, we have 
  - C/C++ libraries, 
  - the ART runtime, 
  - the Framework APIs, 
  - and finally apps.   
- “This separation makes Android portable across thousands of devices.”

</details>

---

## Source Code Flow

- **Hardware drivers** (kernel, HAL) → exposed via standardized interfaces.
- **System services** (C++/Java) in `system/` and `frameworks/`.
- **Framework APIs** in `frameworks/base/`.
- **Applications** in `packages/apps/`.
- **Build system** integrates everything into system images.

<details>
<!-- <summary>Note</summary> -->

“The code flows: from low-level hardware all the way to user-facing apps. 

Drivers and HAL expose hardware, system services manage resources, frameworks expose APIs, and apps use them. The build system compiles and integrates everything into images.”

</details>

---

## Hardware → System → Framework → App

- **Hardware (C, Assembly, Kernel modules)**  
- **System (HAL, Native daemons in C/C++)**  
- **Framework (Java/Kotlin APIs)**  
- **App (Java/Kotlin + XML UI)**  

<details>
<!-- <summary>Note</summary> -->

**“This is the pipeline:”**
- hardware gives us raw functionality, 
- the system layer standardizes it, 
- the framework exposes friendly APIs, and 
- apps consume those APIs to deliver features.

</details>

---

## Overview of key Directories:
##### (framework, design, system, device, hardware, packages, external, build, libcore, art, cts, platform_testing)

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

<details>
<!-- <summary>Note</summary> -->

- ***“These directories are the core:”***
  - `frameworks` → Android APIs
  - `system` → daemons and core services
  - `device` → device-specific configs
  - `hardware` → HAL implementations
  - `packages` → apps like Settings
  - `external` → third-party libs
  - `build` → rules for compilation
  - `art` → Android runtime
  - `cts` and `platform_testing` → testing tools.
- ***“Each directory is a piece of the Android puzzle.”***
</details>

---

## Root-Level Directories: Purpose and Contents

- `bionic/` → Android’s libc implementation.
- `bootable/` → Bootloader code.
- `dalvik/` → Legacy Dalvik VM (pre-ART).
- `development/` → SDK and developer tools.
- `kernel/` → Linux kernel sources.
- `ndk/` → Native Development Kit.

<details>
<!-- <summary>Note</summary> -->
👉 Say:

- **“Beyond the main ones, we have:”**
  - `bionic` for libc, 
  - `bootable` for bootloader, 
  - `dalvik` for legacy runtime, 
  - `kernel` for Linux kernel sources, and 
  - `ndk` for native developers.
</details>

---

## More Root-Level Directories

- `prebuilts/` → Precompiled binaries & tools (e.g., Clang).
- `repo/` → Repo tool for source management.
- `test/` → Test sources.
- `tools/` → Development tools and scripts.
- `vendor/` → Proprietary/vendor-specific binaries.

<details>
<!-- <summary>Note</summary> -->

- Directories like: 
  - `prebuilts` contain ready-made binaries such as compilers. 
  - `vendor` is crucial because it holds proprietary hardware drivers. 
    - ***“Without vendor blobs, Android can’t run on real devices.”***
</details>

---

## Additional Important Directories

- `docs/` → Documentation.
- `examples/` → Sample code.
- `pdk/` → Platform Development Kit for OEMs.

<details>
<!-- <summary>Note</summary> -->

- Here we have: 
  - documentation, 
  - sample code, and 
  - the PDK which OEMs use to bring up Android on new hardware.”
</details>

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
<details>
<!-- <summary>Note</summary> -->

- “This tree shows the high-level layout.” 
- Whenever you feel lost in AOSP, just remember: 
  - `frameworks` = **APIs**, 
  - `system` = **services**, 
  - `packages` = **apps**, 
  - `hardware` = **drivers**.
</details>

---

## Android.bp and Android.mk Placement Strategy

- `Android.bp` → New build system (Soong).
- `Android.mk` → Legacy Make-based build.
- *Placement:*
    - Each module/subsystem has its own `Android.bp` or `Android.mk`.
    - Example:
        - `frameworks/base/Android.bp`
        - `packages/apps/Settings/Android.bp`

<details>
<!-- <summary>Note</summary> -->

- **These are build files.**
  - The **`old system`** used `Android.mk` (Make). 
  - The **`new Soong build system`** uses `Android.bp` files. 
- ***“Every module declares itself with one of these, so the build system knows what to compile”***.
</details>

---


## Key Class Locations and Examples

- `frameworks/base/core/java/android/os/` → Core Android classes (`Handler`, `Looper`).
- `frameworks/base/services/` → System services (ActivityManagerService).
- `packages/apps/Settings/src/` → System Settings app code.

<details>

- If you’re looking for the **`Activity Manager Service`**, 
  - go to `frameworks/base/services/`. 
- For **`core Java classes`** like ***`Handler`*** or ***`Looper`***, 
  - they live under `frameworks/base/core/java/android/os/`. 
- For **`apps`** like ***`Settings`***, 
  - look under `packages/apps/Settings/`.
</details>


---

## HAL Module Locations

- Camera HAL → `hardware/interfaces/camera/`
- Audio HAL → `hardware/interfaces/audio/`
- Sensors HAL → `hardware/interfaces/sensors/`

<details>
<!-- <summary>Note</summary> -->

- **`HALs are standardized APIs`**. For example, 
  - the **`Camera HAL`** is under `hardware/interfaces/camera/`, 
  - **`Audio`** under `hardware/interfaces/audio/`, and 
  - **`Sensors`** under `hardware/interfaces/sensors/`. 
- ***“These allow Android to talk to hardware consistently across devices.”***
</details>

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

<details>
<!-- <summary>Note</summary> -->

- While showing commands:
  - ***`Let’s practice navigating AOSP`***.
    - We can list directories, 
    - search for a service, 
    - grep for keywords, or 
    - find all build files. 
- ***“These commands are what you’ll use daily as an AOSP engineer.”***
</details>


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

<details>
<!-- <summary>Note</summary> -->

- Let’s find the **`Settings app`** source code. — It’s under `packages/apps/Settings`. 
- Now let’s look at the **`Camera HAL`** — it’s in `hardware/interfaces/camera`. 
- *“These are the kinds of searches you’ll do to explore Android.”*
</details>

---

## Understanding the Build System Integration

- Soong (Android.bp) → modern build system.
- Make (Android.mk) → legacy system.
- Ninja → final build execution.
- Build artifacts → stored under `out/`.

<details>
<!-- <summary>Note</summary> -->

- `Soong` is the modern build system with `Android.bp`, 
- `Make` is legacy build system with `Android.mk`, 
- `Ninja` executes the builds. 
- “Everything ends up in the **`out/`** folder — *`system images`*, *`vendor images`*, and *`host tools`*.”
</details>

<details>
<summary>Soong</summary>

### 🛠️ Soong Build System (Android.bp)

- What is Soong?
  - Soong is Android’s next-generation build system, written in Go, designed to replace the old GNU Make–based system (`Android.mk`).
  - It uses declarative `Android.bp` files (Blueprint format, JSON-like syntax).
  - It outputs Ninja build files, which handle the actual compilation.
- Why Soong?
  - AOSP had grown too large for Makefiles to manage efficiently.
  - Soong is faster, easier to maintain, and less error-prone.
  - Clearer syntax, fewer hacks compared to Android.mk.
- How it works (Flow):
  1. You write a module description in `Android.bp`.
  2. The Soong parser (Blueprint) reads it.
  3. Soong generates Ninja build rules.
  4. Ninja executes the build (compiling, linking, packaging).
- Key File Types:
  - `Android.bp` → Blueprint module definitions.
  - `Android.mk` → Legacy Make modules (still supported in some places for backward compatibility).
  - `Blueprints` → Go library used by Soong to parse `Android.bp`.
- Example: Android.bp for a simple library

```bash 
cc_library 
{
    name: "libhello",
    srcs: ["hello.cpp"],
    shared_libs: ["liblog"],
}
```

- Example: Android.bp for an app

```bash
android_app 
{
    name: "HelloWorld",
    srcs: ["src/**/*.java"],
    manifest: "AndroidManifest.xml",
}
```

- Key Advantages:
  - `Declarative` → You just declare what the module is, not how to build it.
  - `Modular` → Each component can be defined independently.
  - `Cross-platform` → Soong supports host tools, target builds, and multiple architectures.
- Important Directories for Soong:
  - `build/soong/` → Core implementation.
  - `Android.bp` files → Scattered across nearly every module (frameworks, packages, hardware).
  - `soong_ui.bash` → Entry point when you run m or mm.

👉 How to explain during your talk:
“Android used to rely heavily on Makefiles (Android.mk), but with the project’s size, Make became slow and messy. Google introduced Soong, a modern build system based on Android.bp files. These files are clean, JSON-like, and easier to read. Soong converts them into Ninja build files, and Ninja does the actual heavy lifting. So basically: Android.bp → Soong → Ninja → binaries.”

</details>

<details>
<summary>Ninja</summary>

- 🔧 **What is Ninja?**
  - Ninja is a low-level build execution tool (like `make`, but much faster).
  - It does not decide what to build → instead, it just executes build steps.
  - It relies on higher-level tools (like Soong or Make) to generate its build files (`.ninja` files).

- 🔄 **Flow: Android.bp/Android.mk** → Soong/Make → Ninja
  1. Developers write `Android.bp` (Soong) or `Android.mk` (Make).
  2. Soong (or Make) parses these files and decides build rules.
  3. Soong generates `.ninja` build definitions inside the `out/` folder.
      - Example: `out/soong/build.ninja`
  4. Ninja executes those rules to compile source code into `.o` files, `.apks`, `.imgs`, etc.

- 🚀 Why Ninja?
  - Speed: It’s designed for large projects (like AOSP with millions of lines of code).
  - Parallelism: Builds multiple files at once efficiently.
  - Simplicity: Ninja itself doesn’t try to be smart — it just runs commands as described.
  - Reliability: If a file didn’t change, Ninja won’t rebuild it (incremental builds).

- 📂 Where Ninja Fits in AOSP
  - `Android.bp` (Soong input) → gets converted to `out/soong/build.ninja`.
  - `Android.mk` (legacy Make input) → converted into ninja rules via `kati` tool.
  - Ninja executes everything and produces:
    - `system.img`
    - `vendor.img`
    - host tools in `out/host/`

### 🖥 Example Commands
When you build Android:
```bash
# High-level build (invokes soong + ninja)
m
m framework

# You can also call ninja directly:
ninja -f out/combined-aosp.ninja framework
```

Here:
- `m` is a wrapper script → calls Soong → generates ninja files → runs ninja.
- `ninja` actually compiles the code.

### 📝 In a Presentation, You Can Say:
👉 “Think of Ninja as the construction workers. They don’t design the building, they just follow the blueprint. Soong (with `Android.bp`) creates the blueprint (`.ninja` files), and Ninja does the heavy lifting to turn source code into actual binaries.”
</details>




---

## Module Discovery

- Modules are defined in Android.bp/Android.mk.
- Types: apps, libraries, executables, services.

<details>
<!-- <summary>Note</summary> -->

- **`In AOSP, everything is a module`** — an ***`app`***, a ***`library`***, or a ***`HAL`***. 
- Modules are defined in `Android.bp` or `Android.mk`. 
- The build system discovers and compiles them.
</details>

---

## Module Types and Locations

- App Modules → `packages/apps/`
- Library Modules → `frameworks/`, `libcore/`
- HAL Modules → `hardware/interfaces/`

<details>
<!-- <summary>Note</summary> -->

- **Apps** are in `packages/apps/`. 
- **Libraries** are mostly in `frameworks/` and `libcore/`. 
- **HALs** are in `hardware/interfaces/`.
</details>

---

## Build Output Locations

- `out/target/product/<device>/system/` → system image.
- `out/target/product/<device>/vendor/` → vendor image.
- `out/host/linux-x86/` → host tools.

<details>
<!-- <summary>Note</summary> -->

- After a build, 
  - **`images`** are created in: → `out/target/product/<device_name>`. 
    - For example, → `system.img`, `vendor.img`. 
  - **`Host tools`** end up in `out/host/linux-x86/`.”
</details>

---

## Common Patterns

- Services: found in `frameworks/base/services/`.
- Apps: in `packages/apps/`.
- Tests: under `cts/` or `platform_testing/`.
- HALs: under `hardware/interfaces/`.

<details>
<!-- <summary>Note</summary> -->

- When searching in AOSP, you’ll notice patterns:
  - **Services** → `frameworks/base/services/`
  - **Apps** → `packages/apps/`
  - **HALs** → `hardware/interfaces/`
  - **Tests** → `cts/` or `platform_testing/`.
</details>

---

## References and Further Reading

- [Official AOSP Documentation](https://source.android.com/docs)
- [AOSP Source Search](http://newandroidbook.com/)

<details>

- To dive deeper, 
  - use [android source](source.android.com) 
  - or the [AOSP Source Search]. 
- For practical insights, 
  - **'community blogs'** and **'books'** like `Jonathan Levin’s Android Internals are excellent`.
</details>

---

## Alternative Resources

- [LineageOS source tree](https://github.com/LineageOS) → cleaner view of AOSP. 
- [Android Internals Book by Jonathan Levin](http://newandroidbook.com/)
- Community blogs & GitHub repos with annotated AOSP guides.

<details>

- If you find AOSP too huge, 
  - start with LineageOS — it’s a community fork with the same structure but often easier to explore.
</details>

---


### ⚡️' Pro Tip for Delivery:'
- Spend ~2 minutes per slide.
- Use real-world analogies (city map, pipelines).
- Switch to terminal demo mode for the hands-on slides.
- End with resources so the audience knows where to continue learning.