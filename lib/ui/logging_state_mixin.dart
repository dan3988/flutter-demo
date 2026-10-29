import 'package:axcend/ui.dart';
import 'package:axcend/util.dart';

mixin LoggingStateMixin<T extends StatefulWidget> on State<T> {
  @protected
  late final logger = getLogger(T);
}