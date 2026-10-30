import 'package:provider/single_child_widget.dart';

import 'package:flutter_demo/ui.dart';

class ClippedBorder extends SingleChildStatelessWidget {
  final ShapeBorder border;
  final Clip clipBehavior;
  final Color? color;

  ClippedBorder.round({
    super.key,
    required Widget super.child,
    BorderSide side = .none,
    required BorderRadius radius,
    this.clipBehavior = Clip.antiAlias,
    this.color,
  }) : border = RoundedRectangleBorder(
    borderRadius: radius,
    side: side,
  );

  const ClippedBorder({
    super.key,
    required Widget super.child,
    required this.border,
    this.clipBehavior = Clip.antiAlias,
    this.color,
  });

  @override
  buildWithChild(context, child) {
    Widget current = DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: ShapeDecoration(
        shape: border,
      ),
      child: child,
    );

    if (color != null) {
      current = ColoredBox(
        color: color!,
        child: current,
      );
    }

    return ClipPath(
      clipper: ShapeBorderClipper(shape: border),
      clipBehavior: clipBehavior,
      child: current,
    );
  }
}
