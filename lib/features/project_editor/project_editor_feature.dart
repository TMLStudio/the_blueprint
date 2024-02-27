import 'package:the_blueprint/app/blueprint/adapter_interface.dart';
import 'package:the_blueprint/app/blueprint/feature_interface.dart';
import 'package:the_blueprint/domain/repositories/projects.dart';
import 'package:the_blueprint/features/project_browser/project_browser_feature.dart';
import 'package:the_blueprint/features/project_editor/adapter.dart';
import 'package:the_blueprint/features/project_editor/bindings/project_browser_binding.dart';

class ProjectEditorFeature extends FeatureInterface<ProjectEditorAdapter> {
  final ProjectEditorAdapter editorAdapter;
  final ProjectRepositoryInterface projectRepository;
  ProjectEditorFeature({required this.editorAdapter, required this.projectRepository, super.storageService}) {
  }

  @override
  ProjectEditorAdapter get adapter => editorAdapter;

  static const String PROJECT_EDITOR = 'PROJECT_EDITOR';
  @override
  String get featureId => PROJECT_EDITOR;

  List<FeatureBindingManifest> _featureBindings = [];
  @override
  List<FeatureBindingManifest> get featureBindings => _featureBindings;

  @override
  PortStreamListener? createBinding(String featureId) {
    if (featureId == ProjectBrowserFeature.PROJECT_BROWSER) return BindingProjectBrowserToProjectEditor(feature: this);
    return null;
  }



}