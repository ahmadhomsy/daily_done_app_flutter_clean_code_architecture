part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TaskInitial extends TaskState {}

class LoadingTasksState extends TaskState {}

class LoadedTasksState extends TaskState {
  final List<Tasks> task;

  LoadedTasksState({required this.task});

  @override
  List<Object> get props => [task];
}

class ErrorTasksState extends TaskState {
  final String message;

  ErrorTasksState({required this.message});

  @override
  List<Object> get props => [message];
}
