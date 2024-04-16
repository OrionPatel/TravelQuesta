// To parse this JSON data, do
//
//     final textSearchApiModel = textSearchApiModelFromJson(jsonString);

import 'dart:convert';

TextSearchApiModel textSearchApiModelFromJson(String str) => TextSearchApiModel.fromJson(json.decode(str));

String textSearchApiModelToJson(TextSearchApiModel data) => json.encode(data.toJson());

class TextSearchApiModel {
  List<SuggestedLocation> suggestedLocations;
  List<UserAddedLocation> userAddedLocations;

  TextSearchApiModel({
    required this.suggestedLocations,
    required this.userAddedLocations,
  });

  factory TextSearchApiModel.fromJson(Map<String, dynamic> json) => TextSearchApiModel(
    suggestedLocations: List<SuggestedLocation>.from(json["suggestedLocations"].map((x) => SuggestedLocation.fromJson(x))),
    userAddedLocations: List<UserAddedLocation>.from(json["userAddedLocations"].map((x) => UserAddedLocation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "suggestedLocations": List<dynamic>.from(suggestedLocations.map((x) => x.toJson())),
    "userAddedLocations": List<dynamic>.from(userAddedLocations.map((x) => x.toJson())),
  };
}

class SuggestedLocation {
  Type type;
  String placeAddress;
  String eLoc;
  String placeName;
  String alternateName;
  List<String> keywords;
  int distance;
  int orderIndex;
  Suggester suggester;

  SuggestedLocation({
    required this.type,
    required this.placeAddress,
    required this.eLoc,
    required this.placeName,
    required this.alternateName,
    required this.keywords,
    required this.distance,
    required this.orderIndex,
    required this.suggester,
  });

  factory SuggestedLocation.fromJson(Map<String, dynamic> json) => SuggestedLocation(
    type: typeValues.map[json["type"]]!,
    placeAddress: json["placeAddress"],
    eLoc: json["eLoc"],
    placeName: json["placeName"],
    alternateName: json["alternateName"],
    keywords: List<String>.from(json["keywords"].map((x) => x)),
    distance: json["distance"],
    orderIndex: json["orderIndex"],
    suggester: suggesterValues.map[json["suggester"]]!,
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "placeAddress": placeAddress,
    "eLoc": eLoc,
    "placeName": placeName,
    "alternateName": alternateName,
    "keywords": List<dynamic>.from(keywords.map((x) => x)),
    "distance": distance,
    "orderIndex": orderIndex,
    "suggester": suggesterValues.reverse[suggester],
  };
}

enum Suggester {
  ADDRESS,
  PLACE_NAME
}

final suggesterValues = EnumValues({
  "address": Suggester.ADDRESS,
  "placeName": Suggester.PLACE_NAME
});

enum Type {
  POI
}

final typeValues = EnumValues({
  "POI": Type.POI
});

class UserAddedLocation {
  String eLoc;
  int orderIndex;
  String placeAddress;
  String placeName;
  String type;

  UserAddedLocation({
    required this.eLoc,
    required this.orderIndex,
    required this.placeAddress,
    required this.placeName,
    required this.type,
  });

  factory UserAddedLocation.fromJson(Map<String, dynamic> json) => UserAddedLocation(
    eLoc: json["eLoc"],
    orderIndex: json["orderIndex"],
    placeAddress: json["placeAddress"],
    placeName: json["placeName"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "eLoc": eLoc,
    "orderIndex": orderIndex,
    "placeAddress": placeAddress,
    "placeName": placeName,
    "type": type,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
