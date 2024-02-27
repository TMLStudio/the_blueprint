enum ProjectProgressStatus { OnGoing, Finished, Pending }

class ProjectEntity {
  final String id;
  final String name;
  final String desc;
  final List<String> tags;
  final ProjectProgressStatus progressStatus;

  ProjectEntity({required this.id, required this.name, required this.desc, required this.tags, required this.progressStatus});

  static ProjectEntity fromJson(Map<String, dynamic> json) {
    ProjectProgressStatus status = ProjectProgressStatus.values.byName(json['progressStatus']);
    return  ProjectEntity(id: json['_id'], name: json['name'], desc: json['desc'], tags: json['tags'].cast<String>(), progressStatus: status);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "desc": this.desc,
      "tags": this.tags,
      "progressStatus": this.progressStatus.name,
    };
  }
}
