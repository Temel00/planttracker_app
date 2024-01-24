import 'package:flutter/material.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/enums/menu_action.dart';
import 'dart:developer' as devtools show log;

import 'package:planttracker_app/services/auth/auth_service.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          MenuAnchor(
            menuChildren: <Widget>[
              MenuItemButton(
                child: Text(MenuEntry.about.label),
                onPressed: () => {devtools.log("Menu About clicked")},
              ),
              MenuItemButton(
                child: Text(MenuEntry.show.label),
                onPressed: () async {
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    AuthService.firebase().logOut().then(
                          (_) => Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute,
                            (_) => false,
                          ),
                        );
                  }
                },
              ),
              MenuItemButton(
                child: Text(MenuEntry.place.label),
                onPressed: () => {devtools.log("Menu Place clicked")},
              ),
            ],
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return TextButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: const Text('Open Menu'),
              );
            },
          )
        ],
      ),
      body: const Center(
          child: Column(
        children: [
          Text("Dashboard Widget"),
        ],
      )),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
