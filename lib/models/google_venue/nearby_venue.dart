class NearbyVenue {
  String? nationalPhoneNumber;
  String? formattedAddress;
  Location? location;
  double? rating;
  String? websiteUri;
  String? priceLevel;
  int? userRatingCount;
  DisplayName? displayName;
  DisplayName? primaryTypeDisplayName;
  DisplayName? editorialSummary;
  bool? servesVegetarianFood;
  bool? outdoorSeating;
  bool? goodForGroups;

  NearbyVenue(
      {String? nationalPhoneNumber,
      String? formattedAddress,
      Location? location,
      double? rating,
      String? websiteUri,
      String? priceLevel,
      int? userRatingCount,
      DisplayName? displayName,
      DisplayName? primaryTypeDisplayName,
      DisplayName? editorialSummary,
      bool? servesVegetarianFood,
      bool? outdoorSeating,
      bool? goodForGroups}) {
    if (nationalPhoneNumber != null) {
      nationalPhoneNumber = nationalPhoneNumber;
    }
    if (formattedAddress != null) {
      formattedAddress = formattedAddress;
    }
    if (location != null) {
      location = location;
    }
    if (rating != null) {
      rating = rating;
    }
    if (websiteUri != null) {
      websiteUri = websiteUri;
    }
    if (priceLevel != null) {
      priceLevel = priceLevel;
    }
    if (userRatingCount != null) {
      userRatingCount = userRatingCount;
    }
    if (displayName != null) {
      displayName = displayName;
    }
    if (primaryTypeDisplayName != null) {
      primaryTypeDisplayName = primaryTypeDisplayName;
    }
    if (editorialSummary != null) {
      editorialSummary = editorialSummary;
    }
    if (servesVegetarianFood != null) {
      servesVegetarianFood = servesVegetarianFood;
    }
    if (outdoorSeating != null) {
      outdoorSeating = outdoorSeating;
    }
    if (goodForGroups != null) {
      goodForGroups = goodForGroups;
    }
  }

  NearbyVenue.fromJson(Map<String, dynamic> json) {
    nationalPhoneNumber = json['nationalPhoneNumber'];
    formattedAddress = json['formattedAddress'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    rating = json['rating'];
    websiteUri = json['websiteUri'];
    priceLevel = json['priceLevel'];
    userRatingCount = json['userRatingCount'];
    displayName = json['displayName'] != null
        ? DisplayName.fromJson(json['displayName'])
        : null;
    primaryTypeDisplayName = json['primaryTypeDisplayName'] != null
        ? DisplayName.fromJson(json['primaryTypeDisplayName'])
        : null;
    editorialSummary = json['editorialSummary'] != null
        ? DisplayName.fromJson(json['editorialSummary'])
        : null;
    servesVegetarianFood = json['servesVegetarianFood'];
    outdoorSeating = json['outdoorSeating'];
    goodForGroups = json['goodForGroups'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nationalPhoneNumber'] = nationalPhoneNumber;
    data['formattedAddress'] = formattedAddress;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['rating'] = rating;
    data['websiteUri'] = websiteUri;
    data['priceLevel'] = priceLevel;
    data['userRatingCount'] = userRatingCount;
    if (displayName != null) {
      data['displayName'] = displayName!.toJson();
    }
    if (primaryTypeDisplayName != null) {
      data['primaryTypeDisplayName'] = primaryTypeDisplayName!.toJson();
    }
    if (editorialSummary != null) {
      data['editorialSummary'] = editorialSummary!.toJson();
    }
    data['servesVegetarianFood'] = servesVegetarianFood;
    data['outdoorSeating'] = outdoorSeating;
    data['goodForGroups'] = goodForGroups;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({double? latitude, double? longitude}) {
    if (latitude != null) {
      latitude = latitude;
    }
    if (longitude != null) {
      longitude = longitude;
    }
  }

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class DisplayName {
  String? text;
  String? languageCode;

  DisplayName({String? text, String? languageCode}) {
    if (text != null) {
      text = text;
    }
    if (languageCode != null) {
      languageCode = languageCode;
    }
  }

  DisplayName.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    languageCode = json['languageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['languageCode'] = languageCode;
    return data;
  }
}
