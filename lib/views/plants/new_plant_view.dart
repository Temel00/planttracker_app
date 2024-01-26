import 'package:flutter/material.dart';
import 'package:planttracker_app/services/auth/auth_service.dart';
import 'package:planttracker_app/services/crud/plants_service.dart';

class NewPlantView extends StatefulWidget {
  const NewPlantView({super.key});

  @override
  State<NewPlantView> createState() => _NewPlantViewState();
}

class _NewPlantViewState extends State<NewPlantView> {
  DatabasePlant? _plant;
  late final PlantsService _plantsService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _plantsService = PlantsService();
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
      plant: plant,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<DatabasePlant> createNewPlant() async {
    final existingPlant = _plant;
    if (existingPlant != null) {
      return existingPlant;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await _plantsService.getUser(email: email);
    return await _plantsService.createPlant(owner: owner);
  }

  void _deletePlantIfTextIsEmpty() {
    final plant = _plant;
    if (_textController.text.isEmpty && plant != null) {
      _plantsService.deletePlant(id: plant.id);
    }
  }

  void _savePlantIfTextNotEmpty() async {
    final plant = _plant;
    final text = _textController.text;
    if (text.isNotEmpty && plant != null) {
      await _plantsService.updatePlant(
        plant: plant,
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
        ),
        body: FutureBuilder(
          future: createNewPlant(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _plant = snapshot.data as DatabasePlant;
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
