# Health Information System

## Overview
A basic Health Information System developed using Flutter, following an API-first approach. The system allows doctors to:
- Register new clients (patients)
- Create new health programs (e.g., TB, Malaria)
- Enroll clients into programs
- Search for clients
- View client profiles and enrolled programs
- Expose client profile information via a local API

## Technologies Used
- Flutter (Frontend + Local Backend)
- Provider (State Management)
- Shelf & Shelf Router (API server for local API exposure)
- Dart programming language
- Postman (for API testing)

## How to Run the Application
1. **Install Flutter SDK**
2. **Navigate to the project directory**
```bash
cd health_info_system
```
3. **Get project dependencies**
```bash
flutter pub get
```
4. **Run the application**
```bash
flutter run
```

## API Usage
- API Server runs locally on:
```
http://localhost:8082
```
- API Endpoint to retrieve a client profile:
```
GET /client/{client_id}
Example: http://localhost:8082/client/123abc
```
- Response:
```json
{
  "id": "123abc",
  "name": "John Doe",
  "age": 25,
  "enrolledPrograms": [
    {"id": "1", "name": "TB"},
    {"id": "2", "name": "Malaria"}
  ]
}
```

## Project Structure
```
lib/
|-- models/
|   |-- client.dart
|   |-- program.dart
|
|-- providers/
|   |-- health_provider.dart
|
|-- screens/
|   |-- home_screen.dart
|   |-- add_client_screen.dart
|   |-- add_program_screen.dart
|   |-- client_profile_screen.dart
|
|-- api_server.dart
|-- main.dart
```

## Future Improvements
- Connect with a real database like Firebase
- Add authentication and security layers
- Deploy the API server on cloud platforms like Render or Heroku
- Add more validations and input checks

---

Prepared By: [Sebastian Mutua]  
Submission Date: [26-04-2025]  
Assignment: Software Engineering Task

