import 'package:daily_done/features/tasks/domain/entities/task.dart';

class TaskModel extends Tasks {
  const TaskModel({
    super.id,
    super.isComplete,
    required super.task,
    required super.description,
    required super.dateTime,
  });
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      task: map['task'],
      description: map['description'],
      dateTime: DateTime.parse(map['dateTime']),
      isComplete: map['isComplete'] == 1,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isComplete': isComplete ? 1 : 0,
    };
  }
}
