import 'package:exkartikulation/src/features/login/loginView.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: "/login",
    routes: [
      // ShellRoute(
      //   builder: (context, state, child) => Scaffold(body: child),
      //   routes: [
      //     // Example
      //     // GoRoute(
      //     //   path: "login",
      //     //   name: "login",
      //     //   builder: (context, state) => const LoginView(),
      //     // ),
      //   ],
      // ),
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
