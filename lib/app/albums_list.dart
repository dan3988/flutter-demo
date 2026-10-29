import 'package:axcend/api/client.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util/logging.dart';

final _log = getLogger(AlbumsListWidget);

class AlbumsListWidget extends StatefulWidget {
  const AlbumsListWidget({super.key});

  @override
  State<AlbumsListWidget> createState() => _AlbumsListWidgetState();
}

class _AlbumsListWidgetState extends ListWidgetState<AlbumsListWidget, Album> {
  @override
  FutureListResponse<Album> loadData(PlaceholderApi api) {
    return api.albums.getAll(abortTrigger: disposed);
  }

  @override
  void onError(error, StackTrace stackTrace) {
    _log.warning('Failed to load posts', error, stackTrace);
  }

  @override
  Widget buildItem(BuildContext context, Album item) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        item.title,
        style: theme.textTheme.titleLarge?.copyWith(overflow: .ellipsis),
      ),
      onTap: () {
        // TODO add album page
      },
    );
  }
}
