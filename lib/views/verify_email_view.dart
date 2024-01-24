import 'package:flutter/material.dart';
import 'package:planttracker_app/constants/routes.dart';

import 'package:planttracker_app/services/auth/auth_service.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body: Column(
        children: [
          const Text(
              "We've send you an email verification. Please open it to verify your account"),
          const Text(
              "If you haven't recieved a verification email yet, press the button below"),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send Email Verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut().then(
                    (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute, (route) => false),
                  );
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
