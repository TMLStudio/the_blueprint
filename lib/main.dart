import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_blueprint/app/blueprint/feature_interface.dart';
import 'package:the_blueprint/app/blueprint/feature_manager.dart';
import 'package:the_blueprint/app/repositories/project_repository_in_memory.dart';
import 'package:the_blueprint/app/services/service_locator.dart';
import 'package:the_blueprint/features/project_browser/adapter.dart';
import 'package:the_blueprint/features/project_browser/project_browser_feature.dart';
import 'package:the_blueprint/features/project_browser/screens/project_browser_screen.dart';
import 'package:the_blueprint/features/project_editor/adapter.dart';
import 'package:the_blueprint/features/project_editor/project_editor_feature.dart';
import 'package:the_blueprint/features/project_editor/screens/project_editor_screen.dart';

void main() {
  ProjectEditorAdapter pea = ProjectEditorAdapter();
  ProjectEditorFeature pef = ProjectEditorFeature(
      editorAdapter: pea,
      projectRepository: ProjectRepositoryInMemory(),
      storageService: serviceLocator.storageServiceInMemory
  );
  pea.onBind(pef);
  ProjectBrowserAdapter pba = ProjectBrowserAdapter();
  ProjectBrowserFeature pbf = ProjectBrowserFeature(
      browserAdapter: pba, projectRepository: ProjectRepositoryInMemory());
  pba.onBind(pbf);
  pef.featureBindings.add(FeatureBindingManifest(featureId: pbf.featureId, portBindings: [BlueprintPortBinding(portId: ProjectBrowserAdapter.PORT_PROJECT_SELECTION_CHANGED)]));
  pbf.featureBindings.add(FeatureBindingManifest(featureId: pef.featureId, portBindings: [BlueprintPortBinding(portId: ProjectEditorAdapter.PORT_SAVE_DOCUMENT_RESULT)]));
  blueprintFeatureMgr.setup([pef, pbf]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => pea),
    ChangeNotifierProvider(create: (_) => pba),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: ProjectBrowserScreen.RouteId,
      routes: {
        ProjectBrowserScreen.RouteId: (context) => const ProjectBrowserScreen(),
        ProjectEditorScreen.RouteId: (context) => const ProjectEditorScreen(),
      },
    );
  }
}
