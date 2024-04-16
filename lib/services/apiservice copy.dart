import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mappls_hackathon/models/auth_api_model.dart';
import 'package:mappls_hackathon/models/chat_gpt_api_model.dart';
import 'package:mappls_hackathon/models/distance_matrix_api_model.dart';
import 'package:mappls_hackathon/models/geocoding_api_model.dart';
import 'package:mappls_hackathon/models/nearby_api_model.dart';
import 'package:mappls_hackathon/models/text_search_api_model.dart';

// class ApiServices {
  Future<NearbyApiModel> nearby_api(
      String keyword, double lat, double long, double radius) async {
    String apiUrl = 'https://atlas.mappls.com/api/places/nearby/json';

    Dio dio = Dio();
    dio.options.headers["Authorization"] =
        "bearer a259485b-0efa-466d-883c-ada758ec2e0f";
    dio.options.headers["Content-Type"] = 'application/json';

    Map<String, dynamic> queryParams = {
      'access_token': "a259485b-0efa-466d-883c-ada758ec2e0f",
      'keywords': keyword,
      'refLocation': '${lat},${long}',
      'radius': radius.toInt() * 1000,
    };

    print(queryParams);

    Response response = await dio.get(
      apiUrl,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      print(response.data);
      return nearbyApiModelFromJson(jsonEncode(response.data));
    } else {
      print(response.data);
      throw Exception(response);
    }
  }

  Future<AuthTokenApiModel> auth_token_api() async {
    Dio dio = Dio();

    dio.options.headers["Content-Type"] = 'application/x-www-form-urlencoded';
    String url = 'https://outpost.mappls.com/api/security/oauth/token';

    Map<String, dynamic> data = {
      'grant_type': 'client_credentials',
      'client_id':
          '96dHZVzsAuveQBGTIIFIkYeraMJFqt9L-06b5-IZHvdE8vEECvvcoGE3eUKOIV_oMbjvJVxHi7WFgRpj6mCo8Q==',
      'client_secret':
          'lrFxI-iSEg_wXM1SNMY3-6sT4f-sjg_mdhe4x4urdW6rIkLmeQ_09lBxUmGFh8EB-F5HRjtEUZJCEOBzmw5vpwGro5mlEB6d',
    };

    Response response = await dio.post(
      url,
      data: FormData.fromMap(data), // or data
    );

    if (response.statusCode == 200) {
      print(response.data);
      return authTokenApiModelFromJson(jsonEncode(response.data));
    } else {
      print(response.data);
      throw Exception(response.data);
    }
  }

  Future<ChatGptApiModel> chat_gpt_api(String place) async {
    final dio = Dio();

    dio.options.headers["X-RapidAPI-Key"] =
        '5fffd4f6d3msh29b72709d71695bp1b20cbjsneb2bd33d1be4';
    dio.options.headers["X-RapidAPI-Host"] = 'chatgpt-42.p.rapidapi.com';
    dio.options.headers["content-length"] = 237;
    dio.options.headers["content-type"] = 'application/json';

    final String message = 'tell me something interesting facts about $place';
    final data = {
      'messages': [
        {'role': 'user', 'content': message}
      ],
      'system_prompt': '',
      'temperature': 0.9,
      'top_k': 5,
      'top_p': 0.9,
      'max_tokens': 256,
      'web_access': false,
    };

    final response = await dio.post(
      'https://chatgpt-42.p.rapidapi.com/conversationgpt4',
      data: data,
    );
    if (response.statusCode == 200) {
      print(response.data);
      return chatGptApiModelFromJson(jsonEncode(response.data));
    } else {
      print(response.data);
      throw Exception(response.data);
    }
  }

// Future<void> autosuggest(String filter, String query) async {
//   try {
//     final dio = Dio();
//     dio.options.headers["Authorization"] = "bearer 0e989555-2211-4d0a-98d8-bce369d7286f";
//     dio.options.headers["Content-Type"] = 'application/json';
//     String url = 'https://atlas.mappls.com/api/places/search/json';
//     Map<String, dynamic> queryParams = {
//       'filer': filter,
//       'query': query,
//     };
//
//     Response response = await dio.get(
//       url,
//       queryParameters: queryParams,
//       options: Options(
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       ),
//     );
//     if (response.statusCode == 200) {
//       print(response.data);
//     } else {
//       print(response.statusCode);
//     }
//   } catch (e) {
//     throw Exception('$e');
//   }
// }

  Future<TextSearchApiModel> text_search_api(String query) async {
    final dio = Dio();

    dio.options.headers["Authorization"] =
        "bearer a259485b-0efa-466d-883c-ada758ec2e0f";
    dio.options.headers["Content-Type"] = 'application/json';

    String url = 'https://atlas.mappls.com/api/places/textsearch/json';

    Map<String, dynamic> queryParams = {
      'region': 'IND',
      'query': query,
    };

    Response response = await dio.get(
      url,
      queryParameters: queryParams,
    );
    if (response.statusCode == 200) {
      print(response.data);
      return textSearchApiModelFromJson(jsonEncode(response.data));
    } else {
      print(response.data);
      throw Exception(response.data);
    }
  }

  Future<GeocodingApiModel> geocoding_api(String address) async {
    final dio = Dio();

    String url = 'https://trueway-geocoding.p.rapidapi.com/Geocode';
    dio.options.headers["X-RapidAPI-Key"] =
        "5fffd4f6d3msh29b72709d71695bp1b20cbjsneb2bd33d1be4";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["X-RapidAPI-Host"] = "trueway-geocoding.p.rapidapi.com";
    Map<String, dynamic> queryParams = {
      'address': address,
    };

    Response response = await dio.get(
      url,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      print(response.data);
      return geocodingApiModelFromJson(jsonEncode(response.data));
    } else {
      print(response.statusCode);
      throw Exception(response.data);
    }
  }

  Future<DistanceMatrixApiModel> distance_matrix_api(
    double lat1,
    double long1,
    double lat2,
    double long2,
  ) async {
    String accessToken = 'a259485b-0efa-466d-883c-ada758ec2e0f';
    String apiUrl =
        'https://apis.mappls.com/advancedmaps/v1/${accessToken}/distance_matrix/walking/${long1},${lat1};${long2},${lat2}';

    Dio dio = Dio();

    // dio.options.baseUrl = apiUrl;

    Response response = await dio.get(
      apiUrl,
    );

    if (response.statusCode == 200) {
      return distanceMatrixApiModelFromJson(jsonEncode(response.data));
    } else {
      print(response.data);
      throw Exception(response.data);
    }
  }
// }

// final apiProvider = Provider<ApiServices>((ref) => ApiServices());
