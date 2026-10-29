import 'package:auto_route/annotations.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app/user_widget.dart';
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
      safeArea: .new(),
      title: Localized(text: AppText.pageTitleAlbum),
      body: Column(
        children: [
          Expanded(
            child: ClipPath(
              clipBehavior: .antiAlias,
              child: FadingScrollOverlay.builder(
                margin: AppStyle.paddingMedAll,
                builder: (context, controller) {
                  return GridView(
                    clipBehavior: .none,
                    controller: controller,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
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
          UserWidget(
            user: user,
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
      child: Image.network(
        photo.url,
        loadingBuilder: (context, child, progress) {
          if (progress == null) {
            return child;
          }

          return Center(
            child: CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }
}
