import 'dart:async';

import 'package:meta/meta.dart';

void noop() {}

T returnSelf<T>(T self) => self;

class Optional<T> {
  final T value;

  const Optional(this.value);
}

abstract interface class BaseDisposable {
  FutureOr<void> dispose();
}

abstract mixin class SyncDisposable implements BaseDisposable {
  static bool debugAssertNotDisposed(SyncDisposable value) {
    assert(!value._disposed, 'A ${value.runtimeType} was used after disposed');
    return true;
  }

  var _disposed = false;

  @override
  @mustCallSuper
  void dispose() {
    assert(debugAssertNotDisposed(this));
    _disposed = true;
  }
}

abstract interface class AsyncDisposable extends BaseDisposable {
  @override
  Future<void> dispose();
}

extension DisposableCollectionExtensions on Iterable<SyncDisposable> {
  void disposeAll() {
    for (final value in this) {
      value.dispose();
    }
  }
}
