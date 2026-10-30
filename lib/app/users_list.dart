import 'package:axcend/app/item_tile.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util/logging.dart';

class UsersListWidget extends StatelessWidget {
  static final _log = getLogger(UsersListWidget);

  const UsersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WebListWidget(
      filter: (item, search) =>
          item.name.toLowerCase().contains(search) ||
          item.username.toLowerCase().contains(search),
      retrieveData: (api, trigger) => api.users.getAll(abortTrigger: trigger),
      onError: (error, stackTrace) =>
          _log.warning('Failed to load users', error, stackTrace),
      itemBuilder: (_, item) {
        final theme = Theme.of(context);
        return ItemTile(
          leading: Icon(Icons.person_2_outlined),
          title: Localized(
            text: AppText.userDisplay(name: item.name, username: item.username),
            style: theme.textTheme.titleLarge?.copyWith(overflow: .ellipsis),
          ),
          onTap: () => context.pushRoute(UserRoute(user: item)),
        );
      },
    );
  }
}
