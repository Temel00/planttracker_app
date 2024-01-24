import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/services/auth/auth_exceptions.dart';
import 'package:planttracker_app/services/auth/auth_service.dart';
import 'package:planttracker_app/utilities/show_error_dialog.dart';

class RegisterView extends HookWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                          .createUser(
                        email: email,
                        password: password,
                      )
                          .then(
                        (_) async {
                          await AuthService.firebase().sendEmailVerification();
                          if (context.mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                verifyEmailRoute, (route) => false);
                          }
                        },
                      ).catchError(
                        (_) async {
                          await showErrorDialog(
                            context,
                            'Weak password',
                          );
                        },
                        test: (e) => e is WeakPasswordAuthException,
                      ).catchError(
                        (_) async {
                          await showErrorDialog(
                            context,
                            'Email already in use',
                          );
                        },
                        test: (e) => e is EmailAlreadyInUseAuthException,
                      ).catchError(
                        (_) async {
                          await showErrorDialog(
                            context,
                            'Invalid email',
                          );
                        },
                        test: (e) => e is InvalidEmailAuthException,
                      ).catchError(
                        (_) async {
                          await showErrorDialog(
                              context, 'Generic Auth Exception');
                        },
                        test: (e) => e is GenericAuthException,
                      );
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    },
                    child: const Text('Already registered? Login here'),
                  )
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
