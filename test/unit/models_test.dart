import 'package:axcend/api/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JSON Model Serialization', () {
    test('Post fromJson and toJson', () {
      final json = {
        'userId': 1,
        'id': 101,
        'title': 'Test Post Title',
        'body': 'Test post body content.',
      };

      final post = Post.fromJson(json);

      expect(post.userId, 1);
      expect(post.id, 101);
      expect(post.title, 'Test Post Title');
      expect(post.body, 'Test post body content.');

      expect(post.toJson(), json);
    });

    test('User, Address, and Company fromJson', () {
      final json = {
        'id': 1,
        'name': 'Leanne Graham',
        'username': 'Bret',
        'email': 'Sincere@april.biz',
        'address': {
          'street': 'Kulas Light',
          'suite': 'Apt. 556',
          'city': 'Gwenborough',
          'zipcode': '92998-3874',
          'geo': {'lat': '-37.3159', 'lng': '81.1496'},
        },
        'phone': '1-770-736-8031 x56442',
        'website': 'hildegard.org',
        'company': {
          'name': 'Romaguera-Crona',
          'catchPhrase': 'Multi-layered client-server neural-net',
          'bs': 'harness real-time e-markets',
        },
      };

      final user = User.fromJson(json);

      expect(user.id, 1);
      expect(user.name, 'Leanne Graham');
      expect(user.username, 'Bret');
      expect(user.email, 'Sincere@april.biz');
      expect(user.address.street, 'Kulas Light');
      expect(user.address.suite, 'Apt. 556');
      expect(user.address.city, 'Gwenborough');
      expect(user.address.zipcode, '92998-3874');
      expect(user.address.geo.lat, '-37.3159');
      expect(user.address.geo.lng, '81.1496');
      expect(user.company.name, 'Romaguera-Crona');
      expect(user.company.catchPhrase, 'Multi-layered client-server neural-net');
      expect(user.company.bs, 'harness real-time e-markets');
    });

    test('Album fromJson and toJson', () {
      final json = {
        'userId': 1,
        'id': 10,
        'title': 'quidem molestiae enim',
      };

      final album = Album.fromJson(json);

      expect(album.userId, 1);
      expect(album.id, 10);
      expect(album.title, 'quidem molestiae enim');

      expect(album.toJson(), json);
    });

    test('Comment fromJson and toJson', () {
      final json = {
        'postId': 1,
        'id': 2,
        'name': 'id labore ex et quam laborum',
        'email': 'Jayne_Kuhic@sydney.com',
        'body': 'laudantium enim quasi est quidem magnam voluptate ipsam eos',
      };

      final comment = Comment.fromJson(json);

      expect(comment.postId, 1);
      expect(comment.id, 2);
      expect(comment.email, 'Jayne_Kuhic@sydney.com');
      expect(comment.body, 'laudantium enim quasi est quidem magnam voluptate ipsam eos');

      expect(comment.toJson(), json);
    });

    test('Photo fromJson and toJson', () {
      final json = {
        'albumId': 1,
        'id': 1,
        'title': 'accusamus ea aliquid et et officiis vestra',
        'url': 'https://via.placeholder.com/600/92c952',
        'thumbnailUrl': 'https://via.placeholder.com/150/92c952',
      };

      final photo = Photo.fromJson(json);

      expect(photo.albumId, 1);
      expect(photo.id, 1);
      expect(photo.title, 'accusamus ea aliquid et et officiis vestra');
      expect(photo.url, 'https://via.placeholder.com/600/92c952');

      expect(photo.toJson(), json);
    });

    test('Todo fromJson and toJson', () {
      final json = {
        'userId': 1,
        'id': 1,
        'title': 'delectus aut autem',
        'completed': false,
      };

      final todo = Todo.fromJson(json);

      expect(todo.userId, 1);
      expect(todo.id, 1);
      expect(todo.title, 'delectus aut autem');
      expect(todo.completed, false);

      expect(todo.toJson(), json);
    });
  });
}
