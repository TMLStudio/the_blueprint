import 'package:flutter/foundation.dart';
import 'package:the_blueprint/app/blueprint/adapter_interface.dart';
import 'feature_interface.dart';

class BlueprintFeatureManager {
  Map<String, FeatureInterface> featureMap = {};
  T? getFeatureById<T extends FeatureInterface>(String id) {
    if (featureMap.containsKey(id)) {
      return featureMap[id] as T;
    }
    return null;
  }

  void setup(List<FeatureInterface> features) {
    debugPrint("FeatureManager: setup...");
    for(var f in features) {
      featureMap[f.featureId] = f;
    }
    debugPrint("  connect adapters and listeners for features...");
    for(var f in features) {
      if (f.featureBindings.isEmpty) {
        debugPrint("${f.featureId} do not have any binding");
        continue;
      }

      for (var featureBinding in f.featureBindings) {
        var targetFeature = featureMap[featureBinding.featureId];
        if (targetFeature == null) {
          debugPrint("===================== ERROR =======================");
          debugPrint("Can not binding to feature [${featureBinding
              .featureId}]: feature not found");
        }
        else {
          // PortStreamListener? lis =f.createBinding(targetFeature.featureId);
          // if (lis != null) {
          //   debugPrint("[Feature ${f.runtimeType}] create binding [${lis.runtimeType}] for events from ${targetFeature.featureId}");
          //   targetFeature.adapter.register(lis);
          // }
          targetFeature.adapter.register(f.adapter);
        }
      }
    }
  }
}

final blueprintFeatureMgr = BlueprintFeatureManager();