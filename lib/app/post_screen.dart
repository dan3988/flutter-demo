import 'package:flutter_demo/api/client.dart';
import 'package:flutter_demo/app/author_tile.dart';
import 'package:flutter_demo/app/item_tile.dart';
import 'package:flutter_demo/ui.dart';

@RoutePage()
class PostScreen extends StatefulWidget {
  final Post post;
  final User user;
  final List<Comment> comments;

  const PostScreen({
    super.key,
    required this.post,
    required this.user,
    required this.comments,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> with DisposedSignalState {
  static const _commentsSeparator = SizedBox(height: AppStyle.paddingMed);

  @override
  Widget build(BuildContext context) {
    final PostScreen(:post, :user, :comments) = widget;
    final theme = Theme.of(context);
    return Screen(
      title: const Localized(text: AppText.pageTitlePost),
      safeArea: const .pad(AppStyle.paddingMedAll),
      body: Column(
        mainAxisSize: .max,
        crossAxisAlignment: .stretch,
        spacing: AppStyle.paddingMed,
        children: [
          Text(
            post.title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          Text(
            post.body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          AuthorTile(author: user),
          Localized(
            text: AppText.postComments(count: comments.length),
            style: theme.textTheme.titleMedium,
          ),
          Expanded(
            child: FadingEdgeScrollView.builder(
              padding: AppStyle.paddingMedV,
              builder: (context, controller) {
                return ListView.separated(
                  controller: controller,
                  itemCount: comments.length,
                  separatorBuilder: (_, _) => _commentsSeparator,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ItemTile(title: Text(comment.name), subtitle: Text(comment.body));
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
