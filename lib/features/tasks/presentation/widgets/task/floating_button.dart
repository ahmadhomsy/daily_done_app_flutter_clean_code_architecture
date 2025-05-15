import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/add_update_task_page.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => const AddUpdateTaskPage(
              isUpdateTask: false,
            ));
      },
      backgroundColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.add, size: 28, color: Colors.white),
    );
  }
}
