// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      hasPatio: json['has_patio'] as bool,
      cuisine: json['cuisine'] as String,
      website: json['website'] as String?,
      reviewCount: json['reviewCount'] as int,
      averageRating: (json['averageRating'] as num).toDouble(),
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      fulladdress: json['fulladdress'] as String,
    );

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'website': instance.website,
      'reviewCount': instance.reviewCount,
      'averageRating': instance.averageRating,
      'phone': instance.phone,
      'description': instance.description,
      'fulladdress': instance.fulladdress,
      'cuisine': instance.cuisine,
      'has_patio': instance.hasPatio,
    };
