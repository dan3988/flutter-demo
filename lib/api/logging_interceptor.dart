import 'package:axcend/util.dart';
import 'package:chopper/chopper.dart' hide Level;
import 'package:http/http.dart' as http;

class RequestLoggingInterceptor implements Interceptor {
  final Logger logger;
  final String? baseUrl;
  final Level level;

  RequestLoggingInterceptor(this.logger, {this.baseUrl, this.level = .INFO});

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
