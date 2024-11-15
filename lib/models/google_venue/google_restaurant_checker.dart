import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_finder/keys.dart';

restaurantSearch() async {
  var headers = {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': googleMapsApiKey,
    'X-Goog-FieldMask':
        'places.displayName,'
        'places.formattedAddress,'
        'places.primaryTypeDisplayName,'
        'places.websiteUri,'
        'places.rating,'
        'places.userRatingCount,'
        'places.nationalPhoneNumber,'
        'places.servesVegetarianFood,'
        'places.goodForGroups,'
        'places.outdoorSeating,'
        'places.location,'
        'places.editorialSummary,'
        'places.priceLevel',
  };
  var request = http.Request('POST',
      Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));
  request.body = json.encode({
    'includedTypes': ['restaurant'],
    'maxResultCount': 10,
    'locationRestriction': {
      'circle': {
        'center': {
          'latitude': 47.63495347281385,
          'longitude': -122.06400199222848
        },
        'radius': 5000
      }
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  } else {
    return response.reasonPhrase;
  }
}
