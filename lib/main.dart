import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/error_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/welcome_page/View/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// Routes
import 'package:easy_solutions/src/routes/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ErrorStateProvider()),
        ChangeNotifierProvider(create: (_) => LoadingStateProvider())
      ],
      child: MyAppUserState(),
    );
  }
}

class MyAppUserState extends StatelessWidget with BaseView {
  MyAppUserState({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: coordinator.start(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return MyApp(initialRoute: snapshot.data);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class MyApp extends StatelessWidget {
  final String _initialRoute;
  const MyApp({super.key, required String initialRoute})
      : _initialRoute = initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Solutions',
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: _initialRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(10, 31, 68, 1.0),
          disabledColor: const Color.fromRGBO(142, 142, 247, 1.2),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              iconTheme:
                  IconThemeData(color: Color.fromARGB(255, 235, 225, 225)))),
      home: const WelcomePage(),
    );
  }
}
