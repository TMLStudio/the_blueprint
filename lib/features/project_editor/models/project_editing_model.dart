import 'package:the_blueprint/domain/entities/project.dart';

class ProjectEditingModel {
  String? id;
  String name;
  String desc;
  List<String> tags;
  ProjectProgressStatus status;

  ProjectEditingModel({this.id, this.name = "", this.desc = "", this.tags = const [], required this.status});

  static ProjectEditingModel fromEntity(ProjectEntity e) {
    return ProjectEditingModel(id: e.id, name: e.name, desc: e.desc, tags: e.tags, status: e.progressStatus);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'desc': desc,
      'tags': tags,
      'progressStatus': status.name
    };
  }
}