import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:axcend/util.dart';
import 'package:stack_trace/stack_trace.dart';

export 'package:logging/logging.dart';

final _cache = <Type, Logger>{};

abstract class LogHandler implements AsyncDisposable {
  final Logger root;

  late final StreamSubscription _sub;

  LogHandler(this.root) {
    _sub = root.onRecord.listen(onLog);
  }

  @override
  @mustCallSuper
  dispose() {
    return _sub.cancel();
  }

  void onLog(LogRecord record);
}

Logger getLogger(Type type) {
  return _cache.putIfAbsent(type, () {
    var name = type.toString();
    if (name.startsWith('_')) {
      name = name.substring(1);
    }

    return Logger(name);
  });
}

extension LogRecordExtensions on LogRecord {
  String toConsoleString() {
    final trace = stackTrace?.toTrace();
    final logFrame = _getLogFrame();

    final color = _consoleColors[level];
    final lines = <String>[
      [
        time.toIso8601String().substring(11),
        level.name,
        if (loggerName.isNotEmpty) '[$loggerName]',
        _frameLocation(logFrame),
      ].join(' '),
    ];

    lines.addLines(message);
    lines.addLines(error);

    if (trace != null) {
      for (var i = 0; i < trace.frames.length; i++) {
        final frame = trace.frames[i];
        final text = '  ${frame.member} (${_frameLocation(frame)})';
        lines.add(text);
      }
    }

    if (color != null) {
      for (var i = 0; i < lines.length; i++) {
        lines[i] = '\x1B[${color}m${lines[i]}\x1B[0m';
      }
    }

    return lines.join('\n');
  }
}

final _consoleColors = {
  Level.FINEST: '92',
  Level.FINER: '92',
  Level.FINE: '92',
  Level.INFO: '94',
  Level.WARNING: '93',
  Level.SEVERE: '91',
  Level.SHOUT: '41;97',
};

/// Get the location the message was logged from
Frame _getLogFrame() {
  final trace = Trace.current();
  var i = trace.frames.indexWhere((v) => v.package == 'logging');
  assert(i > 0);
  i = trace.frames.indexWhere((v) => v.package != 'logging', i);
  assert(i > 0);
  return trace.frames[i];
}

String _frameLocation(Frame frame) {
  final Frame(:member, :library, :line, :column) = frame;
  var text = library;

  if (line != null) {
    text += ':$line';
    if (column != null) {
      text += ':$column';
    }
  }

  return text;
}

extension on List<String> {
  void addLines(Object? value) {
    if (value != null) {
      addAll('$value'.split('\n'));
    }
  }
}

extension on StackTrace {
  Trace toTrace() => Trace.from(this);
}

extension FutureLoggingExtensions<T> on Future<T> {
  Future<void> logOnError(
    Logger logger, {
    Object? message,
    Level level = .SEVERE,
  }) {
    return then<void>(
      returnSelf,
      onError: (error, StackTrace stackTrace) {
        final msg = message is Object Function() ? message() : message;
        logger.log(level, msg, error, stackTrace);
      },
    );
  }
}
