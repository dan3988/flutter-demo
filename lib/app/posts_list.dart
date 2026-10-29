import 'package:auto_route/auto_route.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/app_router.gr.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util.dart';

final _log = getLogger(PostsListWidget);

class PostsListWidget extends StatefulWidget {
  const PostsListWidget({super.key});

  @override
  State<PostsListWidget> createState() => _PostsListWidgetState();
}

class _PostsListWidgetState extends ListWidgetState<PostsListWidget, Post> {
  @override
  FutureListResponse<Post> loadData(PlaceholderApi api) {
    return api.posts.getAll(abortTrigger: disposed);
  }

  @override
  void onError(error, StackTrace stackTrace) {
    _log.warning('Failed to load posts', error, stackTrace);
  }

  @override
  Widget buildItem(BuildContext context, Post item) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        item.title,
        style: theme.textTheme.titleLarge?.copyWith(overflow: .ellipsis),
      ),
      subtitle: Text(
        item.body,
        maxLines: 1,
        style: theme.textTheme.labelMedium?.copyWith(overflow: .ellipsis),
      ),
      onTap: () {
        context.pushRoute(PostRoute(postId: item.id));
      },
    );
  }
}
