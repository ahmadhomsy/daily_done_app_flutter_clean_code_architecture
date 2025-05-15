import 'package:bloc/bloc.dart';
import 'package:daily_done/features/tasks/domain/entities/task.dart';
import 'package:daily_done/features/tasks/domain/usecases/delete_task.dart';
import 'package:daily_done/features/tasks/domain/usecases/update_task.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/usecases/add_task.dart';

part 'add_delete_update_task_event.dart';
part 'add_delete_update_task_state.dart';

class AddDeleteUpdateTaskBloc
    extends Bloc<AddDeleteUpdateTaskEvent, AddDeleteUpdateTaskState> {
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  AddDeleteUpdateTaskBloc({
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(AddDeleteUpdateTaskInitial()) {
    on<AddDeleteUpdateTaskEvent>((event, emit) async {
      if (event is AddTaskEvent) {
        emit(LoadingAddDeleteUpdateTaskState());

        final failureOrDoneMessage = await addTaskUseCase(event.tasks);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, addSuccessMessage),
        );
      } else if (event is UpdateTaskEvent) {
        emit(LoadingAddDeleteUpdateTaskState());

        final failureOrDoneMessage = await updateTaskUseCase(event.tasks);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, updateSuccessMessage),
        );
      } else if (event is DeleteTaskEvent) {
        emit(LoadingAddDeleteUpdateTaskState());

        final failureOrDoneMessage = await deleteTaskUseCase(event.taskId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, deleteSuccessMessage),
        );
      }
    });
  }

  AddDeleteUpdateTaskState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateTaskState(
        message: unexpectedError,
      ),
      (_) => MessageAddDeleteUpdateTaskState(message: message),
    );
  }
}
