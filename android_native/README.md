#  Flutter Native API Integration Example

## Overview
This Flutter project demonstrates how to call Android native APIs using `MethodChannel`. The `NativeApp` widget establishes a `MethodChannel`, while the `MainActivity` in `android/app/src/main/kotlin/` implements multiple methods for native functionality.

## Features
1. **Get Device Information**: The `getDeviceInfo` method accesses the Android `Build` object to retrieve device name, brand, model, and more.
2. **Encrypt & Decrypt Text**: The `getEncrypt` and `getDecrypt` methods send user-input text to Android's `Base64` utility for encryption and decryption.

## Implementation & Design
- **MethodChannel Usage**:
    - `MethodChannel` is used in Flutter to communicate with the native Android code.
    - The channel allows calling platform-specific methods from Dart.
- **Configuring `MainActivity`**:
    - `configureFlutterEngine` is overridden in `MainActivity` to set up the `MethodChannel`.
    - The native implementation processes method calls and returns results to Flutter.

## Key Components & Concepts
- **`MethodChannel`** → Enables communication between Flutter and Android native code.
- **`configureFlutterEngine`** → Used in `MainActivity` to register the method channel.
- **Android `Build` API** → Retrieves device information.
- **Android `Base64` Utility** → Handles text encryption and decryption.
