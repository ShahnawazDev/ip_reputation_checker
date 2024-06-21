# ip_reputation_checker

A Flutter project designed to check the reputation of own IP address.


### Building the App

1. **Clone the Repository**

    Start by cloning the repository to your local machine.

    ```shell
    git clone https://github.com/ShahnawazDev/ip_reputation_checker.git

    cd ip_reputation_checker
    ```

2. **Install Dependencies**

    Before running the app, you need to fetch all the dependencies specified in the `pubspec.yaml` file. Run the following command:

    ```shell
    flutter pub get
    ```


3. **Pass the API Key**

- The application requires an API key from [IPQualityScore](https://www.ipqualityscore.com/documentation/proxy-detection-api/overview) website to fetch data. 
- You must pass this API key as a compile-time constant using the --dart-define flag. Replace YOUR_API_KEY_HERE with your actual API key.

For running the app in debug mode:
```shell
flutter run --dart-define=API_KEY=YOUR_API_KEY_HERE
```



For building the app for Android:
```shell
flutter build apk --dart-define=API_KEY=YOUR_API_KEY_HERE
```
Or, for iOS (requires macOS):
```shell
flutter build ios --dart-define=API_KEY=YOUR_API_KEY_HERE
```
For Windows:
```shell
flutter build windows --dart-define=API_KEY=YOUR_API_KEY_HERE
```
For macOS (requires macOS):
```shell
flutter build macos --dart-define=API_KEY=YOUR_API_KEY_HERE
```