# BMI Calculator

## Overview
The **BMI Calculator** is a Flutter-based mobile application that allows users to calculate their Body Mass Index (BMI) by inputting their height and weight. The app visualizes the BMI result using satisfaction/dissatisfaction icons to provide an intuitive understanding of the classification.

## Features
- **BMI Calculation:** Users enter their height and weight, and the app calculates their BMI instantly.
- **Visual Representation:** The BMI category is displayed with satisfaction/dissatisfaction icons for better clarity.

## Design & Implementation

### ** Efficient Input Handling with `TextEditingController`**
- `TextEditingController` is used to manage user input dynamically.
- It enables real-time updates and easy manipulation of the entered values.

### ** Structured Form Input with `TextFormField`**
- Uses `TextFormField` to ensure an responsive input experience.
- `keyboardType` is set to `TextInputType.number` to restrict input to numeric values only.
- Includes input validation to prevent incorrect or missing values.

## Tech Stack
- **Framework:** Flutter
- **Language:** Dart
- **Widgets Used:** `TextEditingController`, `TextFormField`, `Row`, `Column`, `ElevatedButton`  
