# 📚 SELinux Policies in Android AOSP — Study Notes

## 🥪 Overview (The Top Bread)

SELinux (Security-Enhanced Linux) is a mandatory access control system integrated into Android to enforce strict security rules. 
In AOSP, **`SELinux policies define who can do what`**— from apps to system services to hardware access.
- These notes will guide you through:
- What SELinux is and why it matters
- How it's structured in Android
- Folder and file layout in AOSP
- Roles and workflows for developers
- How all the pieces fit together

--- 
## 🍖 Core Content (The Filling)

### 🔐 What is SELinux?

<details>
<summary>👶 For Kids</summary>
Imagine your phone is a big school. SELinux is the teacher who makes sure every student (app) follows the rules and doesn’t sneak into places they shouldn’t.
</details>
<details>
<summary>🧑 For Beginners</summary>
SELinux is a kernel-level security module that enforces access control policies. In Android, it ensures apps and services only access what they're allowed to, reducing the risk of exploits.
</details>
<details>
<summary>👨‍💻 For Professionals</summary>
SELinux implements MAC (Mandatory Access Control) via labeled objects and domains. Android uses SELinux to sandbox processes, enforce least privilege, and protect system integrity. Policies are compiled into binary format and loaded during boot.
</details>

---
### 📁 Folder Structure in AOSP

<details>
<summary>👶 For Kids</summary>
Think of folders like toy boxes. Each box has special toys (files) that tell the phone how to behave safely.
</details>
<details>
<summary>🧑 For Beginners</summary>

- **SELinux policies are stored in specific directories:**
  - `system/sepolicy/`: Core AOSP policies
  - `device/<vendor>/<board>/sepolicy/`: Device-specific policies
  - `vendor/<vendor>/sepolicy/`: Vendor customizations
- **Key file types:**
  - `*.te`: Type Enforcement rules (who can do what)
  - `file_contexts`: Maps file paths to labels
  - `service_contexts`: Maps services to domains
  - `property_contexts`: Maps system properties to labels
  - `genfs_contexts`: Labels for virtual filesystems
</details>
<details>
<summary>👨‍💻 For Professionals</summary>

- Policy compilation uses m4 macros and merges public/private partitions:
  - `BOARD_VENDOR_SEPOLICY_DIRS`: Device policy injection
  - `SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS`, `PRODUCT_PRIVATE_SEPOLICY_DIRS`: Partition-specific overrides
  - Final policy: 
    - `out/target/product/<device>/obj/ETC/vendor_sepolicy.conf_intermediates/vendor_sepolicy.conf`
- References:
  - [AOSP SELinux Implementation Guide](https://source.android.com/docs/security/features/selinux/implement) , [SEPolicy README](https://android.googlesource.com/platform/system/sepolicy/+/master/README.md)
</details>


---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>
<details>
<summary>👨‍💻 For Professionals</summary>

</details>

---
### 

<details>
<summary>👶 For Kids</summary>

</details>
<details>
<summary>🧑 For Beginners</summary>

</details>



















<details>
<!-- <summary>Note</summary> -->

</details>

---
