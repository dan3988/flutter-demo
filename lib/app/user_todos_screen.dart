import 'package:flutter_demo/api/models.dart';
import 'package:flutter_demo/app/list_widget.dart';
import 'package:flutter_demo/app/todo_list.dart';
import 'package:flutter_demo/ui.dart';

@RoutePage()
class UserTodosScreen extends StatefulWidget {
  final User user;
  final List<Todo> todos;

  const UserTodosScreen({super.key, required this.user, required this.todos});

  @override
  State<UserTodosScreen> createState() => _UserTodosScreenState();
}

class _UserTodosScreenState extends State<UserTodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      title: Localized(
        text: AppText.pageTitleUserTodos(name: widget.user.username),
      ),
      body: ListWidget(
        items: widget.todos,
        itemBuilder: (_, todo) => TodoTile(todo: todo),
      ),
    );
  }
}
