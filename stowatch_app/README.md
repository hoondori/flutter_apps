# Stopwatch App

## Overview
The **Stopwatch App** is a Flutter-based mobile application that provides precise time tracking in milliseconds. Users can start, pause, and reset the stopwatch while recording lap times. Each recorded lap time is displayed in a structured list for easy reference.

## Features
- **Accurate Time Tracking:** Stopwatch operates in milliseconds for high precision.
- **Lap Time Recording:** Users can capture lap times at the exact moment they press the lap button.
- **Reset Functionality:** Stopwatch and lap records can be reset to start fresh.

## Design & Implementation

### **1️⃣ Time Management with `Timer`**
- The `Timer` object is used to handle real-time stopwatch functionality.
- Ensures smooth and precise time tracking with minimal delay.

### **2️⃣ Flexible UI with `Stack` and `Positioned`**
- `Stack` and `Positioned` are used to place UI components at absolute positions.
- Provides a flexible layout design, enhancing the user experience.

## Tech Stack
- **Framework:** Flutter
- **Language:** Dart
- **Widgets Used:** `Timer`, `Stack`, `Positioned`, `ListView`