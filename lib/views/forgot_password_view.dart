import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:planttracker_app/services/auth/bloc/auth_bloc.dart';
import 'package:planttracker_app/services/auth/bloc/auth_event.dart';
import 'package:planttracker_app/services/auth/bloc/auth_state.dart';
import 'package:planttracker_app/utilities/dialogs/error_dialog.dart';
import 'package:planttracker_app/utilities/dialogs/password_reset_email_sent.dart';

class ForgotPasswordView extends HookWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            emailController.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null && context.mounted) {
            await showErrorDialog(
              context,
              'We could not reset your password, please ensure you are a user with that email.',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const Text(
                'If you forgot your password, simply enter your email and we will send you a password reset link.'),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: 'Your email address...'),
            ),
            TextButton(
              onPressed: () {
                final email = emailController.text;
                context
                    .read<AuthBloc>()
                    .add(AuthEventForgotPassword(email: email));
              },
              child: const Text('Send password reset link'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
              child: const Text('Back to login page'),
            ),
          ]),
        ),
      ),
    );
  }
}
