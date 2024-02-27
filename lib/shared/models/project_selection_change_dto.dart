import 'package:the_blueprint/domain/models/project_browser_model.dart';

class ProjectSelectionChangeDto {
  final List<int> selectedIndices;
  final List<ProjectBrowserModel> selectedProjects;

  ProjectSelectionChangeDto({required this.selectedIndices, required this.selectedProjects});
}