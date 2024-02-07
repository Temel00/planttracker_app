import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planttracker_app/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudPlant {
  final String documentId;
  final String ownerUserId;
  final String text;
  final int timesWatered;

  const CloudPlant({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
    required this.timesWatered,
  });

  CloudPlant.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String,
        timesWatered = snapshot.data()[timesWateredFieldName] as int;
}
