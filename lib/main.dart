import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/firebase_options.dart';
import 'package:planttracker_app/views/dashboard_view.dart';
import 'package:planttracker_app/views/login_view.dart';
import 'package:planttracker_app/views/register_view.dart';
import 'package:planttracker_app/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      dashboardRoute: (context) => const DashboardView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

enum MenuEntry {
  about('About'),
  show('Menu 2'),
  place('Menu 3');

  const MenuEntry(this.label);
  final String label;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                    await FirebaseAuth.instance.signOut().then(
                      (value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (_) => false,
                        );
                      },
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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const DashboardView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
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

// TODO: Separate App Initialization from Login logic
// TODO: Create MyPlants page to store user's plants
// TODO: Add a custom_name to PlantItem
// TODO: Protect main UI from unathenticated Users
