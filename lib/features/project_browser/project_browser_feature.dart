import 'package:the_blueprint/app/blueprint/adapter_interface.dart';
import 'package:the_blueprint/app/blueprint/feature_interface.dart';
import 'package:the_blueprint/domain/repositories/projects.dart';
import 'package:the_blueprint/features/project_browser/adapter.dart';
import 'package:the_blueprint/features/project_browser/bindings/project_editor_binding.dart';
import 'package:the_blueprint/features/project_editor/project_editor_feature.dart';

class ProjectBrowserFeature extends FeatureInterface<ProjectBrowserAdapter> {
  final ProjectRepositoryInterface projectRepository;
  final ProjectBrowserAdapter browserAdapter;

  ProjectBrowserFeature({required this.browserAdapter, required this.projectRepository});


  @override
  ProjectBrowserAdapter get adapter => browserAdapter;

  static const String PROJECT_BROWSER = 'PROJECT_BROWSER';
  @override
  String get featureId => PROJECT_BROWSER;

  List<FeatureBindingManifest> _featureBindings = [];
  @override
  List<FeatureBindingManifest> get featureBindings => _featureBindings;

  // @override
  // PortStreamListener? createBinding(String featureId) {
  //   if (featureId == ProjectEditorFeature.PROJECT_EDITOR) return BindingProjectEditorToProjectBrowser(feature: this);
  //   return null;
  // }
}