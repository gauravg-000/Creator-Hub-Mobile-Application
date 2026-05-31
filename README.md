# Creator Hub Mobile Application

A mobile app built with Flutter, GetX, and Firebase, using a clean MVC-inspired architecture. The project includes authentication, a social feed, real-time chat, and a product checkout experience.

## Tech Stack

* Flutter (Dart)
* State Management: GetX
* Backend: Firebase Authentication + Cloud Firestore
* Architecture: MVC-style separation of controllers, models, and views

## Key Features

### 1. Authentication
* Email/password login and signup flow.
* Form validation with email format and password length checks.
* Session persistence using Firebase Auth state.

### 2. Social Feed
* Real-time feed powered by Firestore snapshots.
* Users can publish text posts with optional image URLs.
* Like/unlike interaction updates in real time.

### 3. Real-Time Chat
* One-to-one direct messaging between registered users.
* Live message updates with Firestore snapshots.
* Chat room header displays the current recipient name.
* Unread message badge shown on each user card in the chat list.

### 4. Product Listing + Checkout
* Firestore-backed product catalog with image, title, and price.
* Add new product listings via a modal form.
* Mock checkout flow with shipping details, payment selection, and confirmation.

### 5. UI & Error Handling
* Loading indicators for data fetch operations.
* Empty states for no posts, no users, or no products.
* Snackbars and dialogs for error and success feedback.

## Project Structure

```text
lib/
├── controllers/
│   ├── auth_controller.dart
│   ├── chat_controller.dart
│   ├── checkout_controller.dart
│   ├── feed_controller.dart
│   ├── network_controller.dart
│   └── product_controller.dart
├── models/
│   ├── message_model.dart
│   ├── post_model.dart
│   ├── product_model.dart
│   └── user_model.dart
├── views/
│   ├── home_navigation_view.dart
│   ├── auth/
│   │   ├── login_view.dart
│   │   └── signup_view.dart
│   ├── chat/
│   │   ├── chat_list_view.dart
│   │   └── chat_room_view.dart
│   ├── feed/
│   │   └── feed_view.dart
│   └── products/
│       ├── add_product_view.dart
│       ├── checkout_view.dart
│       ├── payment_success_view.dart
│       └── product_list_view.dart
└── main.dart
```

## Setup Instructions

### Prerequisites
* Flutter SDK installed
* Connected device or running emulator
* Firebase project configured

### Run the Project
1. Clone the repository:

```bash
git clone https://github.com/gauravg-000/Creator-Hub-Mobile-Application.git
cd techworld_assignment
```

2. Install dependencies:

```bash
flutter pub get
```

3. Configure Firebase using FlutterFire CLI if needed:

```bash
dart pub global run flutterfire_cli:flutterfire configure
```

4. Run the app:

```bash
flutter run
```


