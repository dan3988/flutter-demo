import 'package:axcend/ui.dart';

/// Adds a gradient at the start/end of a [SingleChildScrollView] to stop widgets from being cut-off
class FadingScrollOverlay extends StatefulWidget {
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

  const FadingScrollOverlay({
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

  FadingScrollOverlay.row({
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

  FadingScrollOverlay.column({
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

  const FadingScrollOverlay.builder({
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
  State<FadingScrollOverlay> createState() => _FadingScrollOverlayState();
}

class _FadingScrollOverlayState extends State<FadingScrollOverlay> {
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
  void didUpdateWidget(covariant FadingScrollOverlay oldWidget) {
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
