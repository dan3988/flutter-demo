import 'dart:async';

import 'package:axcend/api/client.dart';
import 'package:axcend/app/item_tile.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util/logging.dart';

final _log = getLogger(AlbumTile);

class AlbumTile extends StatelessWidget {
  final Album album;

  const AlbumTile({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return ItemTile(title: Text(album.title), onTap: () => _openAlbum(context));
  }

  void _openAlbum(BuildContext context) {
    Loader.doWork(context, () async {
      final List<Photo> photos;
      final User user;

      final api = Provider.of<PlaceholderApi>(context, listen: false);
      final getPhotos = api.albums.getPhotos(album.id);
      final getUser = api.users.get(album.userId);

      try {
        photos = await getPhotos.bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        _log.severe(
          'Failed to get photos for album ${album.id}',
          error,
          stackTrace,
        );
        return;
      }

      try {
        user = await getUser.bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        _log.severe('Failed to get user ${album.userId}', error, stackTrace);
        return;
      }

      if (!context.mounted) {
        return;
      }

      unawaited(
        context.pushRoute(AlbumRoute(album: album, photos: photos, user: user)),
      );
    });
  }
}

class AlbumsListWidget extends StatefulWidget {
  const AlbumsListWidget({super.key});

  @override
  State<AlbumsListWidget> createState() => _AlbumsListWidgetState();
}

class _AlbumsListWidgetState extends ListWidgetState<AlbumsListWidget, Album>
    with LoggingStateMixin {
  @override
  FutureListResponse<Album> loadData(PlaceholderApi api) {
    return api.albums.getAll(abortTrigger: disposed);
  }

  @override
  void onError(error, StackTrace stackTrace) {
    logger.warning('Failed to load posts', error, stackTrace);
  }

  @override
  Widget buildItem(BuildContext context, Album item) {
    return AlbumTile(album: item);
  }
}
