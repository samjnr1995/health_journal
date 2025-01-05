Health Journal Flutter Application

Overview

This is a Flutter-based Health Journal application designed to help users log daily journal entries, track their mood trends, and view historical records. The application leverages Hive for local storage and Provider for state management, ensuring a responsive and efficient user experience.

Features

Core Functionalities

Mood Tracking:

Log daily journal entries with mood ratings.

Categorize moods into predefined levels (e.g., Happy, Neutral, Sad).

Trend Analysis:

Visualize mood trends using interactive line charts.

Highlight specific mood trends with legends.

History Management:

View all journal entries in a historical timeline.

Edit or delete journal entries by index.

Local Storage:

Store data securely using Hive.

Ensures offline accessibility.

Onboarding Flow:

Seamless onboarding experience to guide first-time users.

Skippable for returning users.

Folder Structure

The app follows a modular MVVM architecture, ensuring scalability and maintainability.

my_project/
├── lib/
│   ├── components/       # Reusable UI components
│   ├── models/           # Data models (e.g., JournalEntry)
│   ├── provider/         # State management using Provider
│   ├── dashboard/        # Views and components for the dashboard
│   ├── utils/            # Utility files (e.g., colors, styles)
│   ├── main.dart         # App entry point
│   ├── history/          # History tracking and management
│   ├── journaling/       # Journaling-related views and components
|   |-- route/            # Manages navigation through the app
│   ├── onboarding/       # Onboarding flow and components
│   ├── services/         # Responsible for simulating and managing data fetching
├── test/                 # Unit and widget tests
├── assets/               # Images, fonts, and other assets
├── README.md             # Project documentation
├── pubspec.yaml          # Dependencies and project metadata
└── .gitignore            # Ignored files and folders

API Simulation

The application does not rely on external APIs. Instead, it uses the Random function to generate sample data for testing purposes. Data is simulated as follows:

{
  "steps": 7200,
  "heartRate": 72,
  "lastUpdated": "2024-12-25T10:00:00Z"
}

Getting Started

Prerequisites

Flutter SDK (>=3.0.0)

Dart SDK

Basic knowledge of Flutter development

Installation Steps

Clone the repository:

git clone https://github.com/samjnr1995/health_journal.git

Navigate into the project directory:

cd health_journal

Install dependencies:

flutter pub get

Run the application:

flutter run

Tech Stack

Flutter: Frontend development.

Hive: Local storage.

Provider: State manaKey Screens

Onboarding:

Guides first-time users through app features.

Dashboard:

Displays key metrics and trends.

Journaling:

Allows users to log and view journal entries.

History:

A complete timeline of past journal entries with delete and edit functionality.

Testing

Unit Tests:

Test critical business logic.

Widget Tests:

Verify the UI functionality of individual widgets.

To run tests:

flutter test

Contact

For any inquiries or feedback, feel free to reach out:

Name: Samuel

Email: suduu1995@gmail.com | samjnr18@gmail.com

GitHub: samjnr1995
