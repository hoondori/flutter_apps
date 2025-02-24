# Book Search

## Overview
This Mini App utilizes the Kakao Developers API to fetch book information and display it in a list format. Users can search for books by entering keywords, and results are updated dynamically as they scroll.

---

## 1. Features
- **Book Search**: Fetches book data from the Kakao API, including title, author, and thumbnail.
- **Infinite Scrolling**: Loads additional book data in real time as the user scrolls.
- **Search Bar**: Allows users to enter search queries and fetch relevant book results.

---

## 2. Implementation & Design
- **HTTP Requests**: Uses the `http` module to fetch data from the Kakao API.
- **JSON Parsing**: Utilizes `dart:convert` to parse JSON responses and extract necessary data.
- **Search Input**: Implements `TextEditingController` to handle user input for searching books.
- **Scroll Handling**: Uses `ScrollController` to detect when the user reaches the bottom of the list and fetches the next page of results.

---

## 3. Key Widgets & Important Details
### (1) **ScrollController**
- Manages infinite scrolling functionality.
- Detects when the user reaches the bottom of the list and triggers the API call for the next page.
- Ensures smooth data fetching and user experience.