import 'package:flutter_demo/api/models.dart';
import 'package:flutter_demo/app/list_widget.dart';
import 'package:flutter_demo/app/posts_list.dart';
import 'package:flutter_demo/ui.dart';

@RoutePage()
class UserPostsScreen extends StatefulWidget {
  final User user;
  final List<Post> posts;

  const UserPostsScreen({super.key, required this.user, required this.posts});

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      title: Localized(
        text: AppText.pageTitleUserPosts(name: widget.user.username),
      ),
      body: ListWidget(
        items: widget.posts,
        itemBuilder: (_, post) => PostTile(post: post),
      ),
    );
  }
}
