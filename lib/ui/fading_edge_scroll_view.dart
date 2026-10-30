import 'package:flutter_demo/ui.dart';

/// A scrollable widget that applies dynamic fading gradient edges at the start and end
/// of its viewport.
///
/// As the user scrolls, the fading gradients automatically adjust based on the current
/// scroll offset:
/// * When scrolled to the very top or left, the start fading gradient disappears.
/// * When scrolled to the very bottom or right, the end fading gradient disappears.
/// * As content extends beyond the view edges, fading gradients dynamically appear to
///   indicate additional scrollable content and prevent visual harsh cut-offs.
///
/// ### Usage Examples
///
/// Wrapping a single child widget:
/// ```dart
/// FadingEdgeScrollView(
///   child: Column(
///     children: [ ... ],
///   ),
/// )
/// ```
///
/// Using convenience constructors for a [Row] or [Column]:
/// ```dart
/// FadingEdgeScrollView.column(
///   spacing: 8.0,
///   children: [ ... ],
/// )
/// ```
///
/// Custom scrollable builder (e.g. for [GridView] or [ListView]):
/// ```dart
/// FadingEdgeScrollView.builder(
///   builder: (context, controller) {
///     return ListView.builder(
///       controller: controller,
///       itemCount: 100,
///       itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
///     );
///   },
/// )
/// ```
class FadingEdgeScrollView extends StatefulWidget {
  final Widget? child;
  final Axis scrollDirection;
  final ScrollableWidgetBuilder? builder;
  final ScrollController? controller;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color? color;
  final Color? gradientColor;
  final bool gradientDisabled;
  final double gradientFraction;
  final EdgeInsets gradientInset;

  /// Creates a [FadingEdgeScrollView] wrapping a single [child] in a [SingleChildScrollView].
  const FadingEdgeScrollView({
    super.key,
    required Widget this.child,
    this.gradientColor,
    this.gradientDisabled = false,
    this.gradientFraction = 0.1,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.color,
  }) : builder = null,
       gradientInset = padding;

  /// Creates a horizontal [FadingEdgeScrollView] wrapping [children] inside a [Row].
  FadingEdgeScrollView.row({
    super.key,
    required List<Widget> children,
    this.gradientColor,
    this.gradientDisabled = false,
    double spacing = 0,
    EdgeInsets padding = EdgeInsets.zero,
    this.gradientFraction = 0.1,
    EdgeInsets? gradientInset,
    this.margin = EdgeInsets.zero,
    this.controller,
    this.color,
  }) : builder = null,
       gradientInset = gradientInset ?? padding,
       padding = padding + (gradientInset ?? EdgeInsets.zero),
       scrollDirection = Axis.horizontal,
       child = Row(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         spacing: spacing,
         children: children,
       );

  /// Creates a vertical [FadingEdgeScrollView] wrapping [children] inside a [Column].
  FadingEdgeScrollView.column({
    super.key,
    required List<Widget> children,
    this.gradientColor,
    this.gradientDisabled = false,
    double spacing = 0,
    EdgeInsets padding = EdgeInsets.zero,
    this.gradientFraction = 0.1,
    EdgeInsets? gradientInset,
    this.margin = EdgeInsets.zero,
    this.controller,
    this.color,
  }) : builder = null,
       gradientInset = gradientInset ?? padding,
       padding = padding + (gradientInset ?? EdgeInsets.zero),
       scrollDirection = Axis.vertical,
       child = Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         spacing: spacing,
         children: children,
       );

  /// Creates a [FadingEdgeScrollView] using a custom scrollable [builder] function.
  ///
  /// The [builder] receives a [ScrollController] that must be attached to the inner
  /// scrollable widget (such as [ListView.builder] or [GridView.builder]).
  const FadingEdgeScrollView.builder({
    super.key,
    required ScrollableWidgetBuilder this.builder,
    this.padding = .zero,
    this.gradientColor,
    this.gradientDisabled = false,
    this.gradientFraction = 0.1,
    this.gradientInset = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    this.margin = EdgeInsets.zero,
    this.controller,
    this.color,
  }) : child = null;

  @override
  State<FadingEdgeScrollView> createState() => _FadingEdgeScrollViewState();
}

class _FadingEdgeScrollViewState extends State<FadingEdgeScrollView> {
  late ScrollController _controller;
  var _ownsController = false;
  var _ratioStart = 0.0;
  var _ratioEnd = 0.0;

  ScrollController _getController() {
    var controller = widget.controller;
    if (controller == null) {
      controller = ScrollController();
      _ownsController = true;
    }

    return controller;
  }

  @override
  void initState() {
    _controller = _getController();
    _controller.addListener(_onScrollChanged);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_onScrollChanged);

    if (_ownsController) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget child;
    if (widget.builder == null) {
      child = SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        controller: _controller,
        child: Padding(padding: widget.padding, child: widget.child!),
      );
    } else {
      child = widget.builder!(context, _controller);
    }

    final BoxDecoration? foreground;
    if (widget.gradientDisabled) {
      foreground = null;
    } else {
      final gradient =
          widget.gradientColor ?? ColorScheme.of(context).surfaceContainer;
      final transparent = gradient.withAlpha(0);
      final (begin, end) = widget.scrollDirection == Axis.vertical
          ? (Alignment.topCenter, Alignment.bottomCenter)
          : (Alignment.centerLeft, Alignment.centerRight);
      foreground = BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          stops: [0, _ratioStart, 1 - _ratioEnd, 1],
          colors: [gradient, transparent, transparent, gradient],
        ),
      );
    }

    return Container(
      padding: widget.margin,
      color: widget.color,
      foregroundDecoration: foreground,
      child: NotificationListener<ScrollMetricsNotification>(
        child: child,
        onNotification: (_) {
          _onScrollChanged();
          return false;
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant FadingEdgeScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (_ownsController) {
        _controller.dispose();
        _ownsController = false;
      }

      _controller.removeListener(_onScrollChanged);
      _controller = _getController();
      _controller.addListener(_onScrollChanged);
    }
  }

  void _onScrollChanged() {
    final ScrollPosition(
      :pixels,
      viewportDimension: dim,
      minScrollExtent: min,
      maxScrollExtent: max,
    ) = _controller.positions.last;
    final gradientSize = (widget.gradientFraction / 2) * dim;
    final (padStart, padEnd) = widget.scrollDirection == Axis.vertical
        ? (widget.gradientInset.top, widget.gradientInset.bottom)
        : (widget.gradientInset.left, widget.gradientInset.right);
    final start =
        (padStart + clampDouble(pixels - min - padStart, 0, gradientSize)) /
        dim;
    final end =
        (padEnd + clampDouble(max - pixels - padEnd, 0, gradientSize)) / dim;
    if (_ratioStart != start || _ratioEnd != end) {
      setState(() {
        _ratioStart = start;
        _ratioEnd = end;
      });
    }
  }
}
