import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

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
              final user = FirebaseAuth.instance.currentUser;
              devtools.log(user.toString());
              await user?.sendEmailVerification();
            },
            child: const Text('Send Email Verification'),
          )
        ],
      ),
    );
  }
}
