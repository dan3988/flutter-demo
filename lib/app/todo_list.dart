import 'package:axcend/api/client.dart';
import 'package:axcend/app/item_tile.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ItemTile(
      leading: todo.completed
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.cancel, color: Colors.red),
      title: Text(todo.title),
    );
  }
}

class TodosListWidget extends StatelessWidget {
  static final _log = getLogger(TodosListWidget);

  const TodosListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WebListWidget(
      itemBuilder: (_, todo) => TodoTile(todo: todo),
      retrieveData: (api, trigger) => api.todos.getAll(abortTrigger: trigger),
      onError: (error, stackTrace) =>  _log.warning('Failed to load todos', error, stackTrace),
    );
  }
}
