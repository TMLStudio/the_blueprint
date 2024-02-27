import 'package:flutter/cupertino.dart';
import 'package:the_blueprint/app/blueprint/adapter_interface.dart';
import 'package:the_blueprint/features/project_browser/adapter.dart';
import 'package:the_blueprint/features/project_editor/project_editor_feature.dart';
import 'package:the_blueprint/shared/models/project_selection_change_dto.dart';

class BindingProjectBrowserToProjectEditor with PortStreamListener {
  final ProjectEditorFeature feature;
  BindingProjectBrowserToProjectEditor({required this.feature});
  @override
  onReceiveData(PortStreamEvent event) {
    debugPrint("BindingProjectBrowserToProjectEditor: onReceiveData ${event.portId}");
    if (event.portId == ProjectBrowserAdapter.PORT_PROJECT_SELECTION_CHANGED) {
      ProjectSelectionChangeDto dto = event.data;
      if (dto.selectedIndices.length == 1) {
        feature.adapter.selectProjectById(dto.selectedProjects[0].id);
      }
    }
  }

}