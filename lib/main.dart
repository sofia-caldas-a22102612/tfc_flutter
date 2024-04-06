import 'package:flutter/material.dart';
import 'package:tfc_flutter/pages/main.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        appBarTheme: ThemeData.from(colorScheme: colorScheme).appBarTheme.copyWith(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.background,
        )
      ),
      home: MainPage(),
    );
  }
}


