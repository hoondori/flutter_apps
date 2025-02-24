# Animal List Management

## Overview
This App is a simple application for managing an animal list. Users can view the list of animals and register new ones. The app consists of two tabs, allowing users to easily add and check data.

---

## 1. Features
- **Animal List Page**: Displays the registered animal list.
    - Uses `ListView` to efficiently display multiple items.
    - Replaces `Row`/`Column` with `ListView` to ensure proper display without content being cut off.
- **New Animal Registration Page**: Allows users to add new animals.
- **Tab Navigation**: Implements tab transitions using `TabController`.
- **Data Sharing**: Shares `List` data between the two tabs so that newly registered animals immediately appear in the list.

---

## 2. Design Considerations
- **Tab-Based Navigation**: Utilizes `TabBar` and `TabBarView` for smooth transitions between pages.
- **Optimized User Experience (UX)**:
    - Implements `ListView` for scrollable and readable content.
    - Provides a clean UI with `TextField` and `ElevatedButton`.
- **Animation Performance Optimization**: Uses `SingleTickerProviderStateMixin` for improved animation performance.

---

## 3. Key Widgets & Important Details
### (1) **TabController & Animation Management**
- Implements `TabController` for seamless tab transitions.
- Extends `SingleTickerProviderStateMixin` and assigns `vsync: this` to optimize animations.
    - Prevents unnecessary animation execution to improve performance.
    - Ensures that animations do not consume resources when off-screen.

### (2) **Tab Navigation Widgets**
- Uses `TabBarView` and `TabBar` to create an intuitive UI.
- Shares data between tabs to ensure that registered animals appear immediately in the list.

### (3) **List UI Implementation**
- Uses `ListView` instead of `Row`/`Column` to dynamically display lists.
    - Ensures automatic scrolling for long lists.
    - Prevents items from being cut off regardless of screen size.


