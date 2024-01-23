import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:planttracker_app/utilities/show_error_dialog.dart';

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
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
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
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then(
                        (value) {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user?.emailVerified ?? false) {
                            // user's email is verified
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              dashboardRoute,
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
                        (error) async {
                          final FirebaseAuthException? e = error;
                          if (e != null) {
                            if (e.code == 'invalid-email') {
                              await showErrorDialog(
                                context,
                                "User not found",
                              );
                            } else if (e.code == 'invalid-credential') {
                              await showErrorDialog(
                                context,
                                "Invalid credentials",
                              );
                            } else {
                              await showErrorDialog(
                                context,
                                'Error: ${e.code}',
                              );
                            }
                          } else {
                            await showErrorDialog(
                              context,
                              "Unknown error",
                            );
                          }
                        },
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
