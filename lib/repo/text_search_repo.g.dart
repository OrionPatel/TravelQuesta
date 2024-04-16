// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_search_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$textSearchRepositoryHash() =>
    r'c6ccda9b01bb3b03c00a7566412e955edba1f8b7';

/// See also [textSearchRepository].
@ProviderFor(textSearchRepository)
final textSearchRepositoryProvider = Provider<TextSearchRepository>.internal(
  textSearchRepository,
  name: r'textSearchRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$textSearchRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TextSearchRepositoryRef = ProviderRef<TextSearchRepository>;
String _$fetchGameDataHash() => r'c0d6220d096d37e15894f78f2fac620c2a199cdf';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchGameData].
@ProviderFor(fetchGameData)
const fetchGameDataProvider = FetchGameDataFamily();

/// See also [fetchGameData].
class FetchGameDataFamily extends Family<AsyncValue<TextSearchApiModel>> {
  /// See also [fetchGameData].
  const FetchGameDataFamily();

  /// See also [fetchGameData].
  FetchGameDataProvider call(
    String query,
    String authToken,
  ) {
    return FetchGameDataProvider(
      query,
      authToken,
    );
  }

  @override
  FetchGameDataProvider getProviderOverride(
    covariant FetchGameDataProvider provider,
  ) {
    return call(
      provider.query,
      provider.authToken,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchGameDataProvider';
}

/// See also [fetchGameData].
class FetchGameDataProvider extends FutureProvider<TextSearchApiModel> {
  /// See also [fetchGameData].
  FetchGameDataProvider(
    String query,
    String authToken,
  ) : this._internal(
          (ref) => fetchGameData(
            ref as FetchGameDataRef,
            query,
            authToken,
          ),
          from: fetchGameDataProvider,
          name: r'fetchGameDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchGameDataHash,
          dependencies: FetchGameDataFamily._dependencies,
          allTransitiveDependencies:
              FetchGameDataFamily._allTransitiveDependencies,
          query: query,
          authToken: authToken,
        );

  FetchGameDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.authToken,
  }) : super.internal();

  final String query;
  final String authToken;

  @override
  Override overrideWith(
    FutureOr<TextSearchApiModel> Function(FetchGameDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchGameDataProvider._internal(
        (ref) => create(ref as FetchGameDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        authToken: authToken,
      ),
    );
  }

  @override
  FutureProviderElement<TextSearchApiModel> createElement() {
    return _FetchGameDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchGameDataProvider &&
        other.query == query &&
        other.authToken == authToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, authToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchGameDataRef on FutureProviderRef<TextSearchApiModel> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `authToken` of this provider.
  String get authToken;
}

class _FetchGameDataProviderElement
    extends FutureProviderElement<TextSearchApiModel> with FetchGameDataRef {
  _FetchGameDataProviderElement(super.provider);

  @override
  String get query => (origin as FetchGameDataProvider).query;
  @override
  String get authToken => (origin as FetchGameDataProvider).authToken;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
