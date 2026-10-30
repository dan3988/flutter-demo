import 'package:flutter_demo/api/models.dart';
import 'package:flutter_demo/app/albums_list.dart';
import 'package:flutter_demo/app/list_widget.dart';
import 'package:flutter_demo/ui.dart';

@RoutePage()
class UserAlbumsScreen extends StatefulWidget {
  final User user;
  final List<Album> albums;

  const UserAlbumsScreen({super.key, required this.user, required this.albums});

  @override
  State<UserAlbumsScreen> createState() => _UserAlbumsScreenState();
}

class _UserAlbumsScreenState extends State<UserAlbumsScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      title: Localized(
        text: AppText.pageTitleUserAlbums(name: widget.user.username),
      ),
      body: ListWidget(
        items: widget.albums,
        itemBuilder: (_, album) => AlbumTile(album: album),
      ),
    );
  }
}
