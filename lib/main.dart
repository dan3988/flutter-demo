import 'package:flutter_demo/api/client.dart';
import 'package:flutter_demo/app_router.dart';
import 'package:flutter_demo/environment.dart';
import 'package:flutter_demo/l10n/text.dart';
import 'package:flutter_demo/ui.dart';
import 'package:flutter_demo/util.dart';

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
      title: 'Flutter Demo',
      theme: _theme(context, .light),
      themeMode: .system,
      darkTheme: _theme(context, .dark),
      routerConfig: router.config(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) {
        return Loader(child: child!);
      },
    );
  }
}
