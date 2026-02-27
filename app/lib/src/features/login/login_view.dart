import 'package:exkartikulation/src/features/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginService service = LoginServiceFactory.client();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (await service.isAuthorized()) {
        // ignore: use_build_context_synchronously
        context.go("/stacks");
      }
    });
  }

  void login() async {
    setState(() {
      loading = true;
    });

    await service.login(usernameController.text, passwordController.text);

    if (await service.isAuthorized()) {
      // ignore: use_build_context_synchronously
      context.go("/stacks");
    } else {
      usernameController.clear();
      passwordController.clear();
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset("assets/l.svg", width: 200),
            Text(
              "Exkartikulation",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),
            Container(
              constraints: BoxConstraints(maxWidth: 350),
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nutzername"),
                    ),
                    enabled: !loading,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Passwort"),
                    ),
                    enabled: !loading,
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: FilledButton(
                      onPressed: loading ? null : login,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          loading
                              ? SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(),
                              )
                              : Text("Login"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
