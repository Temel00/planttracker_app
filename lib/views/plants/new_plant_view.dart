import 'package:flutter/material.dart';

class NewPlantView extends StatelessWidget {
  const NewPlantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Plant'),
      ),
      body: const Text('Write your new note here...'),
    );
  }
}
