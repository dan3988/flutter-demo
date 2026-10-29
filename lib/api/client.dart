import 'dart:async';

import 'package:chopper/chopper.dart' hide Level, Post;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'package:axcend/api/models.dart';
import 'package:axcend/util/duration_extensions.dart';
import 'package:axcend/util/file_size.dart';

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
  }) {
    final client = ChopperClient(
      baseUrl: baseUrl,
      converter: _JsonConverter(_fromJsonFactories),
      services: [
        _$AlbumService(),
        _$CommentService(),
        _$PhotoService(),
        _$PostService(),
        _$UserService(),
      ],
      interceptors: [
        if (logger != null)
          _RequestLoggingInterceptor(logger, baseUrl.toString(), logLevel),
      ],
    );

    return ._(client);
  }

  final ChopperClient _client;

  final AlbumService albums;
  final CommentService comments;
  final PhotoService photos;
  final PostService posts;
  final UserService users;

  PlaceholderApi._(this._client)
    : albums = _client.getService(),
      comments = _client.getService(),
      photos = _client.getService(),
      posts = _client.getService(),
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

class _RequestLoggingInterceptor implements Interceptor {
  final Logger logger;
  final String? baseUrl;
  final Level level;

  _RequestLoggingInterceptor(this.logger, this.baseUrl, this.level);

  @override
  Future<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final request = chain.request;
    logger.log(level, _RequestLogMessage(baseUrl, request));
    final stopWatch = Stopwatch()..start();
    final response = await chain.proceed(request);
    stopWatch.stop();
    logger.log(
      level,
      _ResponseLogMessage(baseUrl, response, stopWatch.elapsed),
    );
    return response;
  }
}

final class _RequestLogMessage {
  final String? baseUrl;
  final Request request;

  _RequestLogMessage(this.baseUrl, this.request);

  @override
  toString() {
    final buffer = StringBuffer('--> ')
      ..write(request.method)
      ..write(' ')
      ..writeUrl(request, baseUrl)
      ..write(' (');

    final body = request.body;
    if (body == null) {
      buffer.write('empty');
    } else if (request.multipart) {
      buffer.write('multipart');
    } else if (body is List<int>) {
      buffer.writeSize(body.length);
    } else if (body is String) {
      buffer
        ..write(body.length)
        ..write(' characters');
    } else {
      buffer.write(body.runtimeType);
    }

    return (buffer..write(')')).toString();
  }
}

final class _ResponseLogMessage {
  final String? baseUrl;
  final Response response;
  final Duration duration;

  _ResponseLogMessage(this.baseUrl, this.response, this.duration);

  @override
  toString() {
    final buffer = StringBuffer('<-- ');
    final base = response.base;
    final request = base.request;
    if (request != null) {
      buffer
        ..write(request.method)
        ..write(' ')
        ..writeUrl(request, baseUrl)
        ..write(' ');
    }

    buffer
      ..write(response.statusCode)
      ..write(' ')
      ..write('(')
      ..write(duration.toDebugString());

    final size = base.contentLength;
    if (size != null) {
      buffer
        ..write(', ')
        ..writeSize(size);
    }

    return (buffer..write(')')).toString();
  }
}

extension on StringBuffer {
  void writeSize(int size, {int decimals = 1}) {
    final text = FileSize.bytes(size).toString(decimals: decimals);
    write(text);
  }

  void writeUrl(http.BaseRequest request, String? baseUrl) {
    var url = request.url.toString();
    if (baseUrl != null && url.startsWith(baseUrl)) {
      url = url.substring(baseUrl.length);
    }

    write(url);
  }
}
