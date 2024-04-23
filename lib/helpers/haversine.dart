import 'dart:math';

//taken from https://github.com/shawnchan2014/haversine-dart
//contains methods to find accurate distance between two coordinates
class Haversine {
  static const R = 3958.8; // In miles

  /// Finds distance between two coordinates with using the haversine formula
  /// Parameters:
  ///  - lat1: latitude for location 1
  ///  - lon1: longitude for location 1
  ///  - lat2: latitude for location 2
  ///  - lon2: longitude for location 2
  /// Returns: distance in miles between locations
  static double haversine(
    double lat1,
    lon1,
    lat2,
    lon2,
  ) {
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    lat1 = _toRadians(lat1);
    lat2 = _toRadians(lat2);
    double a =
        pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * asin(sqrt(a));
    return R * c;
  }

  /// converts degrees to radians
  /// Parameters:
  ///  - degree: degree value
  /// Returns: degree in radians
  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
