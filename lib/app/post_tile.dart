// import 'dart:async';
//
// import 'package:auto_route/auto_route.dart';
// import 'package:axcend/api/client.dart';
// import 'package:axcend/app/item_tile.dart';
// import 'package:axcend/app_router.gr.dart';
// import 'package:axcend/ui.dart';
// import 'package:axcend/util.dart';
// import 'package:provider/provider.dart';
//
// final _log = getLogger(PostTile);
//
// class PostTile extends StatelessWidget {
//   final Post post;
//   final VoidCallback? onTap;
//
//   const PostTile({super.key, required this.post, this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return ItemTile(
//       title: Text(post.title),
//       subtitle: Text(post.body, maxLines: 1),
//       onTap: () => _openPost(context, post),
//     );
//   }
//
//   void _openPost(BuildContext context, Post post) {
//     Loader.doWork(context, () async {
//       final List<Comment> comments;
//       final User user;
//
//       final api = Provider.of<PlaceholderApi>(context, listen: false);
//       final getComments = api.posts.getComments(post.id);
//       final getUser = api.users.get(post.userId);
//
//       try {
//         comments = await getComments.bodyOrThrow();
//       } on Exception catch (error, stackTrace) {
//         _log.severe(
//           'Failed to get comments for post ${post.id}',
//           error,
//           stackTrace,
//         );
//         return;
//       }
//
//       try {
//         user = await getUser.bodyOrThrow();
//       } on Exception catch (error, stackTrace) {
//         _log.severe('Failed to get user ${post.userId}', error, stackTrace);
//         return;
//       }
//
//       if (!context.mounted) {
//         return;
//       }
//
//       unawaited(
//         context.pushRoute(
//           PostRoute(post: post, comments: comments, user: user),
//         ),
//       );
//     });
//   }
// }
