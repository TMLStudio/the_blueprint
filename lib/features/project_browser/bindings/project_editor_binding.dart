import 'package:flutter/cupertino.dart';
import 'package:the_blueprint/app/blueprint/adapter_interface.dart';
import 'package:the_blueprint/features/project_browser/project_browser_feature.dart';
import 'package:the_blueprint/features/project_editor/adapter.dart';
import 'package:the_blueprint/shared/models/project_selection_change_dto.dart';
import 'package:the_blueprint/shared/models/project_updated_dto.dart';

class BindingProjectEditorToProjectBrowser with PortStreamListener {
  final ProjectBrowserFeature feature;
  BindingProjectEditorToProjectBrowser({required this.feature});
  @override
  onReceiveData(PortStreamEvent event) {
    debugPrint("BindingProjectEditorToProjectBrowser: onReceiveData ${event.portId}");
    if (event.portId == ProjectEditorAdapter.PORT_SAVE_DOCUMENT_RESULT) {
      feature.adapter.loadProjects();
    }
  }

}