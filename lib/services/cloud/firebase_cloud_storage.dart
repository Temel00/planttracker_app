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

  Future<void> updatePlant({
    required String documentId,
    required String text,
  }) async {
    try {
      await plants.doc(documentId).update({textFieldName: text});
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
    });

    final fetchedPlant = await document.get();
    return CloudPlant(
      documentId: fetchedPlant.id,
      ownerUserId: ownerUserId,
      text: '',
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
