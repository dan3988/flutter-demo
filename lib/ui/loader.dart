import 'dart:async';
import 'dart:math' as math;

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:provider/single_child_widget.dart';

import 'package:axcend/ui.dart';

class Loader extends SingleChildStatefulWidget {
  static Future<V> doWork<V>(
    BuildContext context,
    FutureOr<V> Function() work,
  ) {
    final loader = Loader.maybeOf(context);
    return loader == null ? Future.sync(work) : loader.doWork(work);
  }

  static LoaderHandle startLoading(
    BuildContext context, [
    bool initialValue = true,
  ]) => of(context).startLoading(initialValue);

  static LoaderState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType();

  static LoaderState of(BuildContext context) {
    final state = maybeOf(context);
    assert(state != null, 'No Loader in context.');
    return state!;
  }

  final Color? overlayBackground;
  final double? loaderSize;

  const Loader({
    super.key,
    required Widget super.child,
    this.overlayBackground,
    this.loaderSize,
  });

  @override
  State<StatefulWidget> createState() => LoaderState();
}

class LoaderHandle {
  LoaderState? _state;

  bool _active;

  bool get active => _active;

  set active(bool value) {
    if (_active != value) {
      _active = value;
      if (_state != null) {
        (value ? _state!._increment() : _state!._decrement());
      }
    }
  }

  LoaderHandle._(this._state, this._active);

  void dispose() {
    if (_state != null) {
      if (_active) {
        _state!._decrement();
      }
      _state = null;
    } else {
      assert(false, 'Handle already disposed');
    }
  }
}

class LoaderState extends SingleChildState<Loader> {
  var _count = 0;

  bool get isLoading => _count > 0;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_onBack);
  }

  @override
  void dispose() {
    super.dispose();
    BackButtonInterceptor.remove(_onBack);
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Stack(
      children: [
        ?child,
        IgnorePointer(
          ignoring: !isLoading,
          child: AnimatedOpacity(
            opacity: math.min(_count.toDouble(), 1),
            duration: Durations.medium1,
            child: Container(
              color:
                  widget.overlayBackground ??
                  Theme.of(context).colorScheme.surface.withAlpha(64),
              child: Center(
                child: SizedBox.square(
                  dimension: widget.loaderSize,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<V> doWork<V>(FutureOr<V> Function() work) {
    final result = work();
    if (result is! Future<V>) {
      return Future.value(result);
    }

    _increment();
    return result.whenComplete(_decrement);
  }

  void _increment() {
    if (++_count == 1) {
      setState(() {});
    }
  }

  void _decrement() {
    assert(_count > 0);
    if (--_count == 0) {
      setState(() {});
    }
  }

  LoaderHandle startLoading([bool initialValue = true]) {
    if (initialValue) {
      _increment();
    }

    return LoaderHandle._(this, initialValue);
  }

  bool _onBack(bool stopDefaultButtonEvent, RouteInfo routeInfo) => isLoading;
}
