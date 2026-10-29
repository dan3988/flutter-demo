import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app/item_tile.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/app_router.gr.dart';
import 'package:axcend/ui.dart';
import 'package:provider/provider.dart';

@RoutePage()
class UsersListWidget extends StatefulWidget {
  const UsersListWidget({super.key});

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends ListWidgetState<UsersListWidget, User>
    with LoggingStateMixin {
  @override
  FutureListResponse<User> loadData(PlaceholderApi api) {
    return api.users.getAll(abortTrigger: disposed);
  }

  @override
  void onError(error, StackTrace stackTrace) {
    logger.warning('Failed to load users', error, stackTrace);
  }

  @override
  Widget buildItem(BuildContext context, User item) {
    final theme = Theme.of(context);
    return ItemTile(
      leading: Icon(Icons.person_2_outlined),
      title: Text(
        item.username,
        style: theme.textTheme.titleLarge?.copyWith(overflow: .ellipsis),
      ),
      onTap: () => context.pushRoute(UserRoute(user: item)),
    );
  }
}
