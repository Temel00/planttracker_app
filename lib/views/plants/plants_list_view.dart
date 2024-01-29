import 'package:flutter/material.dart';
import 'package:planttracker_app/services/cloud/cloud_plant.dart';
import 'package:planttracker_app/utilities/dialogs/delete_dialog.dart';

typedef PlantCallback = void Function(CloudPlant plant);

class PlantsListView extends StatelessWidget {
  final Iterable<CloudPlant> plants;
  final PlantCallback onDeletePlant;
  final PlantCallback onTapped;
  const PlantsListView({
    super.key,
    required this.plants,
    required this.onDeletePlant,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants.elementAt(index);
        return ListTile(
          onTap: () => onTapped(plant),
          title: Text(
            plant.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeletePlant(plant);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
