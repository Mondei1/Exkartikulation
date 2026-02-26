import 'package:exkartikulation/src/core/appRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();

    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      restorationScopeId: 'exkartikulator_app_id',

      supportedLocales: const [Locale("de", '')],

      onGenerateTitle: (BuildContext context) => "Exkatikulator",

      routerConfig: router,
    );
  }
}
