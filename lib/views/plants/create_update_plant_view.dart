import 'package:flutter/material.dart';
import 'package:planttracker_app/services/auth/auth_service.dart';
import 'package:planttracker_app/utilities/dialogs/cannot_share_empty_plant_dialog.dart';
import 'package:planttracker_app/utilities/generics/get_arguments.dart';
import 'package:planttracker_app/services/cloud/cloud_plant.dart';
import 'package:planttracker_app/services/cloud/firebase_cloud_storage.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdatePlantView extends StatefulWidget {
  const CreateUpdatePlantView({super.key});

  @override
  State<CreateUpdatePlantView> createState() => _CreateUpdatePlantViewState();
}

class _CreateUpdatePlantViewState extends State<CreateUpdatePlantView> {
  CloudPlant? _plant;
  late final FirebaseCloudStorage _plantsService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _plantsService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final plant = _plant;
    if (plant == null) {
      return;
    }
    final text = _textController.text;
    await _plantsService.updatePlant(
      documentId: plant.documentId,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudPlant> createOrGetExistingPlant(BuildContext context) async {
    final widgetPlant = context.getArgument<CloudPlant>();

    if (widgetPlant != null) {
      _plant = widgetPlant;
      _textController.text = widgetPlant.text;
      return widgetPlant;
    }

    final existingPlant = _plant;
    if (existingPlant != null) {
      return existingPlant;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newPlant = await _plantsService.createNewPlant(ownerUserId: userId);
    _plant = newPlant;
    return newPlant;
  }

  void _deletePlantIfTextIsEmpty() {
    final plant = _plant;
    if (_textController.text.isEmpty && plant != null) {
      _plantsService.deletePlant(documentId: plant.documentId);
    }
  }

  void _savePlantIfTextNotEmpty() async {
    final plant = _plant;
    final text = _textController.text;
    if (text.isNotEmpty && plant != null) {
      await _plantsService.updatePlant(
        documentId: plant.documentId,
        text: text,
      );
    }
  }

  @override
  void dispose() {
    _deletePlantIfTextIsEmpty();
    _savePlantIfTextNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Plant'),
          actions: [
            IconButton(
              onPressed: () async {
                final text = _textController.text;
                if (_plant != null || text.isEmpty) {
                  await showCannotShareEmptyPlantDialog(context);
                } else {
                  Share.share(text);
                }
              },
              icon: const Icon(Icons.share),
            )
          ],
        ),
        body: FutureBuilder(
          future: createOrGetExistingPlant(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _setupTextControllerListener();
                return TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Start typing your plant details'),
                );
              default:
                return const CircularProgressIndicator();
            }
          },
        ));
  }
}
