import 'package:the_blueprint/app/services/storage_service.dart';

class StorageServiceInMemory with StorageServiceInterface {
  Map<String,Map<String, dynamic>> _docMap = {};

  @override
  Future saveDocumentAsync(Map<String, dynamic> document) async {
    Future.delayed(Duration(seconds: 1));
    _docMap[document['_id']] = document;
  }

}