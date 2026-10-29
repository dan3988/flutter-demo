import 'dart:async';

import 'package:chopper/chopper.dart' hide Level, Post;
import 'package:logging/logging.dart';

import 'package:axcend/api/logging_interceptor.dart';
import 'package:axcend/api/models.dart';

export 'package:axcend/api/models.dart';

part 'client.chopper.dart';

part 'client.endpoints.dart';

part 'client.extensions.dart';

typedef Result<T> = Future<Response<T>>;

final Map<Type, _JsonFactory> _fromJsonFactories = {};

typedef _JsonFactory<T> = T Function(Map<String, dynamic> json);

void _addFactory<T>(_JsonFactory<T> factory) {
  final current = _fromJsonFactories.putIfAbsent(T, () => factory);
  assert(current == factory, 'Multiple factories registered for $T');
}

class PlaceholderApi {
  factory PlaceholderApi({
    required Uri baseUrl,
    Logger? logger,
    Level logLevel = .INFO,
    bool simulateSlowConnection = false,
  }) {
    final client = ChopperClient(
      baseUrl: baseUrl,
      converter: _JsonConverter(_fromJsonFactories),
      services: [
        _$AlbumService(),
        _$CommentService(),
        _$PhotoService(),
        _$PostService(),
        _$TodoService(),
        _$UserService(),
      ],
      interceptors: [
        if (logger != null)
          RequestLoggingInterceptor(
            logger,
            baseUrl: baseUrl.toString(),
            level: logLevel,
          ),
        if (simulateSlowConnection)
          _SlowConnectionSimulationInterceptor(
            minimumDuration: .new(seconds: 2),
          ),
      ],
    );

    return ._(client);
  }

  final ChopperClient _client;

  final AlbumService albums;
  final CommentService comments;
  final PhotoService photos;
  final PostService posts;
  final TodoService todos;
  final UserService users;

  PlaceholderApi._(this._client)
    : albums = _client.getService(),
      comments = _client.getService(),
      photos = _client.getService(),
      posts = _client.getService(),
      todos = _client.getService(),
      users = _client.getService();

  void dispose() {
    _client.dispose();
  }
}

class _JsonConverter extends JsonConverter {
  final Map<Type, _JsonFactory> factories;

  const _JsonConverter(this.factories);

  T? _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! _JsonFactory<T>) {
      return null;
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v)).toList();

  dynamic _decode<T>(dynamic entity) {
    if (entity is Iterable) return _decodeList<T>(entity as List);

    if (entity is Map) return _decodeMap<T>(entity as Map<String, dynamic>);

    return entity;
  }

  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(
    Response response,
  ) async {
    final jsonRes = await super.convertResponse(response);

    return jsonRes.copyWith<ResultType>(body: _decode<Item>(jsonRes.body));
  }
}

class _SlowConnectionSimulationInterceptor implements Interceptor {
  final Duration minimumDuration;
  final double magnitude;

  _SlowConnectionSimulationInterceptor({
    this.minimumDuration = .zero,
    this.magnitude = 0,
  });

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final start = DateTime.timestamp();
    final result = await chain.proceed(chain.request);
    final duration = DateTime.timestamp().difference(start);
    await Future.delayed(minimumDuration + (duration * magnitude));
    return result;
  }
}
