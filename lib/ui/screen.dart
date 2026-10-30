import 'package:flutter_demo/ui.dart';

@immutable
class SafeAreaConfig {
  static const SafeAreaConfig all = .new();

  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;

  const SafeAreaConfig.pad(EdgeInsets minimum) : this(minimum: minimum);

  const SafeAreaConfig({
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
  });
}

/// Helper widget for creating a [Scaffold] with an [AppBar].
class Screen extends StatelessWidget {
  final Widget body;
  final Widget? title;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBarBottom;
  final List<Widget> actions;
  final ColorSet barColor;
  final SafeAreaConfig? safeArea;
  final bool? resizeToAvoidBottomInset;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const Screen({
    super.key,
    required this.body,
    this.title,
    this.floatingActionButton,
    this.appBarBottom,
    this.actions = const [],
    this.barColor = ColorSet.primary,
    this.safeArea,
    this.resizeToAvoidBottomInset,
    this.scaffoldKey,
  });

  @override
  build(context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    var Screen(:body, :safeArea) = this;
    if (safeArea != null) {
      body = SafeArea(
        left: safeArea.left,
        top: safeArea.top,
        right: safeArea.right,
        bottom: safeArea.bottom,
        minimum: safeArea.minimum,
        child: body,
      );
    }

    final (foreground, background) = barColor.getColors(colors);

    return BackgroundUnfocus(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: colors.surfaceContainer,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
          backgroundColor: background,
          foregroundColor: foreground,
          titleTextStyle: theme.appBarTheme.titleTextStyle?.copyWith(color: foreground),
          title: title,
          bottom: appBarBottom,
          actions: actions,
        ),
        floatingActionButton: floatingActionButton,
        body: body,
      ),
    );
  }
}
