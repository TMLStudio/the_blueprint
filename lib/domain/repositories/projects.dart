import 'package:the_blueprint/domain/entities/project.dart';

class ProjectFilterQuery {
  final ProjectProgressStatus? progressStatus;
  ProjectFilterQuery({this.progressStatus});
}

mixin ProjectRepositoryInterface {
  Future<ProjectEntity?> loadProjectByIdAsync(String id);
  Future<List<ProjectEntity>> filterAsync(ProjectFilterQuery query);

  Future<String> addNewProjectAsync(Map<String, dynamic> json);
  Future updateProjectAsync(Map<String, dynamic> json);
}