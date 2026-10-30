import 'dart:math' as math;

import 'package:axcend/api/client.dart';
import 'package:axcend/app/author_tile.dart';
import 'package:axcend/ui.dart';

@RoutePage()
class AlbumScreen extends StatelessWidget {
  final Album album;
  final List<Photo> photos;
  final User user;

  const AlbumScreen({
    super.key,
    required this.album,
    required this.photos,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Screen(
      safeArea: .pad(AppStyle.paddingMedAll),
      title: Localized(text: AppText.pageTitleAlbum),
      body: Column(
        spacing: AppStyle.paddingMed,
        children: [
          Text(
            album.title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: .start,
          ),
          AuthorTile(author: user),
          Expanded(
            child: ClipPath(
              clipBehavior: .antiAlias,
              child: FadingEdgeScrollView.builder(
                builder: (context, controller) {
                  return GridView(
                    clipBehavior: .none,
                    controller: controller,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width ~/ 100,
                      crossAxisSpacing: AppStyle.paddingMed,
                      childAspectRatio: 1,
                      mainAxisSpacing: AppStyle.paddingMed,
                    ),
                    children: [for (final photo in photos) _PhotoWidget(photo)],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoWidget extends StatelessWidget {
  final Photo photo;

  const _PhotoWidget(this.photo);

  @override
  Widget build(BuildContext context) {
    return ClippedBorder(
      border: RoundedRectangleBorder(
        borderRadius: AppStyle.borderRadiusMedAll,
        side: .new(color: Theme.of(context).colorScheme.outline, width: 1),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            photo.thumbnailUrl,
            fit: BoxFit.cover,
            loadingBuilder: _imageLoadingBuilder,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(onTap: () {
              showDialog(context: context, builder: (_) => _PhotoDialog(photo));
            }),
          ),
        ],
      ),
    );
  }
}

class _PhotoDialog extends StatelessWidget {
  final Photo photo;

  const _PhotoDialog(this.photo);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final imageSize = math.min(
      mediaQuery.size.width * 0.85,
      mediaQuery.size.height * 0.65,
    );

    return Dialog(
      insetPadding: AppStyle.paddingMedAll,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: AppStyle.borderRadiusMedAll,
      ),
      child: SizedBox(
        width: imageSize,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox.square(
                dimension: imageSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        photo.url,
                        fit: BoxFit.cover,
                        loadingBuilder: _imageLoadingBuilder,
                      ),
                    ),
                    Align(
                      alignment: .topRight,
                      child: Padding(
                        padding: AppStyle.paddingMedAll,
                        child: IconButton.filledTonal(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: AppStyle.paddingMedAll,
                child: Text(
                  photo.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _imageLoadingBuilder(
  BuildContext _,
  Widget child,
  ImageChunkEvent? progress,
) {
  if (progress == null) {
    return child;
  }

  return Center(
    child: CircularProgressIndicator(
      value: progress.expectedTotalBytes != null
          ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
          : null,
    ),
  );
}
