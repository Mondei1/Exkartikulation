import 'package:exkartikulation/src/features/login/login_view.dart';
import 'package:exkartikulation/src/features/stacks/stacks_view.dart';
import 'package:exkartikulation/src/features/topbar/topbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: "/login",
    routes: [
      ShellRoute(
        builder: (context, state, child) => TopBarScaffold(body: child),
        routes: [
          // Example
          GoRoute(
            path: "/stacks",
            name: "stacks",
            builder: (context, state) => StacksView(),
          ),
        ],
      ),
      // Without scaffold
      ShellRoute(
        builder: (context, state, child) => Scaffold(body: child),
        routes: [
          GoRoute(
            path: "/login",
            name: "login",
            builder: (context, state) => LoginView(),
          ),
        ],
      ),
    ],
  );
}
