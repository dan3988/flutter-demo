import 'package:flutter_demo/app/albums_list.dart';
import 'package:flutter_demo/app/posts_list.dart';
import 'package:flutter_demo/app/users_list.dart';
import 'package:flutter_demo/ui.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _HomeTab {
  users(Icons.person, AppText.pageTitleUsers, _buildUsers),
  posts(Icons.textsms, AppText.pageTitlePosts, _buildPosts),
  albums(Icons.photo, AppText.pageTitleAlbums, _buildAlbums),
  ;

  static Widget _buildUsers(BuildContext _) => const UsersListWidget();

  static Widget _buildPosts(BuildContext _) => const PostsListWidget();

  static Widget _buildAlbums(BuildContext _) => const AlbumsListWidget();

  final IconData icon;
  final Message title;
  final WidgetBuilder builder;

  const _HomeTab(this.icon, this.title, this.builder);
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    final currentTab = _HomeTab.values[_currentTab];
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      appBar: AppBar(
        title: Localized(text: currentTab.title),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      bottomNavigationBar: Theme(
        data: theme.copyWith(
          splashColor: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
          highlightColor: theme.colorScheme.onPrimary.withValues(alpha: 0.1),
        ),
        child: BottomNavigationBar(
          type: .fixed,
          currentIndex: _currentTab,
          backgroundColor: theme.colorScheme.primary,
          selectedItemColor: theme.colorScheme.onPrimary,
          unselectedItemColor: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
          onTap: _setTab,
          items: [
            for (final tab in _HomeTab.values)
              BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.title.resolve(context),
              ),
          ],
        ),
      ),
      body: currentTab.builder(context),
    );
  }

  void _setTab(int index) {
    if (_currentTab != index) {
      setState(() => _currentTab = index);
    }
  }
}
