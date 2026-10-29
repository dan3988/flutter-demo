import 'package:auto_route/annotations.dart';
import 'package:axcend/app/albums_list.dart';
import 'package:axcend/app/posts_list.dart';
import 'package:axcend/ui.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _HomeTab {
  posts(Icons.textsms, 'Posts', _buildPosts),
  todos(Icons.checklist, 'Todos', _buildTodos),
  albums(Icons.photo, 'Albums', _buildAlbums),
  ;

  static Widget _buildTodos(BuildContext _) => const SizedBox.shrink();

  static Widget _buildPosts(BuildContext _) => const PostsListWidget();

  static Widget _buildAlbums(BuildContext _) => const AlbumsListWidget();

  final IconData icon;
  final String title;
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
      appBar: AppBar(
        title: Text('App Title'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      bottomNavigationBar: Theme(
        data: theme.copyWith(
          splashColor: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
          highlightColor: theme.colorScheme.onPrimary.withValues(alpha: 0.1),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentTab,
          backgroundColor: theme.colorScheme.primary,
          selectedItemColor: theme.colorScheme.onPrimary,
          unselectedItemColor: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
          onTap: _setTab,
          items: [
            for (final tab in _HomeTab.values)
              BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.title,
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
