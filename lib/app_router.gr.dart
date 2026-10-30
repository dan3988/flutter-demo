// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:collection/collection.dart' as _i11;

import 'package:flutter_demo/api/client.dart' as _i10;
import 'package:flutter_demo/api/models.dart' as _i12;
import 'package:flutter_demo/app/album_screen.dart' as _i1;
import 'package:flutter_demo/app/home_screen.dart' as _i2;
import 'package:flutter_demo/app/post_screen.dart' as _i3;
import 'package:flutter_demo/app/user_albums_screen.dart' as _i4;
import 'package:flutter_demo/app/user_posts_screen.dart' as _i5;
import 'package:flutter_demo/app/user_screen.dart' as _i6;
import 'package:flutter_demo/app/user_todos_screen.dart' as _i7;
import 'package:flutter_demo/ui.dart' as _i9;

/// generated route for
/// [_i1.AlbumScreen]
class AlbumRoute extends _i8.PageRouteInfo<AlbumRouteArgs> {
  AlbumRoute({
    _i9.Key? key,
    required _i10.Album album,
    required List<_i10.Photo> photos,
    required _i10.User user,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         AlbumRoute.name,
         args: AlbumRouteArgs(
           key: key,
           album: album,
           photos: photos,
           user: user,
         ),
         initialChildren: children,
       );

  static const String name = 'AlbumRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AlbumRouteArgs>();
      return _i1.AlbumScreen(
        key: args.key,
        album: args.album,
        photos: args.photos,
        user: args.user,
      );
    },
  );
}

class AlbumRouteArgs {
  const AlbumRouteArgs({
    this.key,
    required this.album,
    required this.photos,
    required this.user,
  });

  final _i9.Key? key;

  final _i10.Album album;

  final List<_i10.Photo> photos;

  final _i10.User user;

  @override
  String toString() {
    return 'AlbumRouteArgs{key: $key, album: $album, photos: $photos, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AlbumRouteArgs) return false;
    return key == other.key &&
        album == other.album &&
        const _i11.ListEquality<_i10.Photo>().equals(photos, other.photos) &&
        user == other.user;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      album.hashCode ^
      const _i11.ListEquality<_i10.Photo>().hash(photos) ^
      user.hashCode;
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.PostScreen]
class PostRoute extends _i8.PageRouteInfo<PostRouteArgs> {
  PostRoute({
    _i9.Key? key,
    required _i10.Post post,
    required _i10.User user,
    required List<_i10.Comment> comments,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         PostRoute.name,
         args: PostRouteArgs(
           key: key,
           post: post,
           user: user,
           comments: comments,
         ),
         initialChildren: children,
       );

  static const String name = 'PostRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostRouteArgs>();
      return _i3.PostScreen(
        key: args.key,
        post: args.post,
        user: args.user,
        comments: args.comments,
      );
    },
  );
}

class PostRouteArgs {
  const PostRouteArgs({
    this.key,
    required this.post,
    required this.user,
    required this.comments,
  });

  final _i9.Key? key;

  final _i10.Post post;

  final _i10.User user;

  final List<_i10.Comment> comments;

  @override
  String toString() {
    return 'PostRouteArgs{key: $key, post: $post, user: $user, comments: $comments}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostRouteArgs) return false;
    return key == other.key &&
        post == other.post &&
        user == other.user &&
        const _i11.ListEquality<_i10.Comment>().equals(
          comments,
          other.comments,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      post.hashCode ^
      user.hashCode ^
      const _i11.ListEquality<_i10.Comment>().hash(comments);
}

/// generated route for
/// [_i4.UserAlbumsScreen]
class UserAlbumsRoute extends _i8.PageRouteInfo<UserAlbumsRouteArgs> {
  UserAlbumsRoute({
    _i9.Key? key,
    required _i12.User user,
    required List<_i12.Album> albums,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         UserAlbumsRoute.name,
         args: UserAlbumsRouteArgs(key: key, user: user, albums: albums),
         initialChildren: children,
       );

  static const String name = 'UserAlbumsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserAlbumsRouteArgs>();
      return _i4.UserAlbumsScreen(
        key: args.key,
        user: args.user,
        albums: args.albums,
      );
    },
  );
}

class UserAlbumsRouteArgs {
  const UserAlbumsRouteArgs({
    this.key,
    required this.user,
    required this.albums,
  });

