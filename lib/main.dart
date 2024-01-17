import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:planttracker_app/auth/secrets.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}

class PlantItem {
  final String commonName;
  final String scientificName;
  final String watering;

  PlantItem({
    required this.commonName,
    required this.scientificName,
    required this.watering,
  });
}

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = useState<List<PlantItem>>([]);
    final loading = useState<bool>(false);
    final error = useState<Object?>(null);
    final page = useState<int>(1);

    Future<void> fetchData() async {
      try {
        loading.value = true;
        final dio = Dio();
        final response = await dio.get(
            'https://perenual.com/api/species-list?key=$plantKey&indoor=1&page=${page.value}');

        devtools.log(response.data['data'].toString());

        final parsedItems = response.data['data'] as List<dynamic>;

        final itemsList = parsedItems.map((item) {
          return PlantItem(
            commonName: item['common_name'].toString(),
            scientificName: item['scientific_name'].toString(),
            watering: item['watering'].toString(),
          );
        }).toList();

        items.value = itemsList;
      } catch (e) {
        error.value = e;
      } finally {
        loading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home Title')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: fetchData,
            child: const Text('Fetch Data'),
          ),
          if (loading.value)
            const Center(child: CircularProgressIndicator())
          else if (error.value != null)
            Center(child: Text('Error: ${error.toString()}'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: items.value.length,
                itemBuilder: (context, index) {
                  final plantItem = items.value[index];
                  return ListTile(
                    title: Text(plantItem.commonName),
                    subtitle: Text(plantItem.scientificName),
                    leading:
                        Text(plantItem.watering), // Assuming a 'title' property
                  );
                },
              ),
            ),
          ElevatedButton(
              onPressed: () {
                if (page.value > 1) {
                  page.value--;
                  fetchData();
                }
              },
              child: const Text('Get Last Page')),
          ElevatedButton(
              onPressed: () {
                page.value++;
                fetchData();
              },
              child: const Text('Get Next Page')),
        ],
      ),
    );
  }
}

// 'https://perenual.com/api/species-list?key=$plantKey&indoor=1'