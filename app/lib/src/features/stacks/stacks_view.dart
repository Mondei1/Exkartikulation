import 'package:exkartikulation/src/features/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StacksView extends StatefulWidget {
  const StacksView({super.key});

  @override
  State<StacksView> createState() => _StacksViewState();
}

class _StacksViewState extends State<StacksView> {
  final LoginService loginService = LoginServiceFactory.client();

  void logout() {
    loginService.logout();

    context.go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: logout, child: Text("Logout"));
  }
}
