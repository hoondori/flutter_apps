# To-Do Management Application

## Overview
The **To-Do Management App** is a Flutter-based productivity tool designed to help users efficiently manage their daily tasks. The app allows users to add, complete, and delete tasks seamlessly while maintaining a clean and user-friendly interface.

## Features
- **Task List Display:** View all pending and completed tasks in an organized list.
- **Task Addition:** Easily add new tasks to the list.
- **Task Completion:** Mark tasks as completed by clicking on them.
- **Task Deletion:** Remove tasks from the list by clicking the trash icon.

## Design & Implementation

### **1️⃣ Responsive Layout with `Expanded`**
- `Expanded` is used within `Row`, `Column`, and `Flex` to efficiently utilize available space.
- Ensures a dynamic and adaptive UI across various screen sizes.

### **2️⃣ Conditional UI Rendering with Ternary Operator (`? :`)**
- Uses a ternary operator to switch between different widget states.
- Dynamically updates UI when a task is marked as complete or incomplete.

### **3️⃣ Firestore Integration for Persistent Data Storage**
- Tasks are stored in Firestore, providing real-time sync and cloud-based data management.
- Ensures data persistence across app sessions.

## Tech Stack
- **Framework:** Flutter
- **Language:** Dart
- **Database:** Firestore (Cloud Firestore)
- **Widgets Used:** `Expanded`, `ListView` 