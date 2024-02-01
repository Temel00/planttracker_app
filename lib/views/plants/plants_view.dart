import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planttracker_app/constants/routes.dart';
import 'package:planttracker_app/enums/menu_action.dart';

import 'package:planttracker_app/services/auth/auth_service.dart';
import 'package:planttracker_app/services/auth/bloc/auth_bloc.dart';
import 'package:planttracker_app/services/auth/bloc/auth_event.dart';
import 'package:planttracker_app/services/cloud/cloud_plant.dart';
import 'package:planttracker_app/services/cloud/firebase_cloud_storage.dart';
import 'package:planttracker_app/utilities/dialogs/logout_dialog.dart';
import 'package:planttracker_app/views/plants/plants_list_view.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({super.key});
  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {
  late final FirebaseCloudStorage _plantsService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _plantsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plants"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(createUpdatePlantRoute);
              },
              icon: const Icon(Icons.add)),
          MenuAnchor(
            menuChildren: <Widget>[
              MenuItemButton(
                child: Text(MenuEntry.show.label),
                onPressed: () async {
                  await showLogOutDialog(context).then((value) {
                    if (value) {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    }
                  });
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
      body: StreamBuilder(
        stream: _plantsService.allPlants(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allPlants = snapshot.data as Iterable<CloudPlant>;
                return PlantsListView(
                  plants: allPlants,
                  onDeletePlant: (plant) async {
                    await _plantsService.deletePlant(
                        documentId: plant.documentId);
                  },
                  onTapped: (plant) {
                    Navigator.of(context).pushNamed(
                      createUpdatePlantRoute,
                      arguments: plant,
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
