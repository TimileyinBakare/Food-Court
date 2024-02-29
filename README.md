# Foodcourt_task
# Weather App
This is a weather app built using Flutter that allows users to check the current weather of different cities, including the option to use the current location. The app follows the MVVM architecture pattern, utilizes the repository pattern for data management, and incorporates various packages for testing, location services, logging, animations, and environment variables management.

# Architecture
The app follows the MVVM (Model-View-ViewModel) architecture pattern for a clean separation of concerns. The ViewModel serves as an intermediary between the View (UI) and the Model (data).

# Design Pattern
The repository pattern is used for data management. It abstracts the data layer, providing a consistent interface for data access regardless of the data source (e.g., API, local database).

# Features
City Selection: Users can choose from a list of 15 cities, including Lagos (default selection), Abuja, Port Harcourt, and others.
Weather Display: Weather data for selected cities is displayed in a carousel/tab view.
Add/Remove Cities: Users can add or remove cities from the carousel/tab view.
Persistence: The list of cities in the carousel/tab view is persisted using shared preferences. This ensures that the list remains the same even after the app is closed and reopened.
Current Location: Users can use their current location to display weather information. This feature detects the user's geolocation and calls the API using longitude and latitude.

# Testing
Unit Test: Unit tests are implemented using the Mockito package to ensure the correctness of individual components.

# Packages Used
geolocator: Used for getting the device's current location.
logger: Utilized for logging error messages and other relevant information.
anime.do: Used for bounce animations to enhance the user interface.
dotenv: Utilized for managing environment variables.
shared_preferences: Used for persisting the state of the city selection.

#How to Run
To run the app:

Clone the repository.
Set up the environment variables using the .env file.(For foodcourt it was ignored in gitignore so its visible)
Run the app on your preferred device or emulator.


Contact
For any inquiries or feedback, please contact bakaretim18@gmail.com


# FoodCourtChallenge
# Food-Court
