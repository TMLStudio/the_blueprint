import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_blueprint/domain/models/project_browser_model.dart';
import 'package:the_blueprint/features/project_browser/adapter.dart';
import 'package:the_blueprint/features/project_editor/adapter.dart';
import 'package:the_blueprint/features/project_editor/screens/project_editor_screen.dart';

class ProjectBrowserScreen extends StatefulWidget {
  static const String RouteId = "project-browser";
  const ProjectBrowserScreen({super.key});

  @override
  State<ProjectBrowserScreen> createState() => _ProjectBrowserScreenState();
}

class _ProjectBrowserScreenState extends State<ProjectBrowserScreen> {

  @override
  void initState() {
    super.initState();
    ProjectBrowserAdapter pba = context.read();
    pba.loadProjects();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Project Browser")),
      body: SafeArea(child: buildBody()),
    );
  }

  Widget buildBody() {
    ProjectBrowserAdapter pba = context.watch();
    List<Widget> ls = [];
    for(int i = 0; i < pba.filteredProjects.length; i++) {
      ProjectBrowserModel p = pba.filteredProjects[i];
      ls.add(ListTile(
        onTap: () {
          pba.selectProjectAt(i);
          Navigator.pushNamed(context, ProjectEditorScreen.RouteId);
        },
        title: Text(p.name),
        subtitle: Text(p.desc),
      ));
    }
    return ListView(
      children: ls
    );
  }
}
