import 'package:exkartikulation/src/core/appRouter.dart';
import 'package:flutter/material.dart';

import 'src/core/appWidget.dart';

void main() {
  final router = createRouter();

  runApp(MaterialApp(home: const MyApp()));
}
