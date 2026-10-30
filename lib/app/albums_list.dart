import 'dart:async';

import 'package:flutter_demo/api/client.dart';
import 'package:flutter_demo/app/item_tile.dart';
import 'package:flutter_demo/app/list_widget.dart';
import 'package:flutter_demo/ui.dart';
import 'package:flutter_demo/util/logging.dart';

class AlbumTile extends StatelessWidget {
  static final _log = getLogger(AlbumTile);

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

class AlbumsListWidget extends StatelessWidget {
  static final _log = getLogger(AlbumsListWidget);

  const AlbumsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WebListWidget(
      filter: (item, search) => item.title.toLowerCase().contains(search),
      itemBuilder: (_, album) => AlbumTile(album: album),
      retrieveData: (api, trigger) => api.albums.getAll(abortTrigger: trigger),
      onError: (error, stackTrace) =>  _log.warning('Failed to load albums', error, stackTrace),
    );
  }
}
