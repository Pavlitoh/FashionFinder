![imagen](https://github.com/user-attachments/assets/a4d32bf8-763b-47f1-a04e-222871d24843)


# FashionFinder Flutter App

The **FashionFinder Flutter App** is a mobile application that helps users find and explore fashion stores, products, and branches with seamless geolocation functionality. Built with Flutter, this app is designed for both Android and iOS platforms, providing a user-friendly interface and robust performance.

---

## Geo-Referenced Systems

### **Team Members**
- **Becerra Díaz Alejandro**  
- **González Hernández Juan Pablo**  
- **Núñez Guerrero Melanie Guadalupe**  
- **Peña Bravo María Cecilia**  
- **Trujillo Ramírez César Andrés**  

#### **Professor**  
Frausto Ramírez Juan de Dios  

#### **Date:**  
11/12/2024  
##### **Program:**  
Software Engineering and Computational Systems - 712  

---

## 📖 Table of Contents

1. [Features](#features)
2. [Getting Started](#getting-started)
3. [Prerequisites](#prerequisites)
4. [Installation](#installation)
5. [Environment Configuration](#environment-configuration)
6. [Folder Structure](#folder-structure)
7. [Usage](#usage)
8. [Screens](#screens)
9. [Technologies](#technologies)
10. [Contributing](#contributing)
11. [License](#license)

---

## ✨ Features

- **User Authentication**: Login and register functionality.
- **Search and Filtering**: Find stores, products, and branches using dynamic search and category filters.
- **Geolocation Integration**: Display branches on a map, with user location tracking.
- **Responsive Design**: Optimized for both Android and iOS devices.
- **Interactive UI**: Navigate through stores, categories, and products with a clean and intuitive design.

---

## 🚀 Getting Started

Follow these instructions to set up the project on your local machine for development and testing.

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install) (version >= 3.0.0).
- **Dart SDK**: Comes with Flutter installation.
- **Code Editor**: [VS Code](https://code.visualstudio.com/) (recommended) or [Android Studio](https://developer.android.com/studio).
- **Device Emulator**: Android Emulator or iOS Simulator.

---

## 🛠️ Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Pavlitoh/FashionFinder.git
   cd FashionFinder/flutter_app
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   - For Android:
     ```bash
     flutter run
     ```
   - For iOS:
     ```bash
     flutter run --release
     ```

---

## ⚙️ Environment Configuration

The app uses environment variables for API endpoints and third-party services. Create a `.env` file in the `lib/config` directory:

```env
# API Configuration
API_BASE_URL=https://fashionfinder.ddns.net/api

# Geolocation API Keys
GOOGLE_MAPS_API_KEY=your_google_maps_api_key
```

Replace `your_google_maps_api_key` with your actual Google Maps API Key.

---

## 📁 Folder Structure

The project follows a feature-based structure:

```plaintext
lib/
│
├── config/          # Environment variables and app-wide configuration
├── models/          # Data models for stores, products, branches, etc.
├── services/        # API service layer
├── providers/       # State management (e.g., Riverpod or Provider)
├── screens/         # UI screens for login, home, search, and more
├── widgets/         # Reusable UI components
├── utils/           # Helper functions and utilities
├── main.dart        # App entry point
```

---

## 🖥️ Usage

1. Launch the app on an emulator or physical device.
2. Explore the following key features:
   - **Login/Register**: Access your account or create a new one.
   - **Search**: Filter stores and products by categories.
   - **Map View**: Locate branches on a map using GPS.
   - **Product Details**: View detailed descriptions of products.

---

## 📱 Screens

The app includes the following screens:

- **Register and Login Screen**: User authentication for clients and admins.
![imagen](https://github.com/user-attachments/assets/f73fa15f-bab3-4202-a632-4746eea8f100)
![imagen](https://github.com/user-attachments/assets/5887c285-7981-448a-a020-0cbb3f8e167f)

- **Home Screen**: Display of featured stores, categories, and products.
- **Category Filter and CRUD**: Explore stores and products by category with CRUD for admin.
![imagen](https://github.com/user-attachments/assets/179c1643-2876-40cc-914d-c963d2f33d7e)

- **Store Details, CRUD, and Locator**: Map view showing branches and user location with CRUD for admin.
![imagen](https://github.com/user-attachments/assets/8ce1d9ca-d4d1-498a-beb3-284b93ddf08b)
![imagen](https://github.com/user-attachments/assets/7c65668c-7dff-4126-8ce3-78ff931fbe57)
![imagen](https://github.com/user-attachments/assets/b36b3fcf-1ec9-49ae-9347-4c59e6dce2b9)
![imagen](https://github.com/user-attachments/assets/10f6a3f1-a1f2-424f-8afa-c79e2ff0c788)

- **Product list, details and CRUD**: In-depth view of individual product details with CRUD for admin.
  ![imagen](https://github.com/user-attachments/assets/aa3cb81f-aa68-4072-854c-6be7411a662b)
  ![imagen](https://github.com/user-attachments/assets/e6f84e17-fa86-4fd7-aa29-c90eaf0a1807)
  ![imagen](https://github.com/user-attachments/assets/8849d6e8-e176-415b-9e9f-4837377dd0f3)

---

## 💻 Technologies

The FashionFinder Flutter App uses the following technologies:

- **Flutter**: Framework for building natively compiled applications for mobile.
- **Dart**: Programming language used for Flutter.
- **Google Maps API**: For geolocation and branch mapping.
- **Firebase**: For analytics and push notifications (if configured).
- **REST APIs**: Backend integration for dynamic data.

---

## 🤝 Contributing

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your feature description"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Submit a pull request.

---
