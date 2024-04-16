// To parse this JSON data, do
//
//     final authTokenApiModel = authTokenApiModelFromJson(jsonString);

import 'dart:convert';

AuthTokenApiModel authTokenApiModelFromJson(String str) => AuthTokenApiModel.fromJson(json.decode(str));

String authTokenApiModelToJson(AuthTokenApiModel data) => json.encode(data.toJson());

class AuthTokenApiModel {
  String accessToken;
  String tokenType;
  int expiresIn;
  String scope;
  String projectCode;
  String clientId;

  AuthTokenApiModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
    required this.projectCode,
    required this.clientId,
  });

  factory AuthTokenApiModel.fromJson(Map<String, dynamic> json) => AuthTokenApiModel(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    scope: json["scope"],
    projectCode: json["project_code"],
    clientId: json["client_id"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "scope": scope,
    "project_code": projectCode,
    "client_id": clientId,
  };
}
