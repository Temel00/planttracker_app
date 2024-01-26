import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/services/auth/auth_exceptions.dart';
import 'package:planttracker_app/services/auth/auth_service.dart';
import 'package:planttracker_app/utilities/dialogs/error_dialog.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: emailController,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email here',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password here',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = emailController.value.text;
                      final password = passwordController.value.text;
                      await AuthService.firebase()
                          .logIn(
                        email: email,
                        password: password,
                      )
                          .then(
                        (value) {
                          final user = AuthService.firebase().currentUser;
                          if (user?.isEmailVerified ?? false) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              plantsRoute,
                              (route) => false,
                            );
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyEmailRoute,
                              (route) => false,
                            );
                          }
                        },
                      ).catchError(
                        (_) async {
                          await showErrorDialog(
                            context,
                            'Invalid Email',
                          );
                        },
                        test: (e) => e is InvalidEmailAuthException,
                      ).catchError(
                        (_) async {
                          await showErrorDialog(
                            context,
                            'Invalid Credential',
                          );
                        },
                        test: (e) => e is InvalidCredentialAuthException,
                      ).catchError(
                        (_) async {
                          await showErrorDialog(
                              context, 'Generic Auth Exception');
                        },
                        test: (e) => e is GenericAuthException,
                      );
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute,
                        (route) => false,
                      );
                    },
                    child: const Text('Not registered yet? Register here'),
                  ),
                ],
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
