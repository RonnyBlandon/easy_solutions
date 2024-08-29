import 'package:easy_solutions/src/features/presentation/StateProviders/error_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/welcome_page/View/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

//Routes
import 'package:easy_solutions/src/routes/routers.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ErrorStateProvider()),
        ChangeNotifierProvider(create: (_) => LoadingStateProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Solutions',
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: 'welcome',
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
