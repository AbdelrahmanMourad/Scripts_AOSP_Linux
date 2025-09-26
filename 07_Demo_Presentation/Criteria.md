# Project Architecture planning

## 1) Criteria of Planning:

1. **`Dependencies`** → features that depend on others must come later (e.g., GUI depends on HAL and services).
2. **`Reusability`** → group features that share APIs (e.g., audio services + audio tuning).
3. **`User Value`** → implement the features that give visible benefit first (basic connectivity, audio playback).
4. **`Risk & Effort`** → start with low-risk, low-effort tasks to deliver a quick MVP.
5. **`Extensibility`** → design APIs that can be extended easily in the future.
6. **`Security from day one`** → implement secure boot, permissions, OTA signing early, not later.

---

## 2) Proposed Architecture (from base → advanced)

### **`A — Hardware Abstraction & Low-level`**

- GPIO drivers & events (buttons, encoders, cursors)
- CAN / LIN / UART integration
- I2C / SPI / ADC / PWM for LEDs, sensors, actuators
- Power & thermal management APIs

**Why early?** Every higher-level function depends on stable HALs.

### **`B — Core Platform & System Services`**

- Service registry / manager
- Inter-process communication (Binder services)
- Config store (persistent settings)
- OTA update framework (basic version)
- Logging & diagnostics

### **`C — Connectivity & Networking`**

- Wi-Fi / Bluetooth managers
- Network stack & diagnostics
- Telemetry uploader (HTTP/WebSocket)
- Smartphone projection/integration APIs

### **`D — Multimedia (Audio/Video)`**

- Audio HAL + policy manager
- Basic media player service
- Video playback (if hardware supports it)
- Audio routing (media, phone, navigation prompts)
- Microphone access control

### **`E — UI Layer & App Framework`**

- Minimal GUI host (surface manager)
- App lifecycle manager (install/update/uninstall)
- Basic template UI components
- Input handling (touch, buttons, steering controls)

***(Start with simple MVP GUI, upgrade later to advanced themed GUI.)***

### **`F — Vehicle Integration & Domain Features`**

- Vehicle data model (speed, doors, HVAC, etc.)
- Actuator control (AC, seats, mirrors) with safety checks
- CAN mapping service (ECU signals → APIs)

### **`G — Web Services / Cloud Integration`**

- REST/OAuth clients
- OTA server integration
- Remote config & feature flags

### **`H — AI / Smart Services (Later stage)`**

- Voice assistant + ASR
- NLP/intent resolver
- Vision (driver monitoring)
- Recommendations (music, routes)

### **`I — Security & Privacy`**

- Secure boot + verified OTA
- Permissions model per service
- Data encryption
- Audit logs

### **`J — Testing / CI / Tooling`**

- Unit & integration test harnesses
- Emulation mode (simulate CAN/GPIO)
- Performance dashboards

---

## 3) Example Mapping of Features from Your File

- [X] `Infotainment Systems` → Multimedia + UI
- [X] `Navigation & Maps` → UI + Web Services + GPS HAL
- [X] `Vehicle Integration` → Vehicle model + CAN mapping
- [X] `Safety & Security` → Security + vehicle checks
- [X] `Connectivity` → Networking layer
- [X] `Audio Tuning/DSP` → Multimedia layer
- [X] `GPIO/LED strips` → HAL layer
- [X] `OTA updates` → Core platform + Web services
- [X] `Voice Control` → AI services
- [X] `Remote Diagnostics` → Connectivity + Telemetry + Web

---

## 4) Suggested Milestones (bi-weekly sprints)

### Sprint 0 (Weeks 0–2) — **`Setup`**

- Repo, build system (AOSP), CI pipeline, emulator mode
- Deliverables: scaffold repo, build images, docs

### Sprint 1 (Weeks 1–2) — **`HAL & GPIO`**

- GPIO HAL, button events, LED API
- Deliverables: HAL modules + unit tests

### Sprint 2 (Weeks 3–4) — **`Core Services + OTA basic`**

- Service registry, config store, logging, OTA downloader
- Deliverables: running services + OTA download demo

### Sprint 3 (Weeks 5–6) — **`Connectivity + Audio`**

- Wi-Fi manager, HTTP client, audio HAL + simple player
- Deliverables: connect to Wi-Fi, play audio, upload telemetry

### Sprint 4 (Weeks 7–8) — **`UI MVP`**

- Minimal GUI, templates, input handling
- Deliverables: demo home screen with navigation via buttons

### Sprint 5 (Weeks 9–10) — **`Vehicle Integration`**

- CAN listener, vehicle model, HVAC control demo
- Deliverables: simulated CAN → service mapping

### Sprint 6 (Weeks 11–12) — **`OTA Apply + Diagnostics`**

- Full OTA flow (verify + apply), diagnostics endpoints
- Deliverables: successful OTA update demo

---

## 5) Future Luxury Roadmap (after 12 weeks)

- Advanced GUI (animations, theming)
- Voice assistant (ASR, NLP)
- Advanced multimedia (video, adaptive routing)
- AI features (vision, recommendations)
- Full cloud integration (profiles, analytics)

- [ ] het
- [ ] fakgdm
- [ ] gm
- [ ] fslmgh
- [ ] ad
- [ ]

---

## 6) Practical Advice

- Start from HAL and Core services → they are foundations.
- Provide emulation hooks → dev/testing doesn’t always need hardware.
- Separate logic from UI → services must run headless.
- Version your APIs early.
- Secure OTA and signing must not be delayed.
- Document APIs consistently.

---
