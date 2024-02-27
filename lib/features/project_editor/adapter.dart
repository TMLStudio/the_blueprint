import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:the_blueprint/app/blueprint/adapter_interface.dart';
import 'package:the_blueprint/features/project_editor/models/project_editing_model.dart';
import 'package:the_blueprint/features/project_editor/project_editor_feature.dart';
import 'package:the_blueprint/shared/models/project_updated_dto.dart';


class ProjectEditorAdapter extends ChangeNotifier with BlueprintAdapter {
  late ProjectEditorFeature feature;

  static const String PORT_SAVE_DOCUMENT_RESULT = 'save.document.result';
  ProjectEditorAdapter();

  String? _selectedProjectId = null;
  String? get selectedProjectId => _selectedProjectId;
  ProjectEditingModel? _selectedProject;
  ProjectEditingModel? get selectedProject => _selectedProject;

  String get requiredProjectName {
    if (selectedProject != null) return selectedProject!.name;
    if (selectedProjectId != null) return selectedProjectId!;
    return "...";
  }

  onBind(ProjectEditorFeature feature) {
    this.feature = feature;
  }

  doSave(VoidCallback onDone) {
    debugPrint("$runtimeType doSave");
    if (selectedProjectId == null) {
      feature.projectRepository!.addNewProjectAsync(selectedProject!.toJson())
          .then((result) {
        broadcast(PORT_SAVE_DOCUMENT_RESULT, ProjectUpdatedDto(projectId: result!));
        notifyListeners();
        onDone();
      });
    }
    else {
      debugPrint(jsonEncode(selectedProject!.toJson()));
      feature.projectRepository!.updateProjectAsync(selectedProject!.toJson())
          .then((result) {
        broadcast(PORT_SAVE_DOCUMENT_RESULT, ProjectUpdatedDto(projectId: selectedProjectId!));
        notifyListeners();
        onDone();
      });
    }
  }

  selectProjectById(String id) {
    debugPrint("[$runtimeType] selectProjectById $id");
    _selectedProjectId = id;
    _selectedProject = null;
    feature.projectRepository.loadProjectByIdAsync(id)
    .then((p) {
      _selectedProject = ProjectEditingModel.fromEntity(p!);
      notifyListeners();
    });
  }
}