// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:axcend/app/post_screen.dart' as _i1;
import 'package:axcend/app/posts_screen.dart' as _i2;
import 'package:axcend/ui.dart' as _i4;

/// generated route for
/// [_i1.PostScreen]
class PostRoute extends _i3.PageRouteInfo<PostRouteArgs> {
  PostRoute({
    _i4.Key? key,
    required int postId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         PostRoute.name,
         args: PostRouteArgs(key: key, postId: postId),
         initialChildren: children,
       );

  static const String name = 'PostRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostRouteArgs>();
      return _i1.PostScreen(key: args.key, postId: args.postId);
    },
  );
}

class PostRouteArgs {
  const PostRouteArgs({this.key, required this.postId});

  final _i4.Key? key;

  final int postId;

  @override
  String toString() {
    return 'PostRouteArgs{key: $key, postId: $postId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostRouteArgs) return false;
    return key == other.key && postId == other.postId;
  }

  @override
  int get hashCode => key.hashCode ^ postId.hashCode;
}

/// generated route for
/// [_i2.PostsScreen]
class PostsRoute extends _i3.PageRouteInfo<void> {
  const PostsRoute({List<_i3.PageRouteInfo>? children})
    : super(PostsRoute.name, initialChildren: children);

  static const String name = 'PostsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.PostsScreen();
    },
  );
}
