part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllTasksEvent extends TaskEvent {}
