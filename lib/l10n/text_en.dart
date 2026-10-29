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
}
