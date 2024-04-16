// To parse this JSON data, do
//
//     final distanceMatrixApiModel = distanceMatrixApiModelFromJson(jsonString);

import 'dart:convert';

DistanceMatrixApiModel distanceMatrixApiModelFromJson(String str) => DistanceMatrixApiModel.fromJson(json.decode(str));

String distanceMatrixApiModelToJson(DistanceMatrixApiModel data) => json.encode(data.toJson());

class DistanceMatrixApiModel {
  String server;
  String version;
  Results results;
  int responseCode;

  DistanceMatrixApiModel({
    required this.server,
    required this.version,
    required this.results,
    required this.responseCode,
  });

  factory DistanceMatrixApiModel.fromJson(Map<String, dynamic> json) => DistanceMatrixApiModel(
    server: json["Server"],
    version: json["version"],
    results: Results.fromJson(json["results"]),
    responseCode: json["responseCode"],
  );

  Map<String, dynamic> toJson() => {
    "Server": server,
    "version": version,
    "results": results.toJson(),
    "responseCode": responseCode,
  };
}

class Results {
  List<List<double>> distances;
  String code;
  List<List<double>> durations;

  Results({
    required this.distances,
    required this.code,
    required this.durations,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    distances: List<List<double>>.from(json["distances"].map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
    code: json["code"],
    durations: List<List<double>>.from(json["durations"].map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
  );

  Map<String, dynamic> toJson() => {
    "distances": List<dynamic>.from(distances.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "code": code,
    "durations": List<dynamic>.from(durations.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
