part of 'client.dart';

extension ResponseExtensions<T> on Response<T> {
  static T _safeGetBody<T>(Response<T> response) {
    if (response.isSuccessful) {
      final body = response.body;
      if (body is T) {
        return body;
      } else {
        throw ChopperException('Expected response type $T, received null.');
      }
    }

    var error = response.error;
    if (error is! Exception) {
      error = ChopperHttpException(response);
    }

    throw error;
  }

  T get safeBodyOrThrow => _safeGetBody(this);
}

extension ResponseFutureExtensions<T> on Future<Response<T>> {
  Future<T> bodyOrThrow() => then(ResponseExtensions._safeGetBody);
}
