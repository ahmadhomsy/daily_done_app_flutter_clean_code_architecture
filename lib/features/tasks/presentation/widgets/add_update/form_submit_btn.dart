import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdateTask;

  const FormSubmitBtn({
    super.key,
    required this.onPressed,
    required this.isUpdateTask,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdateTask ? const Icon(Icons.edit) : const Icon(Icons.add),
        label: Text(isUpdateTask ? "تعديل" : "اضافة"));
  }
}
