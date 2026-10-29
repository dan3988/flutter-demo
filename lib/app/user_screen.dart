import 'package:auto_route/annotations.dart';
import 'package:axcend/api/client.dart';
import 'package:axcend/app/post_tile.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/ui/hyperlink.dart';
import 'package:axcend/util.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final _log = getLogger(UserScreen);

@RoutePage()
class UserScreen extends StatelessWidget {
  final User user;

  const UserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Screen(
      title: Localized(text: AppText.pageTitleUser),
      safeArea: .pad(AppStyle.paddingMedAll),
      body: DefaultTextStyle(
        style: theme.textTheme.bodyLarge!,
        child: Column(
          spacing: AppStyle.paddingMed,
          children: [
            Text(user.username, style: theme.textTheme.titleLarge),
            _UserField(
              start: const Icon(Icons.perm_identity),
              end: Text(user.name),
            ),
            _UserField(
              start: const Icon(Icons.email),
              end: Hyperlink(
                text: user.email,
                onTap: () => _openLink('mailto:${user.email}'),
              ),
            ),
            _UserField(start: const Icon(Icons.phone), end: Text(user.phone)),
            _UserField(
              start: const Icon(Icons.public),
              end: Hyperlink(
                text: user.website,
                onTap: () => _openLink('https://${user.website}'),
              ),
            ),
            _UserField(
              start: const Icon(Icons.work),
              end: Column(
                spacing: AppStyle.paddingMed,
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
          ],
        ),
      ),
    );
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
  final List<Widget> children;

  _UserField({required Widget start, required Widget end})
    : children = [start, end];

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppStyle.paddingMed,
      mainAxisSize: .max,
      children: children,
    );
  }
}
