# Home Security System 🏡

Welcome to the **Home Security System**, a project implemented on the **Basys 3 FPGA board**.  
This system simulates a simple yet effective home security setup with configurable modes, a security code, and sensor simulation using switches.

---

# Overview 📖

Upon starting the system, users are greeted with a **15-second countdown**, during which they must enter a **4-digit security code**.  
Once authenticated, users can select the desired security mode and simulate sensor states using the board's switches.

📄 **More detailed explanations and technical information can be found in the project documentation.**

---

# Features 🪄

- **Modes**:
  - **Inactive**: All sensors are ignored.
  - **At Home**: Only door and window sensors are monitored.
  - **Off**: All sensors are monitored.

- **Security Code**: A 4-digit code must be entered during the countdown to unlock mode selection.

- **Timer**: A 15-second countdown starts when the system powers on. After expiration, code entry is disabled unless reset.

- **Sensor Simulation**: Motion, window, and door sensors are simulated using board switches.

---

# Components 🛠

- **Basys 3 FPGA Board**
- **VHDL Code** for the system logic
- **Seven-Segment Display** for showing the security code and countdown timer
- **Clock Divider** and **Reverse Counter** for timing and delays

---

# Instructions 🧭

1. **Start the System**: The 15-second countdown will begin upon startup.
2. **Enter the Security Code**: Input the 4-digit security code before the countdown expires.
3. **Select Mode**: After successful code entry, choose between Inactive, At Home, or Off modes.
4. **Simulate Sensors**: Use the board's switches to simulate motion, window, and door sensors.
5. **Reset System**: If the countdown expires, reset the system to retry.

---

# Future Development 🚀

Potential enhancements include:
- Integrating real physical sensors
- Adding alarm and notification features
- Developing a mobile app for remote control and monitoring
