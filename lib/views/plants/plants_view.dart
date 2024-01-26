import 'package:flutter/material.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/enums/menu_action.dart';

import 'package:planttracker_app/services/auth/auth_service.dart';
import 'package:planttracker_app/services/crud/plants_service.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({super.key});

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {
  late final PlantsService _plantsService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _plantsService = PlantsService();
    _plantsService.open();
    super.initState();
  }

  @override
  void dispose() {
    _plantsService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Plants"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(newPlantRoute);
                },
                icon: const Icon(Icons.add)),
            MenuAnchor(
              menuChildren: <Widget>[
                MenuItemButton(
                  child: Text(MenuEntry.show.label),
                  onPressed: () async {
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      AuthService.firebase().logOut().then(
                            (_) =>
                                Navigator.of(context).pushNamedAndRemoveUntil(
                              loginRoute,
                              (_) => false,
                            ),
                          );
                    }
                  },
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
        body: FutureBuilder(
          future: _plantsService.getOrCreateUser(email: userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                  stream: _plantsService.allNotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Text('Waiting for all notes...');
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                );
              default:
                return const CircularProgressIndicator();
            }
          },
        ));
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
