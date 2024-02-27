import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_blueprint/features/project_editor/adapter.dart';
import 'package:the_blueprint/features/project_editor/widgets/project_editing_form.dart';

class ProjectEditorScreen extends StatefulWidget {
  static const String RouteId = "project-editor";
  const ProjectEditorScreen({super.key});

  @override
  State<ProjectEditorScreen> createState() => _ProjectEditorScreenState();
}

class _ProjectEditorScreenState extends State<ProjectEditorScreen> {
  @override
  void initState() {
    super.initState();
    ProjectEditorAdapter pea = context.read();
    debugPrint("$runtimeType init state: selectedProjectId=${pea.selectedProjectId}");
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("$runtimeType build...");
    ProjectEditorAdapter pea = context.watch();
    return Scaffold(
      appBar: AppBar(title: Text(pea.requiredProjectName),
        actions: [
          IconButton(onPressed: (){
            if (formController.validate()) {
              pea.doSave(() {
                Navigator.pop(context);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Form values"), duration: Duration(seconds: 1)));
            }
          }, icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  ProjectEditingFormController formController = ProjectEditingFormController();
  Widget _buildBody() {
    ProjectEditorAdapter pea = context.watch();
    if (pea.selectedProject == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      child: ProjectEditingForm(controller: formController),
    );
  }
}
