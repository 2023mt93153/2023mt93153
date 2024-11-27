QuickTask Flutter App
QuickTask is a simplified task management app designed to teach Flutter and Back4App integration. This app allows users to manage tasks, toggle task completion status, and view or delete tasks, with a focus on practical implementation.

Features
Task Management: Add, view, and delete tasks.
Toggle Status: Mark tasks as completed or incomplete.
Backend Integration: Uses Back4App for database operations.
Periodic Updates: Auto-fetch tasks every 30s.

Setup Instructions

Prerequisites
Install Flutter.
Install a code editor, such as Visual Studio Code.
Create a Back4App project and configure the database with the Task schema.

Installation
Clone this repository:

bash
Copy code
git clone <repository-url>
cd quicktask
Install dependencies:

bash
Copy code
flutter pub get
Add the http package to your pubspec.yaml file:

yaml
Copy code
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2 # For state management
  cloud_firestore: ^4.4.3 # Back4App integration
  firebase_auth: ^4.5.0 # Authentication
  http: ^1.1.1
  #flutter_datetime_picker: 1.5.1 # For date picker
Then, fetch dependencies:

bash
Copy code
flutter pub get
Backend Configuration
Log in to your Back4App account.

Create a new app and add a Task class with the following fields:
title (String)
dueDate (Date)
status (Boolean)
Retrieve your Application ID and REST API Key from the Back4App Dashboard under App Settings > Security & Keys.

Replace the placeholders in task_provider.dart with your credentials:

dart
Copy code
const String applicationId = "your-app-id";
const String restApiKey = "your-rest-key";
const String serverUrl = "https://parseapi.back4app.com/classes/Task";
