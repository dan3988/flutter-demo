import 'package:chopper/chopper.dart' show Response;

import 'package:axcend/api/client.dart';
import 'package:axcend/ui.dart';

typedef FutureListResponse<T> = Future<Response<List<T>>>;

class ListWidget<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;

  const ListWidget({super.key, required this.items, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    const divider = SizedBox(height: AppStyle.paddingMed);

    return ListView.separated(
      padding: AppStyle.paddingMedAll,
      separatorBuilder: (context, _) => divider,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
  }
}

abstract class ListWidgetState<W extends StatefulWidget, T> extends State<W>
    with DisposedSignalState {
  late Future<List<T>> _dataFuture;

  FutureListResponse<T> loadData(PlaceholderApi api);

  void onError(dynamic error, StackTrace stackTrace);

  @override
  void initState() {
    super.initState();

    final api = Provider.of<PlaceholderApi>(context, listen: false);

    _dataFuture = loadData(api).bodyOrThrow().onError((
      error,
      StackTrace stackTrace,
    ) {
      onError(error, stackTrace);
      return const [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (context, state) {
        if (state.hasError) {
          return buildError(context);
        }

        final items = state.data;
        if (items == null) {
          return Center(child: SizedBox(child: CircularProgressIndicator()));
        }

        return ListWidget(items: items, itemBuilder: buildItem);
      },
    );
  }

  Widget buildError(BuildContext context) {
    final theme = Theme.of(context);
    return Localized(
      text: AppText.appErrorGeneric,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.error,
      ),
    );
  }

  Widget buildItem(BuildContext context, T item);
}
