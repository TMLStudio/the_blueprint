import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'adapter_interface.dart';


mixin PortStreamListener {
  onReceiveData(PortStreamEvent event);
}

class PortStreamEvent {
  final String portId;
  final dynamic data;
  PortStreamEvent({required this.portId, this.data});
}

class PortStream {
  //
  // used for the blueprint itself
  //
  StreamController<PortStreamEvent> inController = StreamController.broadcast();
  //
  // used for the external blueprints
  //
  StreamController<PortStreamEvent> outController = StreamController.broadcast();
  List<BlueprintAdapter> _listeners = [];

  final BlueprintAdapter adapter;
  PortStream({required this.adapter}) {
    outController.stream.listen((data) {
      debugPrint("[${adapter.runtimeType}] outStream event: portId=${data.portId} data=${data.data}");
      for(var lis in _listeners) {
        lis.onReceiveData(data);
      }
    });

  }

  sendFromOutside(PortStreamEvent event) {
    debugPrint("[${adapter.runtimeType}] sendFromOutside event.portId=${event.portId}");
    inController.sink.add(event);
  }
  sendFromInside(PortStreamEvent event) {
    debugPrint("[${adapter.runtimeType}] sendFromInside event.portId=${event.portId}");
    outController.sink.add(event);
  }

  void register(BlueprintAdapter listener) {
    if (!_listeners.contains(listener)) {
      debugPrint("[${adapter.runtimeType}] portStream add listener [${listener.runtimeType}]");
      _listeners.add(listener);
    }
  }
}

mixin BlueprintAdapter<TFeature> {
  late final PortStream _portStream = PortStream(adapter: this);
  late TFeature feature;
  onBind(TFeature feature) {
    this.feature = feature;
  }

  broadcast(String portId, dynamic data) {
    debugPrint("$runtimeType: broadcast portId=$portId data=$data");
    _portStream.sendFromInside(PortStreamEvent(portId: portId, data: data));
  }

  register(BlueprintAdapter listener) {
    debugPrint("$runtimeType: portStream add listener ${listener.runtimeType}");
    _portStream.register(listener);
  }

  onReceiveData(PortStreamEvent event);

}
