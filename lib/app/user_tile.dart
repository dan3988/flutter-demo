import 'package:axcend/api/client.dart';
import 'package:axcend/app/item_tile.dart';
import 'package:axcend/ui.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ItemTile(
      title: Text(user.username),
      subtitle: Text(user.company.name),
    );
  }
}