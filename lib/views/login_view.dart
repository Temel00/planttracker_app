import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/services/auth/auth_exceptions.dart';
import 'package:planttracker_app/services/auth/auth_service.dart';
import 'package:planttracker_app/services/auth/bloc/auth_bloc.dart';
import 'package:planttracker_app/services/auth/bloc/auth_event.dart';
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
                      try {
                        context
                            .read<AuthBloc>()
                            .add(AuthEventLogIn(email, password));
                      } on InvalidEmailAuthException {
                        await showErrorDialog(
                          context,
                          'Invalid Email',
                        );
                      } on InvalidCredentialAuthException {
                        await showErrorDialog(
                          context,
                          'Invalid Credential',
                        );
                      } on GenericAuthException {
                        await showErrorDialog(
                            context, 'Generic Auth Exception');
                      }
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
