import 'dart:async';

import 'package:axcend/api/client.dart';
import 'package:axcend/app/item_tile.dart';
import 'package:axcend/app/list_widget.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util.dart';

final _log = getLogger(PostsListWidget);

class PostsListWidget extends StatefulWidget {
  const PostsListWidget({super.key});

  @override
  State<PostsListWidget> createState() => _PostsListWidgetState();
}

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ItemTile(
      title: Text(post.title),
      subtitle: Text(post.body, maxLines: 1),
      onTap: () => _openPost(context),
    );
  }

  void _openPost(BuildContext context) {
    Loader.doWork(context, () async {
      final List<Comment> comments;
      final User user;

      final api = Provider.of<PlaceholderApi>(context, listen: false);
      final getComments = api.posts.getComments(post.id);
      final getUser = api.users.get(post.userId);

      try {
        comments = await getComments.bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        _log.severe(
          'Failed to get comments for post ${post.id}',
          error,
          stackTrace,
        );
        return;
      }

      try {
        user = await getUser.bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        _log.severe('Failed to get user ${post.userId}', error, stackTrace);
        return;
      }

      if (!context.mounted) {
        return;
      }

      unawaited(
        context.pushRoute(
          PostRoute(post: post, comments: comments, user: user),
        ),
      );
    });
  }
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
    return PostTile(post: item);
  }
}
