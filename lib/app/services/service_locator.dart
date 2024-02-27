import 'package:the_blueprint/app/services/storage_service_in_memory.dart';

class ServiceLocator {
  StorageServiceInMemory get storageServiceInMemory => StorageServiceInMemory();
}

final serviceLocator = ServiceLocator();