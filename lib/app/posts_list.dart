import 'dart:async';

import 'package:flutter_demo/api/client.dart';
import 'package:flutter_demo/app/item_tile.dart';
import 'package:flutter_demo/app/list_widget.dart';
import 'package:flutter_demo/ui.dart';
import 'package:flutter_demo/util.dart';

class PostTile extends StatelessWidget {
  static final _log = getLogger(PostsListWidget);

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

class PostsListWidget extends StatelessWidget {
  static final _log = getLogger(PostsListWidget);

  const PostsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WebListWidget(
      filter: (item, search) => item.title.toLowerCase().contains(search),
      itemBuilder: (_, post) => PostTile(post: post),
      retrieveData: (api, trigger) => api.posts.getAll(abortTrigger: trigger),
      onError: (error, stackTrace) =>
          _log.warning('Failed to load posts', error, stackTrace),
    );
  }
}
