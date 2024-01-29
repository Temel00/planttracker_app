class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreatePlantException extends CloudStorageException {}

class CouldNotGetAllPlantsException extends CloudStorageException {}

class CouldNotUpdatePlantException extends CloudStorageException {}

class CouldNotDeletePlantException extends CloudStorageException {}
