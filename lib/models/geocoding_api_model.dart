// To parse this JSON data, do
//
//     final geocodingApiModel = geocodingApiModelFromJson(jsonString);

import 'dart:convert';

GeocodingApiModel geocodingApiModelFromJson(String str) => GeocodingApiModel.fromJson(json.decode(str));

String geocodingApiModelToJson(GeocodingApiModel data) => json.encode(data.toJson());

class GeocodingApiModel {
  List<Result> results;

  GeocodingApiModel({
    required this.results,
  });

  factory GeocodingApiModel.fromJson(Map<String, dynamic> json) => GeocodingApiModel(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String address;
  String postalCode;
  String country;
  String region;
  String area;
  String locality;
  String sublocality;
  Location location;
  String locationType;
  String type;

  Result({
    required this.address,
    required this.postalCode,
    required this.country,
    required this.region,
    required this.area,
    required this.locality,
    required this.sublocality,
    required this.location,
    required this.locationType,
    required this.type,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    address: json["address"],
    postalCode: json["postal_code"],
    country: json["country"],
    region: json["region"],
    area: json["area"],
    locality: json["locality"],
    sublocality: json["sublocality"],
    location: Location.fromJson(json["location"]),
    locationType: json["location_type"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "postal_code": postalCode,
    "country": country,
    "region": region,
    "area": area,
    "locality": locality,
    "sublocality": sublocality,
    "location": location.toJson(),
    "location_type": locationType,
    "type": type,
  };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
