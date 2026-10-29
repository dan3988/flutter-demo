part of 'client.dart';

@ChopperApi(baseUrl: '/albums')
abstract class AlbumService extends ChopperService {
  @override
  Type get definitionType => AlbumService;

  Result<List<Album>> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Album.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<List<Album>> _get(
    @path int id,
    @abortTrigger Future<void>? abortTrigger,
  );

  Result<List<Album>> getAll({Future<void>? abortTrigger}) {
    _addFactory(Album.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<Album>> _getAll(@abortTrigger Future<void>? abortTrigger);
}

@ChopperApi(baseUrl: '/comments')
abstract class CommentService extends ChopperService {
  @override
  Type get definitionType => CommentService;

  Result<List<Comment>> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Comment.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<List<Comment>> _get(
    @path int id,
    @abortTrigger Future<void>? abortTrigger,
  );

  Result<List<Comment>> getAll({Future<void>? abortTrigger}) {
    _addFactory(Comment.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<Comment>> _getAll(@abortTrigger Future<void>? abortTrigger);
}

@ChopperApi(baseUrl: '/posts')
abstract class PostService extends ChopperService {
  @override
  Type get definitionType => PostService;

  Result<Post> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Post.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<Post> _get(
    @path int id,
    @abortTrigger Future<void>? abortTrigger,
  );

  Result<List<Post>> getAll({Future<void>? abortTrigger}) {
    _addFactory(Post.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<Post>> _getAll(@abortTrigger Future<void>? abortTrigger);

  Result<List<Comment>> getComments(int id, {Future<void>? abortTrigger}) {
    _addFactory(Comment.fromJson);

    return _getComments(id, abortTrigger);
  }

  @GET(path: '/{id}/comments')
  Result<List<Comment>> _getComments(
    @path int id,
    @abortTrigger Future<void>? abortTrigger,
  );
}

@ChopperApi(baseUrl: '/photos')
abstract class PhotoService extends ChopperService {
  Result<List<Photo>> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Photo.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<List<Photo>> _get(
    @path int id,
    @abortTrigger Future<void>? abortTrigger,
  );

  Result<List<Photo>> getAll(Future<void>? abortTrigger) {
    _addFactory(Photo.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<Photo>> _getAll(@abortTrigger Future<void>? abortTrigger);
}

@ChopperApi(baseUrl: '/users')
abstract class UserService extends ChopperService {
  @override
  Type get definitionType => UserService;

  Result<User> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(User.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<User> _get(@path int id, @abortTrigger Future<void>? abortTrigger);

  Result<List<User>> getAll({Future<void>? abortTrigger}) {
    _addFactory(User.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<User>> _getAll(@abortTrigger Future<void>? abortTrigger);

  Result<List<Comment>> getComments(int id, {Future<void>? abortTrigger}) {
    _addFactory(Comment.fromJson);

    return _getComments(id, abortTrigger);
  }

  @GET(path: '/{id}/comments')
  Result<List<Comment>> _getComments(
    @path int id,
    @abortTrigger Future<void>? abortTrigger,
  );

  Result<List<Post>> getPosts(int id, {Future<void>? abortTrigger}) {
    _addFactory(Post.fromJson);

    return _getPosts(id, abortTrigger);
  }

  @GET(path: '/users/{userId}/posts')
  Result<List<Post>> _getPosts(
    @path int id,
    @abortTrigger Future<void>? abortTrigger,
  );
}
