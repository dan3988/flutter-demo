import 'package:auto_route/auto_route.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app_router.gr.dart';
import 'package:axcend/ui.dart';

class UserWidget extends StatelessWidget {
  final User user;

  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    return Material(
      color: colors.secondaryContainer,
      borderRadius: AppStyle.borderRadiusMedAll,
      clipBehavior: .hardEdge,
      child: ListTile(
        textColor: colors.onSecondaryContainer,
        leading: Icon(Icons.person_2_outlined),
        title: Text(user.username),
        onTap: () {
          context.pushRoute(UserRoute(user: user));
        },
      ),
    );
  }
}
