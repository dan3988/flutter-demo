// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:axcend/api/client.dart' as _i8;
import 'package:axcend/app/album_screen.dart' as _i1;
import 'package:axcend/app/home_screen.dart' as _i2;
import 'package:axcend/app/post_screen.dart' as _i3;
import 'package:axcend/app/user_screen.dart' as _i4;
import 'package:axcend/app/users_list.dart' as _i5;
import 'package:axcend/ui.dart' as _i7;
import 'package:collection/collection.dart' as _i9;

/// generated route for
/// [_i1.AlbumScreen]
class AlbumRoute extends _i6.PageRouteInfo<AlbumRouteArgs> {
  AlbumRoute({
    _i7.Key? key,
    required _i8.Album album,
    required List<_i8.Photo> photos,
    required _i8.User user,
    List<_i6.PageRouteInfo>? children,
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

  static _i6.PageInfo page = _i6.PageInfo(
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

  final _i7.Key? key;

  final _i8.Album album;

  final List<_i8.Photo> photos;

  final _i8.User user;

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
        const _i9.ListEquality<_i8.Photo>().equals(photos, other.photos) &&
        user == other.user;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      album.hashCode ^
      const _i9.ListEquality<_i8.Photo>().hash(photos) ^
      user.hashCode;
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.PostScreen]
class PostRoute extends _i6.PageRouteInfo<PostRouteArgs> {
  PostRoute({
    _i7.Key? key,
    required _i8.Post post,
    required _i8.User user,
    required List<_i8.Comment> comments,
    List<_i6.PageRouteInfo>? children,
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

  static _i6.PageInfo page = _i6.PageInfo(
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

  final _i7.Key? key;

  final _i8.Post post;

  final _i8.User user;

  final List<_i8.Comment> comments;

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
        const _i9.ListEquality<_i8.Comment>().equals(comments, other.comments);
  }

  @override
  int get hashCode =>
      key.hashCode ^
      post.hashCode ^
      user.hashCode ^
      const _i9.ListEquality<_i8.Comment>().hash(comments);
}

/// generated route for
/// [_i4.UserScreen]
class UserRoute extends _i6.PageRouteInfo<UserRouteArgs> {
  UserRoute({
    _i7.Key? key,
    required _i8.User user,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         UserRoute.name,
         args: UserRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'UserRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserRouteArgs>();
      return _i4.UserScreen(key: args.key, user: args.user);
    },
  );
}

class UserRouteArgs {
  const UserRouteArgs({this.key, required this.user});

  final _i7.Key? key;

  final _i8.User user;

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
/// [_i5.UsersListWidget]
class UsersListWidget extends _i6.PageRouteInfo<void> {
  const UsersListWidget({List<_i6.PageRouteInfo>? children})
    : super(UsersListWidget.name, initialChildren: children);

  static const String name = 'UsersListWidget';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.UsersListWidget();
    },
  );
}
