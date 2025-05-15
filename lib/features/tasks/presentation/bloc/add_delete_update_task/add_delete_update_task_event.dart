part of 'add_delete_update_task_bloc.dart';

@immutable
abstract class AddDeleteUpdateTaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTaskEvent extends AddDeleteUpdateTaskEvent {
  final Tasks tasks;

  AddTaskEvent({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class UpdateTaskEvent extends AddDeleteUpdateTaskEvent {
  final Tasks tasks;

  UpdateTaskEvent({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class DeleteTaskEvent extends AddDeleteUpdateTaskEvent {
  final int taskId;

  DeleteTaskEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
