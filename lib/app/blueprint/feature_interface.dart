
import 'package:flutter/cupertino.dart';
import 'package:the_blueprint/app/blueprint/adapter_interface.dart';
import 'package:the_blueprint/app/services/storage_service.dart';

class BlueprintPortBinding {
  final String portId;
  BlueprintPortBinding({required this.portId});
}
class FeatureBindingManifest {
  final String featureId;
  final List<BlueprintPortBinding> portBindings;
  FeatureBindingManifest({required this.featureId, required this.portBindings});
}

abstract class FeatureInterface<TAdapter extends BlueprintAdapter> {
  TAdapter get adapter;
  String get featureId;
  List<FeatureBindingManifest> get featureBindings;
  // Map<String, PortStreamListener> listeners = {};
  StorageServiceInterface? storageService;

  FeatureInterface({this.storageService});

  // PortStreamListener? getListenerForFeature(String featureId) {
  //   if (listeners.containsKey(featureId)) return listeners[featureId];
  //   return null;
  // }
  //
  // binding(String externalFeatureId, PortStreamListener listener) {
  //   debugPrint("[$runtimeType] bind listener [${listener.runtimeType}] to listen from feature [$externalFeatureId]");
  //   listeners[externalFeatureId] = listener;
  // }

  PortStreamListener? createBinding(String featureId);
}