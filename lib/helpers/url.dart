import 'package:url_launcher/url_launcher.dart';

class Url {
  /// Opens url in default browser
  /// Parameters:
  ///  - url: valid web url
  static Future<void> openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
