import 'dart:async';

import 'package:axcend/api/client.dart';
import 'package:axcend/ui.dart';
import 'package:chopper/chopper.dart' show Response;

class ListWidget<T> extends StatelessWidget {
  final ScrollController? controller;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final EdgeInsets padding;

  const ListWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.controller,
    this.padding = AppStyle.paddingMedAll,
  });

  @override
  Widget build(BuildContext context) {
    const divider = SizedBox(height: AppStyle.paddingMed);

    return ListView.separated(
      controller: controller,
      padding: padding,
      separatorBuilder: (context, _) => divider,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
  }
}

typedef ItemFilter<T> = bool Function(T item, String filter);

typedef FutureListResponse<T> = Future<Response<List<T>>>;
typedef ListGetter<T> =
    FutureListResponse<T> Function(
      PlaceholderApi api,
      Future<void> abortSignal,
    );

class WebListWidget<T> extends StatefulWidget {
  final Widget Function(BuildContext, T) itemBuilder;
  final ListGetter<T> retrieveData;
  final void Function(dynamic error, StackTrace stackTrace) onError;
  final ItemFilter<T>? filter;

  const WebListWidget({
    super.key,
    required this.itemBuilder,
    required this.retrieveData,
    required this.onError,
    this.filter,
  });

  @override
  State<WebListWidget<T>> createState() => _WebListWidgetState<T>();
}

class _WebListWidgetState<T> extends State<WebListWidget<T>>
    with DisposedSignalState {
  late final TextEditingController _searchController;
  List<T>? _allItems;
  List<T>? _filteredItems;
  ItemFilter<T>? _filter;
  bool _isErrored = false;

  @override
  void initState() {
    super.initState();

    final api = Provider.of<PlaceholderApi>(context, listen: false);
    _filter = widget.filter;
    _searchController = .new();
    _searchController.addListener(_updateFilteredItems);
    _load(api);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void didUpdateWidget(covariant WebListWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_filter != widget.filter) {
      _filter = widget.filter;

      if (_allItems != null) {
        _updateFilteredItems();
      }
    }
  }

  void _load(PlaceholderApi api) async {
    try {
      _allItems = await widget.retrieveData(api, disposed).bodyOrThrow();
      _updateFilteredItems();
    } on Exception catch (error, stackTrace) {
      widget.onError(error, stackTrace);
      setState(() {
        _allItems = const [];
        _isErrored = true;
      });
    }
  }

  void _updateFilteredItems() {
    final filter = widget.filter;
    final text = _searchController.text.toLowerCase();
    var items = _allItems!;
    if (filter != null && text.isNotEmpty) {
      items = items.where((item) => filter(item, text)).toList();
    }

    setState(() => _filteredItems = items);
  }

  @override
  Widget build(BuildContext context) {
    if (_isErrored) {
      return buildError(context);
    }

    final items = _filteredItems;
    if (items == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        if (_filter != null)
          Padding(
            padding: AppStyle.paddingMedAll,
            child: TextField(
              decoration: InputDecoration(
                border: ShapedInputBorder(
                  shape: RoundedRectangleBorder(
                    borderRadius: AppStyle.borderRadiusMedAll,
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainer,
                hint: Localized(text: AppText.searchHint),
                suffixIcon: const Icon(Icons.search),
              ),
              controller: _searchController,
            ),
          ),
        Expanded(
          child: FadingEdgeScrollView.builder(
            builder: (_, controller) {
              return ListWidget(
                controller: controller,
                items: items,
                itemBuilder: widget.itemBuilder,
              );
            },
          ),
        ),
      ],
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
}
