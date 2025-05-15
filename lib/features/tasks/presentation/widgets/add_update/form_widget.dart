import 'package:daily_done/features/tasks/presentation/bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import 'package:daily_done/features/tasks/presentation/widgets/add_update/text_form_field_history.dart';
import 'package:daily_done/features/tasks/presentation/widgets/add_update/text_form_field_widget.dart';

import '../../../domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_submit_btn.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdateTask;
  final Tasks? task;
  const FormWidget({super.key, required this.isUpdateTask, this.task});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateTask) {
      _titleController.text = widget.task!.task;
      _bodyController.text = widget.task!.description;
      _dateTimeController.text = widget.task!.dateTime.toIso8601String();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "العنوان",
                multiLines: false,
                controller: _titleController),
            TextFormFieldWidget(
                name: "الوصف", multiLines: true, controller: _bodyController),
            TextFormFieldHistory(
              controller: _dateTimeController,
            ),
            FormSubmitBtn(
                isUpdateTask: widget.isUpdateTask,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final task = Tasks(
        id: widget.isUpdateTask ? widget.task!.id : null,
        task: _titleController.text,
        description: _bodyController.text,
        dateTime: DateTime.parse(_dateTimeController.text),
      );

      if (widget.isUpdateTask) {
        BlocProvider.of<AddDeleteUpdateTaskBloc>(context)
            .add(UpdateTaskEvent(tasks: task));
      } else {
        BlocProvider.of<AddDeleteUpdateTaskBloc>(context)
            .add(AddTaskEvent(tasks: task));
      }
    }
  }
}
