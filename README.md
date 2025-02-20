
### **🖥️ DWM Auto-Install Scripts**
This repository contains scripts to **automatically install and configure DWM** on various Linux distributions.  

#### **📌 Supported Distros**
- ✅ Fedora (**Ready!** ✅ [One-liner available](#fedora-installation))  
- 🔄 Debian (**Coming Soon**)  
- 🔄 Arch Linux (**Coming Soon**)  

---

## **📦 Installation**
### **Fedora Installation**
Use this **one-liner command** to install DWM on Fedora:  
```sh
curl -sL https://tinyurl.com/myfedora-dwm | bash
```
🔹 **What This Does:**  
- Installs `dwm`, `st`, and `dmenu`  
- Prompts for **Display Manager (GDM, LightDM, SDDM, or No DM)**  
- Sets up `startx` if no DM is chosen  
- Creates a proper `dwm.desktop` session file  

---

### **🚀 Other Distros**
#### **Debian (Coming Soon)**
Once ready, install with:  
```sh
curl -sL <Debian-TinyURL> | bash
```

#### **Arch Linux (Coming Soon)**
Once ready, install with:  
```sh
curl -sL <Arch-TinyURL> | bash
```

---

## **💡 Notes**
- If you **don't install a display manager**, log in via **TTY** and run:  
  ```sh
  startx
  ```
- For issues or improvements, feel free to **open a pull request**!  

---

This **README** will stay updated as you add scripts for **Debian and Arch**. Let me know if you want changes! 🚀
