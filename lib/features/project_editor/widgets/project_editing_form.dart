import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_blueprint/features/project_editor/adapter.dart';

class ProjectEditingFormController {
   bool validate() {
     return _formValidateHook();
   }

  late bool Function() _formValidateHook;
  void onBind(bool Function() validateHook) {
    _formValidateHook = validateHook;
  }
}

class ProjectEditingForm extends StatefulWidget {
  const ProjectEditingForm({super.key, required this.controller});
  final ProjectEditingFormController controller;

  @override
  State<ProjectEditingForm> createState() => _ProjectEditingFormState();
}

class _ProjectEditingFormState extends State<ProjectEditingForm> {
  var _formKey = GlobalKey<FormState>();
  FormState? get formState => _formKey.currentState;
  TextEditingController tecName = TextEditingController();

  @override
  void initState() {
    super.initState();
    ProjectEditorAdapter a = context.read();
    debugPrint("$runtimeType initState set project name=${a.selectedProject!.name}");
    tecName.text = a.selectedProject!.name;
    widget.controller.onBind(() {
      final isValid = formState!.validate();
      if (!isValid) {
        return false;
      }
      formState!.save();
      a.selectedProject!.name = tecName.text;
      return true;
    });
  }
  @override
  Widget build(BuildContext context) {
    ProjectEditorAdapter a = context.watch();
    List<Widget> ls = [];
    ls.add(
        TextFormField(
      controller: tecName,
      decoration: InputDecoration(label: Text("Project Name")),
          validator: (value) {
            if (value == null || value.isEmpty || value.trim().isEmpty) {
              return 'Invalid Project Name';
            }
            return null;
          },
          onFieldSubmitted: (value) {
            debugPrint("onFieldSubmitted ProjectEdit.name = ${value}");
            a.selectedProject!.name = value.trim();
          },
      )
    );
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: ls
        ),
      ),
    );
  }
}
