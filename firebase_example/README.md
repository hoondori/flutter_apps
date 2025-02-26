# Flutter & Firebase Integration

## Overview

This mini app demonstrates the integration of Flutter with Firebase, focusing on authentication, analytics, event tracking, and memo management.

## Features

1. **Memo Management with Firebase Realtime Database**
   - Display a list of memos in a `GridView`.
   - Tap on a grid item to edit the memo.
   - Long press on a grid item to delete the memo.
2. **Registering an App with Firebase**
   - Set up Firebase and add the app to the Firebase project.
3. **Installing Firebase SDK in Flutter**
   - Configure Firebase in the Flutter app by adding necessary dependencies and setting up authentication.
4. **Sending Events to Firebase Analytics**
   - Track and log user interactions using Firebase Analytics.
5. **Tracking TabView Transitions with Firebase logScreenView**
   - Monitor tab switching events and log them with Firebase Analytics.

## Implementation & Design

### Detecting Route Transitions with RouteAware

To detect screen transitions, we use `RouteAware` in combination with `didChangeDependencies()`:

- `didChangeDependencies()` is called when a widget is newly associated with a parent widget.
- The widget subscribes to `RouteAware` using the `subscribe()` method to monitor route changes.
- This setup ensures that screen appearance and disappearance events are captured.
- In `dispose()`, the subscription is removed using `unsubscribe()` to prevent unnecessary event tracking when the widget is disposed.

### Sending Current Tab Information to Firebase Analytics

When a tab is selected, the event is logged with:

```dart
FirebaseAnalytics.instance.logScreenView(screenName: 'tab name');
```

This records which tab the user has selected, helping track user behavior within the app.

### Managing Memos in Firebase Realtime Database

#### Adding a Memo
To add a new memo to Firebase Realtime Database, use the `push()` method to generate a unique key:

```dart
MaterialButton(
  child: Text('저장하기'),
  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
  onPressed: () {
    widget.reference
        .push()
        .set(Memo(
            titleController!.value.text,
            contentController!.value.text,
            DateTime.now().toIso8601String())
            .toJson())
        .then((_) {
      Navigator.of(context).pop();
    });
  },
);
```

#### Updating a Memo
To update an existing memo, reference its unique key and use the `set()` method:

```dart
MaterialButton(
  onPressed: () {
    Memo memo = Memo(
      titleController!.value.text,
      contentController!.value.text, 
      widget.memo.createTime
    );
    widget.reference
        .child(widget.memo.key!)
        .set(memo.toJson())
        .then((_) {
      Navigator.of(context).pop(memo);
    });
  },
  child: Text('수정하기'),
);
```

#### Deleting a Memo
To delete a memo, use the `remove()` method on the memo reference:

```dart
TextButton(
  onPressed: () {
    _reference!
        .child(memos[index].key!)
        .remove()
        .then((_) {
      setState(() {
        memos.removeAt(index);
        Navigator.of(context).pop();
      });
    });
  },
  child: Text('삭제하기'),
);
```

By implementing these Firebase operations, users can seamlessly add, update, and delete memos within the app.

