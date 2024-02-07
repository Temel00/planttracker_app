import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planttracker_app/services/cloud/cloud_plant.dart';
import 'package:planttracker_app/services/cloud/cloud_storage_constants.dart';
import 'package:planttracker_app/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final plants = FirebaseFirestore.instance.collection('plants');

  Future<void> deletePlant({required String documentId}) async {
    try {
      await plants.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeletePlantException();
    }
  }

  Future<void> updatePlantText({
    required String documentId,
    required String text,
  }) async {
    try {
      await plants.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdatePlantException();
    }
  }

  Future<void> updateWaterCount({
    required String documentId,
    required int timesWatered,
  }) async {
    try {
      await plants
          .doc(documentId)
          .update({timesWateredFieldName: (timesWatered + 1)});
    } catch (e) {
      throw CouldNotUpdatePlantException();
    }
  }

  Stream<Iterable<CloudPlant>> allPlants(
          {required String ownerUserId}) =>
      plants
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .snapshots()
          .map(
              (event) => event.docs.map((doc) => CloudPlant.fromSnapshot(doc)));

  Future<CloudPlant> createNewPlant({required String ownerUserId}) async {
    final document = await plants.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
      timesWateredFieldName: 0,
    });

    final fetchedPlant = await document.get();
    return CloudPlant(
      documentId: fetchedPlant.id,
      ownerUserId: ownerUserId,
      text: '',
      timesWatered: 0,
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
