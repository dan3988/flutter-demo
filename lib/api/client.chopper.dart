// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'client.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AlbumService extends AlbumService {
  _$AlbumService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AlbumService;

  @override
  Future<Response<List<Album>>> _get(int id, Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/albums/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Album>, Album>($request);
  }

  @override
  Future<Response<List<Album>>> _getAll(Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/albums');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Album>, Album>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CommentService extends CommentService {
  _$CommentService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CommentService;

  @override
  Future<Response<List<Comment>>> _get(int id, Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/comments/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Comment>, Comment>($request);
  }

  @override
  Future<Response<List<Comment>>> _getAll(Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/comments');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Comment>, Comment>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PostService extends PostService {
  _$PostService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PostService;

  @override
  Future<Response<Post>> _get(int id, Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/posts/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<Post, Post>($request);
  }

  @override
  Future<Response<List<Post>>> _getAll(Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/posts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Post>, Post>($request);
  }

  @override
  Future<Response<List<Comment>>> _getComments(
    int id,
    Future<void>? abortTrigger,
  ) {
    final Uri $url = Uri.parse('/posts/${id}/comments');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Comment>, Comment>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PhotoService extends PhotoService {
  _$PhotoService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PhotoService;

  @override
  Future<Response<List<Photo>>> _get(int id, Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/photos/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Photo>, Photo>($request);
  }

  @override
  Future<Response<List<Photo>>> _getAll(Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/photos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Photo>, Photo>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$UserService extends UserService {
  _$UserService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = UserService;

  @override
  Future<Response<User>> _get(int id, Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/users/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<List<User>>> _getAll(Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<User>, User>($request);
  }

  @override
  Future<Response<List<Comment>>> _getComments(
    int id,
    Future<void>? abortTrigger,
  ) {
    final Uri $url = Uri.parse('/users/${id}/comments');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Comment>, Comment>($request);
  }

  @override
  Future<Response<List<Post>>> _getPosts(int id, Future<void>? abortTrigger) {
    final Uri $url = Uri.parse('/users/users/{userId}/posts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      abortTrigger: abortTrigger,
    );
    return client.send<List<Post>, Post>($request);
  }
}
