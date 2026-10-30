import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_demo/api/client.dart';
import 'package:flutter_demo/ui.dart';
import 'package:flutter_demo/util.dart';

final _log = getLogger(UserScreen);

@RoutePage()
class UserScreen extends StatelessWidget {
  final User user;

  const UserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: AppStyle.borderRadiusMedAll),
      textStyle: theme.textTheme.titleMedium,
      backgroundColor: theme.colorScheme.secondary,
      foregroundColor: theme.colorScheme.onSecondary,
      padding: .zero,
    );

    final hyperlinkTextStyle = theme.textTheme.bodyLarge?.copyWith(
      decoration: .underline,
      color: Colors.blue,
    );

    return Screen(
      title: const Localized(text: AppText.pageTitleUser),
      safeArea: const .pad(AppStyle.paddingMedAll),
      body: DefaultTextStyle(
        style: theme.textTheme.bodyLarge!,
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: AppStyle.paddingMed,
          children: [
            Text(
              user.username,
              style: theme.textTheme.titleLarge,
              textAlign: .center,
            ),
            _UserField(
              icon: const Icon(Icons.perm_identity),
              content: Text(user.name),
            ),
            _UserField(
              icon: const Icon(Icons.email),
              content: Text(user.email, style: hyperlinkTextStyle),
              onTap: () => _openLink('mailto:${user.email}'),
            ),
            _UserField(
              icon: const Icon(Icons.phone),
              content: Text(user.phone),
            ),
            _UserField(
              icon: const Icon(Icons.public),
              content: Text(user.website, style: hyperlinkTextStyle),
              onTap: () => _openLink('https://${user.website}'),
            ),
            _UserField(
              icon: const Icon(Icons.work),
              content: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(user.company.name),
                  Text(
                    '"${user.company.catchPhrase}"',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: .italic,
                    ),
                  ),
                ],
              ),
            ),
            _UserField(
              icon: const Icon(Icons.home),
              content: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(user.address.street),
                  Text(user.address.suite),
                  Text(user.address.city),
                  Text(user.address.zipcode),
                ],
              ),
            ),
            TextButton(
              style: buttonStyle,
              onPressed: () => _openPosts(context),
              child: const Localized(text: AppText.usersViewPosts),
            ),
            TextButton(
              style: buttonStyle,
              onPressed: () => _openAlbums(context),
              child: const Localized(text: AppText.usersViewAlbums),
            ),
            TextButton(
              style: buttonStyle,
              onPressed: () => _openTodos(context),
              child: const Localized(text: AppText.usersViewTodos),
            ),
          ],
        ),
      ),
    );
  }

  void _openPosts(BuildContext context) {
    Loader.doWork(context, () async {
      final api = Provider.of<PlaceholderApi>(context, listen: false);
      final List<Post> posts;

      try {
        posts = await api.users.getPosts(user.id).bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        _log.severe(
          'Failed to load posts for user ${user.id}',
          error,
          stackTrace,
        );

        return;
      }

      if (!context.mounted) {
        return;
      }

      unawaited(context.pushRoute(UserPostsRoute(user: user, posts: posts)));
    });
  }

  void _openAlbums(BuildContext context) {
    Loader.doWork(context, () async {
      final api = Provider.of<PlaceholderApi>(context, listen: false);
      final List<Album> albums;

      try {
        albums = await api.users.getAlbums(user.id).bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        _log.severe(
          'Failed to load posts for user ${user.id}',
          error,
          stackTrace,
        );

        return;
      }

      if (!context.mounted) {
        return;
      }

      unawaited(context.pushRoute(UserAlbumsRoute(user: user, albums: albums)));
    });
  }

  void _openTodos(BuildContext context) {
    Loader.doWork(context, () async {
      final api = Provider.of<PlaceholderApi>(context, listen: false);
      final List<Todo> todos;

      try {
        todos = await api.users.getTodos(user.id).bodyOrThrow();
      } on Exception catch (error, stackTrace) {
        _log.severe(
          'Failed to load posts for user ${user.id}',
          error,
          stackTrace,
        );

        return;
      }

      if (!context.mounted) {
        return;
      }

      unawaited(context.pushRoute(UserTodosRoute(user: user, todos: todos)));
    });
  }

  void _openLink(String link) async {
    try {
      final uri = Uri.parse(link);
      final opened = await launchUrl(uri);
      if (!opened) {
        _log.info('launchUrl returned false for "$link".');
      }
    } on Exception catch (error, stackTrace) {
      _log.severe('Failed to open website "$link".', error, stackTrace);
    }
  }
}

class _UserField extends StatelessWidget {
  final Widget icon;
  final Widget content;
  final VoidCallback? onTap;

  const _UserField({
    required this.icon,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget result = InputDecorator(
      decoration: InputDecoration(
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: AppStyle.borderRadiusMedAll,
          borderSide: BorderSide(color: theme.colorScheme.outline, width: 1),
        ),
      ),
      child: content,
    );

    if (onTap != null) {
      result = Material(
        color: Colors.transparent,
        borderRadius: AppStyle.borderRadiusMedAll,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppStyle.borderRadiusMedAll,
          child: result,
        ),
      );
    }

    return result;
  }
}
