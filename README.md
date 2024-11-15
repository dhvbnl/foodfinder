# Food Finder

Food Finder is a Flutter application that helps users locate nearby restaurants using Google Maps and Mapbox. The app provides a user-friendly interface to search for restaurants, view their details, and get directions.

## Features

- Search for nearby restaurants
- View restaurant details
- Get directions to the restaurant
- Dynamic resizing of text and widgets
- Customizable UI elements

## Running the App

To run the app, follow these steps:

1. Clone the repository:
   ```sh
   git clone https://github.com/dhvbnl/foodfinder.git
   ```
2. Navigate to the project directory

3. Create a `keys.dart` file in the `lib` folder with the following content:
   ```dart
   const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
   const String mapboxApiKey = 'YOUR_MAPBOX_API_KEY';
   ```
4. Get the dependencies:
   ```sh
   flutter pub get
   ```
5. Run the app:
   ```sh
   flutter run
   ```


## Resources Used

### Packages and Functions
- [haversine-dart](https://github.com/shawnchan2014/haversine-dart)
- [geolocator](https://pub.dev/packages/geolocator)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [flutter_platform_widgets](https://pub.dev/packages/flutter_platform_widgets)
- [platform_maps_flutter](https://pub.dev/packages/platform_maps_flutter)
- [flutter_map_location_marker](https://pub.dev/packages/flutter_map_location_marker)
- [url_launcher](https://pub.dev/packages/url_launcher)
- [auto_size_text](https://pub.dev/packages/auto_size_text)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [flutter_map_marker_cluster](https://github.com/lpongetti/flutter_map_marker_cluster?tab=readme-ov-file)
- [flutter_map_cancellable_tile_provider](https://pub.dev/packages/flutter_map_cancellable_tile_provider/)

### Articles and Blogs
- [How do you round a double in Dart to a given degree of precision after the decimal](https://stackoverflow.com/questions/28419255/how-do-you-round-a-double-in-dart-to-a-given-degree-of-precision-after-the-decim)
- [How to change status bar color in Flutter](https://stackoverflow.com/questions/52489458/how-to-change-status-bar-color-in-flutter)
- [How can I add dynamic number of columns depending on device width or orientation in Flutter](https://stackoverflow.com/questions/70922830/flutter-how-can-i-add-dynamic-number-of-columns-depending-on-device-width-or-or)
- [How to dynamically resize text in Flutter](https://www.edureka.co/community/234752/how-to-dynamically-resize-text-in-flutter#:~:text=You%20can%20use%20the%20FittedBox,properties%20of%20the%20Text%20widget.)
- [Getting started with Flutter Map](https://raphaeldelio.medium.com/getting-started-with-flutter-map-9cf4113f22e9)
- [Manage the position of showMenu in Flutter](https://stackoverflow.com/questions/73709040/manage-the-position-of-showmenu-in-flutter)
- [GestureDetector onTap doesn't work with PopupMenuButton in Flutter](https://stackoverflow.com/questions/70193457/flutter-gesturedector-on-tap-doesnt-work-with-popupmenubutton)
- [FittedBox with maximum two lines in Flutter](https://stackoverflow.com/questions/65822604/fittedbox-with-maximum-two-lines-in-flutter)
- [How to center only one element in a row of 2 elements in Flutter](https://stackoverflow.com/questions/51587003/how-to-center-only-one-element-in-a-row-of-2-elements-in-flutter)
- [How to change the application launcher icon on Flutter](https://stackoverflow.com/questions/43928702/how-to-change-the-application-launcher-icon-on-flutter)
- [How people choose restaurants: Top 10 factors](https://www.owner.com/blog/how-people-choose-restaurants-top-10-factors)
- [How can I properly remove an OverlayEntry in Flutter](https://stackoverflow.com/questions/71119493/how-can-i-properly-remove-an-overlayentry-in-flutter)
- [Custom card shape Flutter SDK](https://stackoverflow.com/questions/50756745/custom-card-shape-flutter-sdk)
- [How to add elements to a column if there is a condition in Flutter](https://stackoverflow.com/questions/63232038/how-to-add-elements-to-a-column-if-there-is-a-condition-in-flutter)
- [How to use conditional statement within child attribute of a Flutter widget](https://stackoverflow.com/questions/49713189/how-to-use-conditional-statement-within-child-attribute-of-a-flutter-widget-cen)
- [Flutter MainAxisSize.max vs min](https://itnext.io/flutter-mainaxissize-max-vs-min-d9095d8f7914)
- [How to use new line character in Text widget Flutter](https://stackoverflow.com/questions/57992926/how-to-use-new-line-character-in-text-widget-flutter)

### Online Tools
- [GMaps Extractor](https://gmapsextractor.com/)
- [JSON Formatter](https://jsonformatter.org)
- [AI Icon Generator](https://perchance.org/ai-icon-generator)
- [App Icon Generator](https://www.appicon.co/#app-icon)

### Data Source
- [Google Maps](https://www.google.com/maps) (Used GMaps Extractor to take restaurant data)

