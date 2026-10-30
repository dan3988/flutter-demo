import 'package:flutter_demo/ui.dart';

abstract class AppStyle {
  static const double paddingMed = 5;
  static const EdgeInsets paddingMedAll = .all(paddingMed);
  static const EdgeInsets paddingMedH = .symmetric(horizontal: paddingMed);
  static const EdgeInsets paddingMedV = .symmetric(vertical: paddingMed);

  static const Radius borderRadiusMed = .circular(10);
  static const BorderRadius borderRadiusMedAll = .all(borderRadiusMed);
  static const BorderRadius borderRadiusMedTop = .vertical(top: borderRadiusMed);
  static const BorderRadius borderRadiusMedBottom = .vertical(bottom: borderRadiusMed);
}
