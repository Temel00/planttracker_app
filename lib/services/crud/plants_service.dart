import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planttracker_app/extensions/list/filter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:planttracker_app/services/crud/crud_exceptions.dart';

class PlantsService {
  Database? _db;

  List<DatabasePlant> _plants = [];

  DatabaseUser? _user;

  static final PlantsService _shared = PlantsService._sharedInstance();
  PlantsService._sharedInstance() {
    _plantsStreamController = StreamController<List<DatabasePlant>>.broadcast(
      onListen: () {
        _plantsStreamController.sink.add(_plants);
      },
    );
  }
  factory PlantsService() => _shared;

  late final StreamController<List<DatabasePlant>> _plantsStreamController;

  Stream<List<DatabasePlant>> get allPlants =>
      _plantsStreamController.stream.filter((plant) {
        final currentUser = _user;
        if (currentUser != null) {
          return plant.userId == currentUser.id;
        } else {
          throw UserNotSetBeforeReadingAllPlantsException();
        }
      });

  Future<DatabaseUser> getOrCreateUser({
    required String email,
    bool setAsCurrentUser = true,
  }) async {
    try {
      final user = await getUser(email: email);
      if (setAsCurrentUser) {
        _user = user;
      }
      return user;
    } on UserNotFoundException {
      final createdUser = await createUser(email: email);
      if (setAsCurrentUser) {
        _user = createdUser;
      }
      return createdUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _cacheNotes() async {
    final allPlants = await getAllPlants();
    _plants = allPlants.toList();
    _plantsStreamController.add(_plants);
  }

  Future<DatabasePlant> updatePlant({
    required DatabasePlant plant,
    required String text,
  }) async {
    final db = _getDatabaseOrThrow();

    // make sure plant exists
    await getPlant(id: plant.id);

    // update db
    final updatesCount = await db.update(
      plantTable,
      {
        textColumn: text,
        isSyncedWithCloudColumn: 0,
      },
      where: 'id = ?',
      whereArgs: [plant.id],
    );

    if (updatesCount == 0) {
      throw CouldNotUpdatePlantException();
    } else {
      final updatedPlant = await getPlant(id: plant.id);
      _plants.removeWhere((plant) => plant.id == updatedPlant.id);
      _plants.add(updatedPlant);
      _plantsStreamController.add(_plants);
      return updatedPlant;
    }
  }

  Future<Iterable<DatabasePlant>> getAllPlants() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final plants = await db.query(plantTable);

    return plants.map((plantRow) => DatabasePlant.fromRow(plantRow));
  }

  Future<DatabasePlant> getPlant({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final plants = await db.query(
      plantTable,
      limit: 1,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (plants.isEmpty) {
      throw PlantNotFoundException();
    } else {
      final plant = DatabasePlant.fromRow(plants.first);
      _plants.removeWhere((plant) => plant.id == id);
      _plants.add(plant);
      _plantsStreamController.add(_plants);
      return plant;
    }
  }

  Future<int> deleteAllPlants() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final numberOfDeletions = await db.delete(plantTable);
    _plants = [];
    _plantsStreamController.add(_plants);
    return numberOfDeletions;
  }

  Future<void> deletePlant({required int id}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      plantTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deletedCount != 1) {
      throw CouldNotDeletePlantException();
    } else {
      _plants.removeWhere((plant) => plant.id == id);
      _plantsStreamController.add(_plants);
    }
  }

  Future<DatabasePlant> createPlant({required DatabaseUser owner}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    // make suer owner exists in database with correct id
    final dbUser = await getUser(email: owner.email);
    if (dbUser != owner) {
      throw UserNotFoundException();
    }

    const text = '';
    // create the plant
    final plantId = await db.insert(plantTable, {
      userIdColumn: owner.id,
      textColumn: text,
      isSyncedWithCloudColumn: 1,
    });

    final plant = DatabasePlant(
      id: plantId,
      userId: owner.id,
      text: text,
      isSyncedWithCloud: true,
    );

    _plants.add(plant);
    _plantsStreamController.add(_plants);

    return plant;
  }

  Future<DatabaseUser> getUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (results.isEmpty) {
      throw UserNotFoundException();
    } else {
      return DatabaseUser.fromRow(results.first);
    }
  }

  Future<DatabaseUser> createUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw UserAlreadyExistsException();
    }

    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),
    });

    return DatabaseUser(
      id: userId,
      email: email,
    );
  }

  Future<void> deleteUser({required String email}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deletedCount != 1) {
      throw CouldNotDeleteUserException();
    }
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      return db;
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenException();
    } else {
      await db.close();
      _db = null;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpenException {
      // empty
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

      // create user table
      await db.execute(createUserTable);
      // create plant table
      await db.execute(createPlantTable);
      await _cacheNotes();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectoryException();
    }
  }
}

@immutable
class DatabaseUser {
  final int id;
  final String email;

  const DatabaseUser({
    required this.id,
    required this.email,
  });

  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  @override
  String toString() => 'Person, ID = $id, email = $email';

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DatabasePlant {
  final int id;
  final int userId;
  final String text;
  final bool isSyncedWithCloud;

  const DatabasePlant({
    required this.id,
    required this.userId,
    required this.text,
    required this.isSyncedWithCloud,
  });

  DatabasePlant.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        text = map[textColumn] as String,
        isSyncedWithCloud =
            (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;

  @override
  String toString() =>
      'Plant: id = $id, userId = $userId, isSyncedWithCloud = $isSyncedWithCloud, text = $text';

  @override
  bool operator ==(covariant DatabasePlant other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const dbName = 'plants.db';
const plantTable = 'plant';
const userTable = 'user';
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn = 'text';
const isSyncedWithCloudColumn = 'is_synced_with_cloud';
//Create user table
const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
  "id"	INTEGER NOT NULL,
  "email"	TEXT NOT NULL UNIQUE,
  PRIMARY KEY("id")
);''';

// Create plant table
const createPlantTable = '''CREATE TABLE IF NOT EXISTS "plant" (
  "id"	INTEGER NOT NULL,
  "user_id"	INTEGER,
  "text"	TEXT,
  "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY("user_id") REFERENCES "user"("id"),
  PRIMARY KEY("id" AUTOINCREMENT)
);''';
