import 'package:axcend/api/client.dart';
import 'package:axcend/ui.dart';

class AuthorTile extends StatelessWidget {
  final User author;

  const AuthorTile({super.key, required this.author});

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
        title: Localized(
          text: AppText.itemAuthor(
            name: author.name,
            username: author.username,
          ),
        ),
        onTap: () {
          context.pushRoute(UserRoute(user: author));
        },
      ),
    );
  }
}
