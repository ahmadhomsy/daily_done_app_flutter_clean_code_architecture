import 'package:flutter/material.dart';

class TextFormFieldHistory extends StatelessWidget {
  final TextEditingController controller;

  const TextFormFieldHistory({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'التاريخ والوقت'),
      validator: (val) => val!.isEmpty ? "الرجاء ادخال الوقت" : null,
      readOnly: true,
      onTap: () async {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: today,
          firstDate: today,
          lastDate: today,
        );

        if (!context.mounted) return;

        if (pickedDate != null) {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (!context.mounted) return;

          if (pickedTime != null) {
            final fullDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            controller.text = fullDateTime.toIso8601String();
          }
        }
      },
    );
  }
}
