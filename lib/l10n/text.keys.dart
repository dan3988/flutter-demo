// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// LocalizationResolverGenerator
// **************************************************************************

// ignore_for_file: prefer_relative_imports, require_trailing_commas

import 'package:localized_text_widget/localized_text_widget.dart';
import 'package:axcend/l10n/text.dart' as l;

sealed class AppText extends LocalizationMessage<l.AppLocalizations> {
  const AppText();

  /// No description provided for @postComments.
  ///
  /// In en, this message translates to:
  /// **'Comments ({count})'**
  const factory AppText.postComments({required int count}) = _C8;

  /// No description provided for @moreItems.
  ///
  /// In en, this message translates to:
  /// **'+{count} more'**
  const factory AppText.moreItems({required int count}) = _C9;

  /// No description provided for @appErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  static const AppText appErrorGeneric = _C0();

  /// No description provided for @pageTitleAlbum.
  ///
  /// In en, this message translates to:
  /// **'Album'**
  static const AppText pageTitleAlbum = _C1();

  /// No description provided for @pageTitleAlbums.
  ///
  /// In en, this message translates to:
  /// **'Albums'**
  static const AppText pageTitleAlbums = _C2();

  /// No description provided for @pageTitlePost.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  static const AppText pageTitlePost = _C3();

  /// No description provided for @pageTitlePosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  static const AppText pageTitlePosts = _C4();

  /// No description provided for @pageTitleTodos.
  ///
  /// In en, this message translates to:
  /// **'Todos'**
  static const AppText pageTitleTodos = _C5();

  /// No description provided for @pageTitleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  static const AppText pageTitleUser = _C6();

  /// No description provided for @pageTitleUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  static const AppText pageTitleUsers = _C7();
}

final class _C0 extends AppText {
  const _C0();

  @override
  getText(c, l) => l.appErrorGeneric;

  @override
  toString() => 'AppText.appErrorGeneric';
}

final class _C1 extends AppText {
  const _C1();

  @override
  getText(c, l) => l.pageTitleAlbum;

  @override
  toString() => 'AppText.pageTitleAlbum';
}

final class _C2 extends AppText {
  const _C2();

  @override
  getText(c, l) => l.pageTitleAlbums;

  @override
  toString() => 'AppText.pageTitleAlbums';
}

final class _C3 extends AppText {
  const _C3();

  @override
  getText(c, l) => l.pageTitlePost;

  @override
  toString() => 'AppText.pageTitlePost';
}

final class _C4 extends AppText {
  const _C4();

  @override
  getText(c, l) => l.pageTitlePosts;

  @override
  toString() => 'AppText.pageTitlePosts';
}

final class _C5 extends AppText {
  const _C5();

  @override
  getText(c, l) => l.pageTitleTodos;

  @override
  toString() => 'AppText.pageTitleTodos';
}

final class _C6 extends AppText {
  const _C6();

  @override
  getText(c, l) => l.pageTitleUser;

  @override
  toString() => 'AppText.pageTitleUser';
}

final class _C7 extends AppText {
  const _C7();

  @override
  getText(c, l) => l.pageTitleUsers;

  @override
  toString() => 'AppText.pageTitleUsers';
}

final class _C8 extends AppText {
  const _C8({required this.count});

  final int count;

  @override
  getText(c, l) => l.postComments(count: count);

  @override
  toString() => 'AppText.postComments';
}

final class _C9 extends AppText {
  const _C9({required this.count});

  final int count;

  @override
  getText(c, l) => l.moreItems(count: count);

  @override
  toString() => 'AppText.moreItems';
}
