import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:the_blueprint/domain/entities/project.dart';
import 'package:the_blueprint/domain/repositories/projects.dart';
import 'package:uuid/uuid.dart';

class ProjectRepositoryInMemory with ProjectRepositoryInterface {
  static Map<String, ProjectEntity> _samples = {
    'prj01': ProjectEntity(id: 'prj01',
        name: 'Project 1',
        desc: 'Mock OnGoing Project 1 loaded by filter',
        tags: ['mock'],
        progressStatus: ProjectProgressStatus.OnGoing),
    'prj02': ProjectEntity(id: 'prj02',
        name: 'Project 2',
        desc: 'Mock OnGoing Project 2 loaded by filter',
        tags: ['mock'],
        progressStatus: ProjectProgressStatus.OnGoing),
  };


  @override
  Future<ProjectEntity?> loadProjectByIdAsync(String id) async {
    await Future.delayed(const Duration(seconds: 1));

    return _samples[id];
  }

  @override
  Future<List<ProjectEntity>> filterAsync(ProjectFilterQuery query) async {
    await Future.delayed(const Duration(seconds: 1));
    return _samples.values.where((s) {
      if (query.progressStatus != null) {
        if (s.progressStatus != query.progressStatus!) return false;
      }
      return true;
    }).toList();
  }

  @override
  Future<String> addNewProjectAsync(Map<String, dynamic> json) async {
    Future.delayed(const Duration(seconds: 1));
    json['_id'] = const Uuid().v4().toString();
    ProjectEntity newEntity = ProjectEntity.fromJson(json);;
    _samples[json['_id']] = newEntity;
    return json['_id'];
  }

  @override
  Future updateProjectAsync(Map<String, dynamic> json) async {
    Future.delayed(const Duration(seconds: 1));
    ProjectEntity updatedProjectEntity = ProjectEntity.fromJson(json);
    _samples[json['_id']] = updatedProjectEntity;
    debugPrint("saved project: ${jsonEncode(updatedProjectEntity.toJson())}");
  }

}