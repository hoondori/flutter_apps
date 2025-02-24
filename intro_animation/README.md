# Intro-Page Animation

## 🌟 Overview
a Flutter app that opens with an animation of Saturn orbiting the Sun before transitioning seamlessly to the main page. 

## ✨ Features
1. **Intro Page Animation**: Saturn orbits around the Sun in a realistic 5-second animation.
2. **Automatic Page Transition**: After the animation completes, the app navigates to the main page automatically.

## 🎨 Implementation & Design
- **Layering with Stack**: The scene consists of three images—Saturn, the Sun, and its orbital path—arranged in a `Stack` widget.
- **Rotation Animation**: Saturn's revolution is achieved using:
    - `AnimationController`
    - `Tween` animation
    - `AnimatedBuilder`
- **Automatic Navigation**: A 5-second `Timer` in `initState` triggers a transition to the main page using `Navigator.pushReplacement()`.
