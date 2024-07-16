

# Movilar

Movilar is a Flutter application designed to provide a comprehensive movie browsing experience. The app leverages various packages to enhance its functionality, including secure storage, Dio, MQTT, Bluetooth integration, and more.

## Screenshots

 <img src="assetes/images/movilar_banner.png">

||||
|--------------|--------------|--------------|
| ![Screenshot 1](assets/images/(1).png) | ![Screenshot 2](assets/images/(2).png) | ![Screenshot 3](assets/images/(3).png) | 
| ![Screenshot 1](assets/images/(4).png) | ![Screenshot 2](assets/images/(5).png) | ![Screenshot 3](assets/images/(6).png) | 


## Recordings

All android (10,14), iOS and code demonstration recordings are available here: [Google Drive Recordings](https://drive.google.com/drive/folders/1oD8erBRLnQ-btdcEH9LNIxvbURteVDiE?usp=drive_link).

## Version

1.0.0+1

## Description

Movilar aims to deliver a rich movie browsing and information experience. Users can search for movies, view detailed information, and manage a personal watchlist. The application also includes Bluetooth functionality for enhanced user experiences.

## Environment

- Dart SDK: '>=3.4.0 <4.0.0'

## Dependencies

Movilar relies on several dependencies to provide its functionality:

- `cupertino_icons: ^1.0.6`
- `get: 4.6.6`
- `flutter: sdk: flutter`
- `flutter_native_splash: ^2.4.0`
- `flutter_svg: ^2.0.10+1`
- `google_fonts: ^6.2.1`
- `font_awesome_flutter: ^10.7.0`
- `flutter_blue_plus: ^1.32.8`
- `mqtt_client: ^10.2.1`
- `permission_handler: ^11.3.1`
- `connectivity_plus: ^6.0.3`
- `http: ^1.2.1`
- `youtube_player_flutter: ^9.0.1`
- `flutter_dotenv: ^5.1.0`
- `flutter_secure_storage: ^9.2.2`
- `sqflite: ^2.3.3+1`
- `path: ^1.9.0`
- `dio: ^5.4.3+1`
- `shimmer: ^3.0.0`
- `cached_network_image: ^3.3.1`

### Dev Dependencies

- `flutter_lints: 4.0.0`
- `flutter_test: sdk: flutter`
- `mockito: ^5.4.4`
- `build_runner: ^2.4.11`

## Folder Structure

The basic folder structure of the app is organized as follows:

```
lib/
├── app/
│   ├── data/
│   │   └── helpers/
│   ├── modules/
│   │   └── bluetooth/
│   ├── home/
│   │   ├── bindings/
│   │   ├── controllers/
│   │   ├── views/
│   │   │   └── home_view.dart
│   │   ├── widgets/
│   ├── movie_detail/
│   ├── mqtt/
│   ├── searches/
│   ├── watchlist/
│   └── widgets/
├── resources/
├── routes/
├── services/
│   ├── internet_service.dart
│   ├── movie_service.dart
│   └── secure_storage_service.dart
└── main.dart
```

### Explanation of Key Folders and Files

- **app/data/helpers/**: Contains helper classes and utilities for data handling.
- **app/modules/bluetooth/**: Manages Bluetooth-related functionalities.
- **app/home/**: The home module, including bindings, controllers, views, and widgets specific to the home screen.
- **app/movie_detail/**: Manages movie detail-related functionalities.
- **app/mqtt/**: Contains MQTT-related modules.
- **app/searches/**: Manages search functionalities.
- **app/watchlist/**: Manages the watchlist functionalities.
- **app/widgets/**: Reusable widgets used throughout the app.
- **resources/**: Contains app resources such as images and icons.
- **routes/**: Manages app routing.
- **services/**: Contains various services such as internet, movie, and secure storage services.
- **main.dart**: The entry point of the application.

## Assets

Movilar uses the following assets:

- **Images**: `assets/images/`
- **Icons**: `assets/icons/`
- **Environment file**: `.env`

## Flutter Native Splash Configuration

Movilar uses `flutter_native_splash` to create a native splash screen. The configuration is:

```yaml
flutter_native_splash:
  color: '#242A32'
  image: assets/images/splash.png
  android: true
  ios: true
  web: false
  android_12:
    color: '#242A32'
    icon_background_color: '#242A32'
    image: assets/images/splash_12.png
```

## How to Run

1. Ensure you have Flutter installed. For installation instructions, visit [flutter.dev](https://flutter.dev).
2. Clone this repository.
3. Navigate to the project directory.
4. Run `flutter pub get` to install dependencies.
5. Create a `.env` file in the root directory and add your environment variables.
6. Run the app with `flutter run`.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

