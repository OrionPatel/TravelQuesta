// To parse this JSON data, do
//
//     final chatGptApiModel = chatGptApiModelFromJson(jsonString);

import 'dart:convert';

ChatGptApiModel chatGptApiModelFromJson(String str) => ChatGptApiModel.fromJson(json.decode(str));

String chatGptApiModelToJson(ChatGptApiModel data) => json.encode(data.toJson());

class ChatGptApiModel {
  String result;
  bool status;
  int serverCode;

  ChatGptApiModel({
    required this.result,
    required this.status,
    required this.serverCode,
  });

  factory ChatGptApiModel.fromJson(Map<String, dynamic> json) => ChatGptApiModel(
    result: json["result"],
    status: json["status"],
    serverCode: json["server_code"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "status": status,
    "server_code": serverCode,
  };
}
