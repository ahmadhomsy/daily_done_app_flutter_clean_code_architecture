import 'package:daily_done/features/tasks/presentation/pages/add_update_task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../domain/entities/task.dart';
import '../../bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import '../../bloc/task/task_bloc.dart';

class TaskWidget extends StatelessWidget {
  final List<Tasks> tasks;

  const TaskWidget({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          child: ListTile(
            leading: Checkbox(
              value: task.isComplete,
              onChanged: (val) async {
                if (val != null) {
                  context.read<AddDeleteUpdateTaskBloc>().add(
                        UpdateTaskEvent(
                          tasks: Tasks(
                            id: task.id,
                            task: task.task,
                            description: task.description,
                            dateTime: task.dateTime,
                            isComplete: val,
                          ),
                        ),
                      );
                }
                context.read<TaskBloc>().add(GetAllTasksEvent());
              },
            ),
            title: Text(
              task.task,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: task.isComplete ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.description),
                SizedBox(height: 4.h),
                Text(
                  task.dateTime.toString(),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Get.to(() => AddUpdateTaskPage(
                          isUpdateTask: true,
                          task: task,
                        ));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context
                        .read<AddDeleteUpdateTaskBloc>()
                        .add(DeleteTaskEvent(taskId: task.id!));
                    context.read<TaskBloc>().add(GetAllTasksEvent());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
