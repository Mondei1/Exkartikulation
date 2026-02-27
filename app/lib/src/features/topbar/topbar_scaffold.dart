import 'package:exkartikulation/src/features/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopBarScaffold extends StatefulWidget {
  const TopBarScaffold({super.key, this.body});

  final Widget? body;

  @override
  State<TopBarScaffold> createState() => _TopBarScaffoldState();
}

class _TopBarScaffoldState extends State<TopBarScaffold> {
  final LoginService loginService = LoginServiceFactory.client();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Exkartikulator"),
        actions: [
          PopupMenuButton(
            child: Icon(Icons.account_circle),
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(width: 5),
                        const Text("Logout"),
                      ],
                    ),
                    onTap: () {
                      loginService.logout();
                      context.go("/login");
                    },
                  ),
                ],
          ),
        ],
      ),
      body: widget.body,
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Text(
                "Menü",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: const Text('Lernverlaut'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Einstellungen'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
