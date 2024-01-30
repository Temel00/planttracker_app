import 'package:flutter/material.dart';
import 'package:planttracker_app/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyPlantDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty note!',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
