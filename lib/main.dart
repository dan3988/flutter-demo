import 'package:axcend/api/client.dart';
import 'package:axcend/app_router.dart';
import 'package:axcend/environment.dart';
import 'package:axcend/l10n/text.dart';
import 'package:axcend/ui.dart';
import 'package:axcend/util.dart';

const filesDirName = 'app';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.onRecord.listen((record) => debugPrint(record.toConsoleString()));

  final api = PlaceholderApi(
    baseUrl: Uri.parse(Environment.apiUrl),
    logger: getLogger(PlaceholderApi),
    //simulateSlowConnection: kDebugMode,
  );

  runApp(
    MultiProvider(
      providers: [Provider.value(value: api)],
      child: MyApp(),
    ),
  );
}

const seedColor = Colors.deepPurple;

class MyApp extends StatelessWidget {
  final router = AppRouter();

  static ThemeData _theme(BuildContext context, Brightness brightness) {
    return ThemeData(
      colorScheme: .fromSeed(
        seedColor: Colors.deepPurple,
        brightness: brightness,
      ),
    );
  }

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Axcend Demo',
      theme: _theme(context, .light),
      themeMode: .system,
      darkTheme: _theme(context, .dark),
      routerConfig: router.config(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) {
        return Loader(child: child!);
      },
    );
  }
}
