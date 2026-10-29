// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'text.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String postComments({required int count}) {
    return 'Comments ($count)';
  }

  @override
  String get appErrorGeneric => 'An unexpected error occurred.';

  @override
  String get pageTitleAlbum => 'Album';

  @override
  String get pageTitleAlbums => 'Albums';

  @override
  String get pageTitlePost => 'Post';

  @override
  String get pageTitlePosts => 'Posts';

  @override
  String get pageTitleTodos => 'Todos';

  @override
  String get pageTitleUser => 'User';

  @override
  String get pageTitleUsers => 'Users';

  @override
  String moreItems({required int count}) {
    return '+$count more';
  }

  @override
  String get usersViewAlbums => 'View Albums';

  @override
  String get usersViewPosts => 'View Posts';

  @override
  String pageTitleUserPosts({required String name}) {
    return 'Posts by $name';
  }

  @override
  String pageTitleUserTodos({required String name}) {
    return 'Todos by $name';
  }

  @override
  String pageTitleUserAlbums({required String name}) {
    return 'Albums by $name';
  }

  @override
  String get usersViewTodos => 'View Todos';
}
