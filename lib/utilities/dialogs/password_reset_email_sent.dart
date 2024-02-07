import 'package:flutter/material.dart';
import 'package:planttracker_app/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content:
        'We have now sent a password reset link. Please check your inbox for more info.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
