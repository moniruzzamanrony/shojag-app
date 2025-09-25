# Shojag

Shojag is a location-based alert and tracking app that notifies users when they enter or leave assigned locations. It also allows tracking friends and family (FnF) in real-time.

## Tech Stack
- Flutter (v3.35.4)
- Dart (v3.9.2)
- Provider [provider] (+ Riverpod [flutter_riverpod] - fnf part only) for state management
- Dio [dio] for networking
- Hive (Community Edition) [hive_ce] for local storage
- Firebase Cloud Messaging (FCM) for push notifications
- Mapbox [mapbox_maps_flutter] for map
- Geolocator [geolocator] for location services
- Workmanager [workmanager] for periodic task
- Background Location Tracker [background_location_tracker] for background location
- GoRouter [go_router] for navigation

## Project Structure
```
lib/
  ├── core/             # Core functionalities
  │   ├── config/       # App configuration
  │   │   ├── provider/ # State management
  │   │   ├── router/   # Navigation
  │   │   ├── theme/    # Theme settings
  │   ├── database/     # Local storage (Hive)
  │   ├── error/        # Error handling
  │   ├── network/      # API handling
  │   ├── notification/ # Notifications
  │   ├── usecase/      # Business logic
  │   ├── utils/        # Helpers and utilities
  ├── features/         # Feature-specific modules
  │   ├── alert/
  │   │   ├── data/        # Models, repositories, and services
  │   │   ├── domain/      # Entities, repositories, and use cases
  │   │   ├── presentation/ # UI pages, providers, and widgets
  │   ├── about_us/
  │   ├── alert_map/
  │   ├── auth/
  │   ├── consent/
  │   ├── dashboard/
  │   ├── feedback/
  │   ├── fnf/
  │   ├── home/
  │   ├── profile/
  │   ├── premium/
  │   ├── response/
  │   ├── settings/
  ├── shared/           # Reusable components
  ├── l10n/             # Localization files
  ├── main.dart         # App entry point
```

## Setup
### Prerequisites
- Flutter: **3.35.4**
- Dart: **3.9.2**

```sh
git clone https://github.com/devatiq/Shojag-App.git shojag
cd shojag
flutter pub get
flutter run
```

## Firebase Setup
1. Create a Firebase project.
2. Add Android and iOS apps to Firebase.
3. Download `google-services.json` and `GoogleService-Info.plist`.
4. Place them in:
    - `android/app/` for Android
    - `ios/Runner/` for iOS
5. Make sure Firebase is initialized in `main.dart`.

## DART DEFINES
Replace the following DART defines with your own values:
```
--dart-define="MAPBOX_ACCESS_TOKEN=REPLACE_YOUR_MAPBOX_API_KEY"
--dart-define="SSLCOMMERZ_STORE_ID=REPLACE_YOUR_SSLCOMMERZ_STORE_ID"
--dart-define="SSLCOMMERZ_STORE_PASSWORD=REPLACE_YOUR_SSLCOMMERZ_STORE_PASSWORD"
```

## Build & Deployment
```sh
flutter build apk --release --obfuscate --split-debug-info=build/symbols/prod --dart-define="MAPBOX_ACCESS_TOKEN=REPLACE_YOUR_MAPBOX_API_KEY" --dart-define="SSLCOMMERZ_STORE_ID=REPLACE_YOUR_SSLCOMMERZ_STORE_ID" --dart-define="SSLCOMMERZ_STORE_PASSWORD=REPLACE_YOUR_SSLCOMMERZ_STORE_PASSWORD"
flutter build ios --release --dart-define="MAPBOX_ACCESS_TOKEN=REPLACE_YOUR_MAPBOX_API_KEY" --dart-define="SSLCOMMERZ_STORE_ID=REPLACE_YOUR_SSLCOMMERZ_STORE_ID" --dart-define="SSLCOMMERZ_STORE_PASSWORD=REPLACE_YOUR_SSLCOMMERZ_STORE_PASSWORD"

flutter build appbundle --release --obfuscate --split-debug-info=build/symbols/prod --dart-define="MAPBOX_ACCESS_TOKEN=REPLACE_YOUR_MAPBOX_API_KEY" --dart-define="SSLCOMMERZ_STORE_ID=REPLACE_YOUR_SSLCOMMERZ_STORE_ID" --dart-define="SSLCOMMERZ_STORE_PASSWORD=REPLACE_YOUR_SSLCOMMERZ_STORE_PASSWORD"
flutter build ipa --release --dart-define="MAPBOX_ACCESS_TOKEN=REPLACE_YOUR_MAPBOX_API_KEY" --dart-define="SSLCOMMERZ_STORE_ID=REPLACE_YOUR_SSLCOMMERZ_STORE_ID" --dart-define="SSLCOMMERZ_STORE_PASSWORD=REPLACE_YOUR_SSLCOMMERZ_STORE_PASSWORD"
```


## License
This project is proprietary. All rights reserved. © 2025 Shojag.