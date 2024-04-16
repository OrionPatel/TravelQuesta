// To parse this JSON data, do
//
//     final nearbyApiModel = nearbyApiModelFromJson(jsonString);

import 'dart:convert';

NearbyApiModel nearbyApiModelFromJson(String str) => NearbyApiModel.fromJson(json.decode(str));

String nearbyApiModelToJson(NearbyApiModel data) => json.encode(data.toJson());

class NearbyApiModel {
  List<SuggestedLocation> suggestedLocations;
  PageInfo pageInfo;

  NearbyApiModel({
    required this.suggestedLocations,
    required this.pageInfo,
  });

  factory NearbyApiModel.fromJson(Map<String, dynamic> json) => NearbyApiModel(
    suggestedLocations: List<SuggestedLocation>.from(json["suggestedLocations"].map((x) => SuggestedLocation.fromJson(x))),
    pageInfo: PageInfo.fromJson(json["pageInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "suggestedLocations": List<dynamic>.from(suggestedLocations.map((x) => x.toJson())),
    "pageInfo": pageInfo.toJson(),
  };
}

class PageInfo {
  int pageCount;
  int totalHits;
  int totalPages;
  int pageSize;

  PageInfo({
    required this.pageCount,
    required this.totalHits,
    required this.totalPages,
    required this.pageSize,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    pageCount: json["pageCount"],
    totalHits: json["totalHits"],
    totalPages: json["totalPages"],
    pageSize: json["pageSize"],
  );

  Map<String, dynamic> toJson() => {
    "pageCount": pageCount,
    "totalHits": totalHits,
    "totalPages": totalPages,
    "pageSize": pageSize,
  };
}

class SuggestedLocation {
  int distance;
  String eLoc;
  List<String> keywords;
  int orderIndex;
  String placeAddress;
  String placeName;
  Type type;

  SuggestedLocation({
    required this.distance,
    required this.eLoc,
    required this.keywords,
    required this.orderIndex,
    required this.placeAddress,
    required this.placeName,
    required this.type,
  });

  factory SuggestedLocation.fromJson(Map<String, dynamic> json) => SuggestedLocation(
    distance: json["distance"],
    eLoc: json["eLoc"],
    keywords: List<String>.from(json["keywords"].map((x) => x)),
    orderIndex: json["orderIndex"],
    placeAddress: json["placeAddress"],
    placeName: json["placeName"],
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "eLoc": eLoc,
    "keywords": List<dynamic>.from(keywords.map((x) => x)),
    "orderIndex": orderIndex,
    "placeAddress": placeAddress,
    "placeName": placeName,
    "type": typeValues.reverse[type],
  };
}

enum Type {
  POI
}

final typeValues = EnumValues({
  "POI": Type.POI
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
