import 'package:mappls_hackathon/repo/text_search_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'text_search_controller.g.dart';
@Riverpod(keepAlive: true)
class TextSearchController extends _$TextSearchController {
  @override
  FutureOr<void> build() {

    // perform some initialization if needed
    // then return the initial value
  }
  FutureOr<void> sendRequest({required String query, required String authToken}) async {
    final textSearchRepository = ref.read(textSearchRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => textSearchRepository.fetchGameData(query, authToken),
    );
  }
}
