import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app_router.gr.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util.dart';
import 'package:provider/provider.dart';

final _log = getLogger(PostsScreen);

@RoutePage()
class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> with DisposedSignalState {
  late Future<List<Post>> _posts;

  @override
  void initState() {
    super.initState();

    final api = Provider.of<PlaceholderApi>(context, listen: false);

    _posts = api.posts.getAll(abortTrigger: disposed).bodyOrThrow().onError((
      error,
      StackTrace stack,
    ) {
      _log.warning('Failed to load posts', error, stack);
      return const [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: FutureBuilder(
        future: _posts,
        builder: (context, state) {
          final posts = state.data;
          if (posts == null) {
            return const SizedBox.shrink();
          }

          final theme = Theme.of(context);
          final titleTheme = theme.textTheme.titleLarge?.copyWith(
            overflow: .ellipsis,
          );

          final bodyTheme = theme.textTheme.labelMedium?.copyWith(
            overflow: .ellipsis,
          );

          return ListView.separated(
            separatorBuilder: (context, _) =>
                Divider(height: 1, color: theme.colorScheme.outline),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title, style: titleTheme),
                subtitle: Text(post.body, style: bodyTheme, maxLines: 1),
                onTap: () {
                  context.pushRoute(PostRoute(postId: post.id));
                },
              );
            },
          );
        },
      ),
    );
  }
}
