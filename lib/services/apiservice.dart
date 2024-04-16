import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mappls_hackathon/models/auth_api_model.dart';

final apiKey = '';

Future<List<dynamic>> nearby_api(String keyword, double lat, double long,
    double radius, String token) async {
  String apiUrl = 'https://atlas.mappls.com/api/places/nearby/json';

  Dio dio = Dio();
  dio.options.headers["Authorization"] = "bearer ${token}";
  dio.options.headers["Content-Type"] = 'application/json';

  // dio.options.baseUrl = apiUrl;

  Map<String, dynamic> queryParams = {
    'access_token': token,
    'keywords': keyword,
    'refLocation': '${lat},${long}',
    'radius': radius.toInt() * 1000,
  };
  // print(queryParams);
  Response response = await dio.get(
    apiUrl,
    queryParameters: queryParams,
    // options: Options(
    //   headers: {
    //
    //     "Authorization":
    //     "0e989555-2211-4d0a-98d8-bce369d7286f",
    //     'Content-Type': 'application/json',
    //   },

    // ),
  );

  if (response.statusCode == 200) {
    print(response.data);
    List<dynamic> bhruh = response.data['suggestedLocations'];
    return bhruh;
  } else {
    throw Exception(response.data);
  }
}

Future<String> auth_token_api() async {
  Dio dio = Dio();
  dio.options.headers["Content-Type"] = 'application/x-www-form-urlencoded';
  String url = 'https://outpost.mappls.com/api/security/oauth/token';

  Map<String, dynamic> data = {
    'grant_type': 'client_credentials',
    'client_id':
        '96dHZVzsAutUS6SzMai1FcOGd7iKEpc2ffbGz9Nhd9iUFld9eXC1jLluDxwwEU5QwBBuQ2R8dAxGlNZ2Ut0MPuxZgQW5q5ni',
    'client_secret':
        'lrFxI-iSEg_HPOwMuCs0F_6X49v8WscvtVS_gNl_xcUhxDlWuAhGUk_FJpbxT6MJh7_BMAEo0oXsvPynQqXlDVptGhwduhr_gowauMj4gns=',
  };
  // Making POST request
  Response response = await dio.post(
    url,
    data: FormData.fromMap(data), // or data
  );

  if (response.statusCode == 200) {
    print(response.data);
    return response.data['access_token'];
    AuthTokenApiModel model = authTokenApiModelFromJson(response.data);
    print('auth token khjsbdnfvjkhfsdbnfgsfjkfgs :: ${model.accessToken}');
    return model.accessToken;
  } else {
    throw Exception(response.data);
  }
}

Future<String> chat_gpt_api(String place) async {
  print("THIS DEVIL API IS RUNNING!!!!!!!!!!!");
  final dio = Dio();
  dio.options.headers["X-RapidAPI-Key"] =
      'a68d64b393mshf8d601eea9e5565p12e674jsnb2b42bde54a3';
  dio.options.headers["X-RapidAPI-Host"] = 'chatgpt-42.p.rapidapi.com';
  dio.options.headers["content-length"] = 237;
  dio.options.headers["content-type"] = 'application/json';
  final String message = 'tell me one interesting fact about $place';
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
  // final options = Options(
  //   // baseUrl: 'https://chatgpt-42.p.rapidapi.com/conversationgpt4',
  //   headers: {
  //     'X-RapidAPI-Key': '5fffd4f6d3msh29b72709d71695bp1b20cbjsneb2bd33d1be4',
  //     'X-RapidAPI-Host': 'chatgpt-42.p.rapidapi.com',
  //     'content-length': 237,
  //     'content-type': 'application/json'
  //   },
  // );

  final response = await dio.post(
    'https://chatgpt-42.p.rapidapi.com/conversationgpt4',
    data: data,
  );
  if (response.statusCode == 200) {
    print(response.data);
    return response.data['result'];
  } else {
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

Future<Map<String, dynamic>?> text_search_api(
    String query, String token) async {
  try {
    final dio = Dio();
    dio.options.headers["Authorization"] = "bearer ${token}";
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
      Map<String, dynamic> map = response.data['suggestedLocations'][0];
      return map;
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<Map<String, dynamic>?> geocoding_api(String address) async {
  try {
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
      Map<String, dynamic> map = response.data['results'][0]['location'];
      print(map);
      return map;
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<double?> distance_matrix_api(
    double lat1, double long1, double lat2, double long2) async {
  
  String apiUrl =
      'https://apis.mappls.com/advancedmaps/v1/542dbb0ec43d4e94a956e1e2cbc7f4ff/distance_matrix/walking/${long1},${lat1};${long2},${lat2}';

  try {
    Dio dio = Dio();

    // dio.options.baseUrl = apiUrl;

    Response response = await dio.get(
      apiUrl,
      // options: Options(
      //   headers: {
      //
      //     "Authorization":
      //     "0e989555-2211-4d0a-98d8-bce369d7286f",
      //     'Content-Type': 'application/json',
      //   },

      // ),
    );

    if (response.statusCode == 200) {
      print(response.data);
      return response.data['results']['distances'][0][1];
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
