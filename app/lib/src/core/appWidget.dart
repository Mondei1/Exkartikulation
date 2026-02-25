import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'exkartikulator_app_id',

      supportedLocales: const [Locale("de", '')],

      onGenerateTitle: (BuildContext context) => "Exkatikulator",

      routerConfig: router,
    );
  }
}
