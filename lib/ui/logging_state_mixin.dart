import 'package:flutter_demo/ui.dart';
import 'package:flutter_demo/util.dart';

mixin LoggingStateMixin<T extends StatefulWidget> on State<T> {
  @protected
  late final logger = getLogger(T);
}