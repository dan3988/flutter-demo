import 'package:auto_route/auto_route.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app/user_widget.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util.dart';
import 'package:provider/provider.dart';

final _log = getLogger(PostScreen);

@RoutePage()
class PostScreen extends StatefulWidget {
  final int postId;

  const PostScreen({super.key, required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> with DisposedSignalState {
  late final Future<Post> _getPost;
  late final Future<User> _getUser;
  late final Future<List<Comment>> _getComments;
  late final Future<List> _load;

  @override
  void initState() {
    super.initState();

    final postId = widget.postId;
    final api = Provider.of<PlaceholderApi>(context, listen: false);

    _getPost = api.posts.get(postId).bodyOrThrow();
    _getComments = api.posts.getComments(postId).bodyOrThrow();
    _getUser = _getPost
        .then((post) => api.users.get(post.userId))
        .bodyOrThrow();
    _load = Future.wait([_getPost, _getComments, _getUser]);

    _getPost.logOnError(_log, message: () => 'Failed to load post $postId');
    _getComments.logOnError(
      _log,
      message: () => 'Failed to load comments for post $postId',
    );
    _getUser.logOnError(
      _log,
      message: () => 'Failed to load user for post $postId',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: Text('Post'),
      safeArea: .pad(AppStyle.paddingMedAll),
      body: FutureBuilder(
        future: _load,
        builder: (context, state) {
          final theme = Theme.of(context);
          if (state.hasError) {
            return Text(
              'An unexpected error occurred',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            );
          }

          if (!state.hasData) {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: const CircularProgressIndicator(),
              ),
            );
          }

          final [Post post, List<Comment> comments, User user] = state.data!;

          return _PostWidget(post, user, comments);
        },
      ),
    );
  }
}

class _PostWidget extends StatelessWidget {
  static const _commentsSeparator = SizedBox(height: AppStyle.paddingMed);

  final Post post;
  final User user;
  final List<Comment> comments;

  const _PostWidget(this.post, this.user, this.comments);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
        UserWidget(
          user: user,
        ),
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
