# HomeSecuritySystem

## Overview

This project implements a **Home Security System** on the **Basys 3 FPGA board**. It features a simple security system with configurable modes, a security code, and simulated sensors. The system uses switches to simulate the sensors (motion, window, and door sensors). 

For detailed information, please refer to the [Documentation](Documentation%20Project.pdf).

## Features

- **Modes**: 
  - **Inactive**: All sensors are ignored.
  - **At Home**: Only door and window sensors are monitored.
  - **Off**: All sensors are monitored.

- **Security Code**: A 4-digit code must be entered to change the mode.
  
- **Timer**: A 15-second countdown is active at system startup, after which the code can no longer be entered unless the system is reset.

- **Sensor Simulation**: Motion, window, and door sensors are simulated using switches.

## Components

- **Basys 3 FPGA Board**
- **VHDL Code** for system logic
- **Seven-Segment Display** for showing the security code and countdown timer
- **Clock Divider** and **Reverse Counter** for timing and delays

## Instructions

1. **Start the System**: The 15-second countdown will begin upon startup.
2. **Enter the Security Code**: Enter the 4-digit code during the countdown.
3. **Select Mode**: After entering the code, choose one of the available modes.
4. **Simulate Sensors**: Use switches to simulate different sensor states.
5. **Reset System**: If the countdown expires without entering the code, reset the system.

## Future Development

The system could be enhanced by integrating real sensors, adding alarm features, or linking it to a mobile app for remote control.

---

For further technical details, refer to the [Documentation](Documentation%20Project.pdf).

