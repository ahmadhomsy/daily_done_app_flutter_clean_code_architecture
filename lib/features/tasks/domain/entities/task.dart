import 'package:equatable/equatable.dart';

class Tasks extends Equatable {
  final String task;
  final String description;
  final DateTime dateTime;
  final bool isComplete;
  final int? id;

  const Tasks({
    this.id,
    this.isComplete = false,
    required this.task,
    required this.description,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [task, dateTime, description, isComplete];
}
