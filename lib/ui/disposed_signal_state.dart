import 'dart:async';

import 'package:flutter_demo/ui.dart';

mixin DisposedSignalState<T extends StatefulWidget> on State<T> {
  Completer<void>? _disposedCompleter;

  Future<void> get disposed {
    return (_disposedCompleter ??= .new()).future;
  }

  @override
  void dispose() {
    _disposedCompleter?.complete();
    super.dispose();
  }
}
