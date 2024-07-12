# spendsmart
Your Personal Expense Manager

SpendSmart is a Flutter application designed to help you manage your expenses effectively.

## Setup Instructions

### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0.0 or higher).
- You have a code editor such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
- You have an emulator or a physical device to run the application.

### Installation

1. **Clone the repository:**

   git clone https://github.com/roshanjoyp/spendsmart.git

   cd spendsmart

2. **Install dependencies:   

    flutter pub get

3. Connect emulator or physical device
4. Run the application

SpendSmart - Detailed Project Report

Overview

SpendSmart is a Flutter application designed to help users keep track of their personal finances. It is a completely offline app, meaning it does not require an internet connection for any of its currently developed features.

Features

Views

	1.	Startup View (Splash View)
	    •	Displays the app logo and initializes the app.
	2.	Language and Currency Selection View
	    •	Allows users to select their preferred language and currency.
	3.	Home View
	    •	Consists of the following subviews:
	    •	Expense View
	        •	Shows a list of user-added expenses.
	        •	Provides a daily summary.
	        •	Includes options to filter expenses based on date range and to clear filters.
	        •	Allows users to tap on an expense to edit, update, or delete the entry from the expense detail view.
	        •	Features a floating action button to add new expenses, directing users to the expense detail view.
	        •	Utilizes a sliver list with pull-to-refresh functionality.
	    •	Expense Details View
	        •	Used for adding new expenses, updating existing ones, or deleting expenses.
	        •	Currently, expenses can only be deleted from this view.
	        •	Includes basic form field validations, with more validations to be added.
	    •	Summary View
	        •	Displays a monthly summary along with the percentage contribution of each expense type/category towards that month’s total expenses.
	        •	Utilizes a sliver list with pull-to-refresh functionality.
	    •  Settings View
	         •	Allows users to change language and currency settings.
	         •	Provides an option to turn notifications on or off (scheduled notifications are working, but there is a bug where notifications do not show based on 
                the selected notification time; instead, they show daily at the time they were turned on).
	         •	Saves notification time settings.
	         •	Offers an option to generate mock data (requires pull-to-refresh or app restart to see changes).
	         •	Includes an option to delete all data and start over.

Technical Details

	•	Local Database: Uses Hive for local data storage.
	•	State Management: Utilizes the Stacked architecture template by FilledStacks, featuring meaningful folder structures and provider for state management.
	•	Animations: Employs the flutter_animate package for smooth animations on the language screen.
	•	Internationalization: Almost fully implemented, with extensive internationalization throughout the app. However, notification messages are
        not yet internationalized.
	•	Number Formatting: Expense amounts are formatted using the selected currency and locale.

Development Insights

	•	Extensively used ChatGPT-4 for code logic generation, refactoring, and generating unit tests.
	•	Need to significantly increase focus on writing and improving unit tests.
    •   Option to improve UI code by making more generalized common widgets and following a component based approach.

Future Implementations

	1.	Onboarding Screen
	2.	App Icon/Logo
	3.	Notification Bug Fix
	4.	Filter by Type and Description in Expense View
	5.	More Detailed Summaries
	6.	Authentication Features (e.g., Screen/App PIN Lock)
	7.	Data Import/Export
	8.	UI/UX Cleanup and Refinement
