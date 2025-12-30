# SingleInstance
A Qt 6 / QML application that ensures only a **single instance** of the app runs at any time.

---

## ✨ Features

- Prevents multiple instances from running simultaneously.
- Lightweight and cross-platform (Windows, Linux, macOS).
- Smooth UI with effects and theming support.

---

## 🛠 Tech Stack

- **Language:** C++
- **UI:** Qt Quick / QML
- **Framework:** Qt 6
- **Build System:** CMake
- **Platform:** Windows (primary), Linux, macOS
- **Extras:** Single-instance protection via `QSharedMemory` + `QSystemSemaphore`.

---

## 📦 Requirements

- Qt 6.x

---

## 🔧 Build Instructions

Clone the repository and build using CMake:

```bash
git clone https://github.com/Saif-k93/SingleInstance.git
cd SingleInstance
cmake -S . -B build
cmake --build build
For Windows (MSVC):

bash
Copy code
cmake -S . -B build -G "Visual Studio 17 2022"
cmake --build build --config Release
▶️ Run
Run the generated executable from the build directory.
The app will prevent opening multiple instances and show a message if another instance is already running.

## 📸 Screenshots

<img width="412" height="332" alt="Screenshot 2025-12-30 201347" src="https://github.com/user-attachments/assets/5c70f5d8-762e-4a15-836a-7629eeac2ddc" />
<img width="412" height="332" alt="Screenshot 2025-12-30 201410" src="https://github.com/user-attachments/assets/7cea8770-07da-423a-99fd-0dcfe2c1b904" />

## 🤝 Contributing

Contributions are welcome.
Please open an issue or submit a pull request.

## 📬 Contact

Created by Saif
GitHub: https://github.com/Saif-k93

