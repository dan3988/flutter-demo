import 'package:axcend/api/client.dart';
import 'package:axcend/app/item_tile.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util.dart';

final _log = getLogger(TodosListWidget);

class TodosListWidget extends StatefulWidget {
  const TodosListWidget({super.key});

  @override
  State<TodosListWidget> createState() => _TodosListWidgetState();
}

class _TodosListWidgetState extends ListWidgetState<TodosListWidget, Todo> {
  @override
  FutureListResponse<Todo> loadData(PlaceholderApi api) {
    return api.todos.getAll(abortTrigger: disposed);
  }

  @override
  void onError(error, StackTrace stackTrace) {
    _log.warning('Failed to load todos', error, stackTrace);
  }

  @override
  Widget buildItem(BuildContext context, Todo item) {
    final theme = Theme.of(context);
    return ItemTile(
      leading: item.completed
          ? Icon(Icons.check_circle, color: Colors.green)
          : Icon(Icons.cancel, color: Colors.red),
      title: Text(
        item.title,
        style: theme.textTheme.titleLarge?.copyWith(overflow: .ellipsis),
      ),
    );
  }
}
