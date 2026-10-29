import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/app_router.gr.dart';
import 'package:axcend/ui.dart';
import 'package:provider/provider.dart';

class PostsListWidget extends StatefulWidget {
  const PostsListWidget({super.key});

  @override
  State<PostsListWidget> createState() => _PostsListWidgetState();
}

class _PostsListWidgetState extends ListWidgetState<PostsListWidget, Post>
    with LoggingStateMixin {
  @override
  FutureListResponse<Post> loadData(PlaceholderApi api) {
    return api.posts.getAll(abortTrigger: disposed);
  }

  @override
  void onError(error, StackTrace stackTrace) {
    logger.warning('Failed to load posts', error, stackTrace);
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
      onTap: () => _openPost(item),
    );
  }

  void _openPost(Post post) {
    Loader.doWork(context, () async {
      final List<Comment> comments;
      final User user;

      final api = Provider.of<PlaceholderApi>(context, listen: false);
      final getComments = api.posts.getComments(post.id);
      final getUser = api.users.get(post.userId);

      try {
        comments = await getComments.bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        logger.severe(
          'Failed to get comments for post ${post.id}',
          error,
          stackTrace,
        );
        return;
      }

      try {
        user = await getUser.bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        logger.severe('Failed to get user ${post.userId}', error, stackTrace);
        return;
      }

      if (!mounted) {
        return;
      }

      unawaited(
        context.pushRoute(PostRoute(post: post, comments: comments, user: user)),
      );
    });
  }
}
