import 'package:flutter/material.dart';

import 'package:provider/single_child_widget.dart';

/// Un-focus fields when clicking outside them
class BackgroundUnfocus extends SingleChildStatefulWidget {
  const BackgroundUnfocus({super.key, required Widget super.child});

  @override
  State<StatefulWidget> createState() => _BackgroundUnfocusState();
}

class _BackgroundUnfocusState extends SingleChildState<BackgroundUnfocus> {
  @override
  buildWithChild(context, child) {
    return GestureDetector(
      onTap: _tapped,
      child: child,
    );
  }

  void _tapped() {
    final focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
      focus.focusedChild!.unfocus();
    }
  }
}
