part of 'client.dart';

@ChopperApi(baseUrl: '/albums')
abstract class AlbumService extends ChopperService {
  Result<Album> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Album.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<Album> _get(@path int id, @abortTrigger Future<void>? abortTrigger);

  Result<List<Album>> getAll({Future<void>? abortTrigger}) {
    _addFactory(Album.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<Album>> _getAll(@abortTrigger Future<void>? abortTrigger);

  Result<List<Photo>> getPhotos(int id, {Future<void>? abortTrigger}) {
    _addFactory(Photo.fromJson);

    return _getPhotos(id, abortTrigger);
  }

  @GET(path: '/{id}/photos')
  Result<List<Photo>> _getPhotos(
    @path int id,
    @abortTrigger Future<void>? abortTrigger,
  );
}

@ChopperApi(baseUrl: '/comments')
abstract class CommentService extends ChopperService {
  Result<Comment> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Comment.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<Comment> _get(@path int id, @abortTrigger Future<void>? abortTrigger);

  Result<List<Comment>> getAll({Future<void>? abortTrigger}) {
    _addFactory(Comment.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<Comment>> _getAll(@abortTrigger Future<void>? abortTrigger);
}

@ChopperApi(baseUrl: '/todos')
abstract class TodoService extends ChopperService {
  Result<Todo> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Todo.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<Todo> _get(@path int id, @abortTrigger Future<void>? abortTrigger);

  Result<List<Todo>> getAll({Future<void>? abortTrigger}) {
    _addFactory(Todo.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<Todo>> _getAll(@abortTrigger Future<void>? abortTrigger);
}

@ChopperApi(baseUrl: '/photos')
abstract class PhotoService extends ChopperService {
  Result<Photo> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Photo.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<Photo> _get(@path int id, @abortTrigger Future<void>? abortTrigger);

  Result<List<Photo>> getAll(Future<void>? abortTrigger) {
    _addFactory(Photo.fromJson);

    return _getAll(abortTrigger);
  }

  @GET()
  Result<List<Photo>> _getAll(@abortTrigger Future<void>? abortTrigger);
}

@ChopperApi(baseUrl: '/posts')
abstract class PostService extends ChopperService {
  Result<Post> get(int id, {Future<void>? abortTrigger}) {
    _addFactory(Post.fromJson);

    return _get(id, abortTrigger);
  }

  @GET(path: '/{id}')
  Result<Post> _get(@path int id, @abortTrigger Future<void>? abortTrigger);

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

@ChopperApi(baseUrl: '/users')
abstract class UserService extends ChopperService {
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

  Result<List<Album>> getAlbums(int id, {Future<void>? abortTrigger}) {
    _addFactory(Album.fromJson);

    return _getAlbums(id, abortTrigger);
  }

  @GET(path: '/{userId}/albums')
  Result<List<Album>> _getAlbums(
    @path int userId,
    @abortTrigger Future<void>? abortTrigger,
  );

  Result<List<Todo>> getTodos(int id, {Future<void>? abortTrigger}) {
    _addFactory(Todo.fromJson);

    return _getTodos(id, abortTrigger);
  }

  @GET(path: '/{userId}/todos')
  Result<List<Todo>> _getTodos(
    @path int userId,
    @abortTrigger Future<void>? abortTrigger,
  );

  Result<List<Post>> getPosts(int id, {Future<void>? abortTrigger}) {
    _addFactory(Post.fromJson);

    return _getPosts(id, abortTrigger);
  }

  @GET(path: '/{userId}/posts')
  Result<List<Post>> _getPosts(
    @path int userId,
    @abortTrigger Future<void>? abortTrigger,
  );
}
