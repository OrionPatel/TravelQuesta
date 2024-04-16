import 'package:dio/dio.dart';
import 'package:mappls_hackathon/models/text_search_api_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'text_search_repo.g.dart';

class TextSearchRepository {
  TextSearchRepository(this.client);
  // this is the data source (from the http package)
  final Dio client;

  Future<TextSearchApiModel> fetchGameData(
      String query, String authToken) async {
      
    try {
      final dio = Dio();
      dio.options.headers["Authorization"] = authToken;
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
      print(response.data);
        // Map<String, dynamic> map = response.data['suggestedLocations'][0];
        return textSearchApiModelFromJson(response.data);
      // if (response.statusCode == 200) {
      //   print(response.data);
      //   Map<String, dynamic> map = response.data['suggestedLocations'][0];
      //   return textSearchApiModelFromJson(response.data);
      // } else {
      //   print(response.statusCode);
      //   return
      // }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

@Riverpod(keepAlive: true)
TextSearchRepository textSearchRepository(TextSearchRepositoryRef ref) {
  return TextSearchRepository(Dio());
}

// this will generate a fetchWeatherProvider
@Riverpod(keepAlive: true)
Future<TextSearchApiModel> fetchGameData(FetchGameDataRef ref, String query, String authToken ){
  return ref.watch(textSearchRepositoryProvider).fetchGameData(query, authToken);
}
