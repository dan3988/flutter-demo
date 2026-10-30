import 'package:flutter_test/flutter_test.dart';

import 'unit/models_test.dart' as models_test;
import 'unit/util_test.dart' as util_test;
import 'widget/ui_components_test.dart' as ui_components_test;
import 'widget/web_list_widget_test.dart' as web_list_widget_test;

void main() {
  group('Models Tests', models_test.main);
  group('Utils Tests', util_test.main);
  group('UI Components Tests', ui_components_test.main);
  group('WebListWidget Tests', web_list_widget_test.main);
}
