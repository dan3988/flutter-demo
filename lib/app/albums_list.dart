import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app/item_tile.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/app_router.gr.dart';
import 'package:axcend/ui.dart';
import 'package:provider/provider.dart';

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
    final theme = Theme.of(context);
    return ItemTile(
      title: Text(
        item.title,
        style: theme.textTheme.titleLarge?.copyWith(overflow: .ellipsis),
      ),
      onTap: () => _openAlbum(item),
    );
  }

  void _openAlbum(Album album) {
    Loader.doWork(context, () async {
      final List<Photo> photos;
      final User user;

      final api = Provider.of<PlaceholderApi>(context, listen: false);
      final getPhotos = api.albums.getPhotos(album.id);
      final getUser = api.users.get(album.userId);

      try {
        photos = await getPhotos.bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        logger.severe(
          'Failed to get photos for album ${album.id}',
          error,
          stackTrace,
        );
        return;
      }

      try {
        user = await getUser.bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        logger.severe('Failed to get user ${album.userId}', error, stackTrace);
        return;
      }

      if (!mounted) {
        return;
      }

      unawaited(
        context.pushRoute(AlbumRoute(album: album, photos: photos, user: user)),
      );
    });
  }
}
