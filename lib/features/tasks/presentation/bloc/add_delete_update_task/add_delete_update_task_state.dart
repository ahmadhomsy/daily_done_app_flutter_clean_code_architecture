part of 'add_delete_update_task_bloc.dart';

@immutable
abstract class AddDeleteUpdateTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AddDeleteUpdateTaskInitial extends AddDeleteUpdateTaskState {}

class LoadingAddDeleteUpdateTaskState extends AddDeleteUpdateTaskState {}

class ErrorAddDeleteUpdateTaskState extends AddDeleteUpdateTaskState {
  final String message;

  ErrorAddDeleteUpdateTaskState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdateTaskState extends AddDeleteUpdateTaskState {
  final String message;

  MessageAddDeleteUpdateTaskState({required this.message});

  @override
  List<Object> get props => [message];
}
