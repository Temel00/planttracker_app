import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

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
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      )
                          .then(
                        (value) {
                          FirebaseAuth.instance.currentUser
                              ?.sendEmailVerification();
                          Navigator.of(context).pushNamed(verifyEmailRoute);
                        },
                      ).catchError(
                        (error) async {
                          final FirebaseAuthException? e = error;
                          if (e != null) {
                            if (e.code == 'weak-password') {
                              await showErrorDialog(
                                context,
                                "Weak password",
                              );
                            } else if (e.code == 'email-already-in-use') {
                              await showErrorDialog(
                                context,
                                "Email already in use",
                              );
                            } else if (e.code == 'invalid-email') {
                              await showErrorDialog(
                                context,
                                "Invalid email",
                              );
                            } else {
                              await showErrorDialog(
                                context,
                                "Firebase Auth Error ${e.code}",
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
