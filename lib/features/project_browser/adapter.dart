import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:the_blueprint/app/blueprint/adapter_interface.dart';
import 'package:the_blueprint/domain/entities/project.dart';
import 'package:the_blueprint/domain/models/project_browser_model.dart';
import 'package:the_blueprint/domain/repositories/projects.dart';
import 'package:the_blueprint/features/project_browser/project_browser_feature.dart';
import 'package:the_blueprint/shared/models/project_selection_change_dto.dart';

class ProjectBrowserAdapter extends ChangeNotifier with BlueprintAdapter {

  List<ProjectBrowserModel> _filteredProjects = [];
  List<ProjectBrowserModel> get filteredProjects => _filteredProjects;

  ProjectBrowserAdapter();

  static const String PORT_PROJECT_SELECTION_CHANGED = 'project.selection.changed';

  ProjectBrowserModel convertProjectEntityToModel(ProjectEntity e) {
    debugPrint("Convert ProjectEntity to Model:");
    debugPrint("${jsonEncode(e.toJson())}");
    return ProjectBrowserModel(id: e.id, name: e.name, desc: e.desc, tags: e.tags);
  }

  selectProjectAt(int index) {
    debugPrint("ProjectBrowserAdapter: selectProjectAt $index");
    broadcast(PORT_PROJECT_SELECTION_CHANGED,
        ProjectSelectionChangeDto(selectedIndices: [index], selectedProjects: [filteredProjects[index]])
        );
    notifyListeners();
  }

  late ProjectBrowserFeature feature;
  onBind(ProjectBrowserFeature feature) {
    this.feature = feature;
  }

  void loadProjects() {
    debugPrint("filter projects...");
    feature.projectRepository.filterAsync(ProjectFilterQuery(progressStatus: ProjectProgressStatus.OnGoing))
        .then((fetchedProjects) {
          _filteredProjects = fetchedProjects.map(convertProjectEntityToModel).toList();
          notifyListeners();
    });
  }
}