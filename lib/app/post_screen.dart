import 'package:auto_route/auto_route.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app/user_widget.dart';
import 'package:axcend/ui.dart';

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
      title: Text('Post'),
      safeArea: .pad(AppStyle.paddingMedAll),
      body: Column(
        mainAxisSize: .max,
        crossAxisAlignment: .stretch,
        spacing: AppStyle.paddingMed,
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: .circular(10),
            ),
            child: ListTile(
              title: Text(
                post.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              subtitle: Text(
                post.body,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
          UserWidget(user: user),
          Text(
            'Comments (${comments.length})',
            style: theme.textTheme.titleMedium,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: comments.length,
              separatorBuilder: (_, _) => _commentsSeparator,
              itemBuilder: (context, index) => _CommentWidget(comments[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentWidget extends StatelessWidget {
  final Comment comment;

  const _CommentWidget(this.comment);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: .circular(10),
      ),
      child: ListTile(
        title: Text(
          comment.name,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        subtitle: Text(
          comment.body,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
