import 'package:flutter/material.dart';
import 'package:market_list/pages/home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF3584E4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF3584E4),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // home: HomePage(),
      home: HomePage(),
    );
  }
}