  final _i9.Key? key;

  final _i12.User user;

  final List<_i12.Album> albums;

  @override
  String toString() {
    return 'UserAlbumsRouteArgs{key: $key, user: $user, albums: $albums}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserAlbumsRouteArgs) return false;
    return key == other.key &&
        user == other.user &&
        const _i11.ListEquality<_i12.Album>().equals(albums, other.albums);
  }

  @override
  int get hashCode =>
      key.hashCode ^
      user.hashCode ^
      const _i11.ListEquality<_i12.Album>().hash(albums);
}

/// generated route for
/// [_i5.UserPostsScreen]
class UserPostsRoute extends _i8.PageRouteInfo<UserPostsRouteArgs> {
  UserPostsRoute({
    _i9.Key? key,
    required _i12.User user,
    required List<_i12.Post> posts,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         UserPostsRoute.name,
         args: UserPostsRouteArgs(key: key, user: user, posts: posts),
         initialChildren: children,
       );

  static const String name = 'UserPostsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserPostsRouteArgs>();
      return _i5.UserPostsScreen(
        key: args.key,
        user: args.user,
        posts: args.posts,
      );
    },
  );
}

class UserPostsRouteArgs {
  const UserPostsRouteArgs({this.key, required this.user, required this.posts});

  final _i9.Key? key;

  final _i12.User user;

  final List<_i12.Post> posts;

  @override
  String toString() {
    return 'UserPostsRouteArgs{key: $key, user: $user, posts: $posts}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserPostsRouteArgs) return false;
    return key == other.key &&
        user == other.user &&
        const _i11.ListEquality<_i12.Post>().equals(posts, other.posts);
  }

  @override
  int get hashCode =>
      key.hashCode ^
      user.hashCode ^
      const _i11.ListEquality<_i12.Post>().hash(posts);
}

/// generated route for
/// [_i6.UserScreen]
class UserRoute extends _i8.PageRouteInfo<UserRouteArgs> {
  UserRoute({
    _i9.Key? key,
    required _i10.User user,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         UserRoute.name,
         args: UserRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'UserRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserRouteArgs>();
      return _i6.UserScreen(key: args.key, user: args.user);
    },
  );
}

class UserRouteArgs {
  const UserRouteArgs({this.key, required this.user});

  final _i9.Key? key;

  final _i10.User user;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserRouteArgs) return false;
    return key == other.key && user == other.user;
  }

  @override
  int get hashCode => key.hashCode ^ user.hashCode;
}

/// generated route for
/// [_i7.UserTodosScreen]
class UserTodosRoute extends _i8.PageRouteInfo<UserTodosRouteArgs> {
  UserTodosRoute({
    _i9.Key? key,
    required _i12.User user,
    required List<_i12.Todo> todos,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         UserTodosRoute.name,
         args: UserTodosRouteArgs(key: key, user: user, todos: todos),
         initialChildren: children,
       );

  static const String name = 'UserTodosRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserTodosRouteArgs>();
      return _i7.UserTodosScreen(
        key: args.key,
        user: args.user,
        todos: args.todos,
      );
    },
  );
}

class UserTodosRouteArgs {
  const UserTodosRouteArgs({this.key, required this.user, required this.todos});

  final _i9.Key? key;

  final _i12.User user;

  final List<_i12.Todo> todos;

  @override
  String toString() {
    return 'UserTodosRouteArgs{key: $key, user: $user, todos: $todos}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserTodosRouteArgs) return false;
    return key == other.key &&
        user == other.user &&
        const _i11.ListEquality<_i12.Todo>().equals(todos, other.todos);
  }

  @override
  int get hashCode =>
      key.hashCode ^
      user.hashCode ^
      const _i11.ListEquality<_i12.Todo>().hash(todos);
}
