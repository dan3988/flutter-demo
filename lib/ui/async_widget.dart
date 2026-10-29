import 'package:axcend/ui.dart';

class AsyncWidget<T> extends StatelessWidget {
  final Future<T> future;
  final T? initialData;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context, Object? error) errorBuilder;
  final WidgetBuilder waitingBuilder;

  const AsyncWidget({
    super.key,
    required this.future,
    required this.builder,
    required this.waitingBuilder,
    this.initialData,
    this.errorBuilder = _buildEmpty,
  });

  const AsyncWidget.spinner({
    super.key,
    required this.future,
    required this.builder,
    this.initialData,
    this.errorBuilder = _buildEmpty,
  }) : waitingBuilder = _buildSpinner;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      initialData: initialData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        } else if (snapshot.hasError) {
          return errorBuilder(context, snapshot.error);
        } else {
          return waitingBuilder(context);
        }
      },
    );
  }
}

Widget _buildEmpty(BuildContext _, [Object? _]) => const SizedBox.shrink();

Widget _buildSpinner(BuildContext _) {
  return const Center(child: CircularProgressIndicator());
}