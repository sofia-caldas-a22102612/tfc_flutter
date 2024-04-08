import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/model/session.dart';
import 'package:tfc_flutter/pages/main.page.dart';
import 'package:tfc_flutter/repository/appatite_repository.dart';
import 'package:tfc_flutter/repository/fake_appatite_repository.dart';
import 'package:tfc_flutter/repository/zeus_repository.dart';

import 'repository/fake_zeus_repository.dart';

Future<void> main() async {
  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.prod");
    debugPrint = (String? message, {int? wrapWidth}) {}; // overrides debugPrint to do nothing
  } else {
    await dotenv.load(fileName: ".env.dev");
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Session()),
      Provider<ZeusRepository>.value(value: FakeZeusRepository()),  // replace by ZeusRepository for real interaction with the API
      Provider<AppatiteRepository>.value(value: FakeAppatiteRepository()),
    ],
    child: const MyApp(),
  ));
}

final Color mainGreenColor = Color.fromRGBO(98, 137, 101, 0.8); // Color value for #628965

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(seedColor: mainGreenColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: colorScheme,
          useMaterial3: true,
          appBarTheme: ThemeData.from(colorScheme: colorScheme).appBarTheme.copyWith(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.background,
              )),
      home: MainPage(),
    );
  }
}
