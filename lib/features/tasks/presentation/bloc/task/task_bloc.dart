import 'package:bloc/bloc.dart';
import 'package:daily_done/features/tasks/domain/usecases/get_all_task.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/task.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  TaskBloc({required this.getAllTasksUseCase}) : super(TaskInitial()) {
    on<TaskEvent>((event, emit) async {
      if (event is GetAllTasksEvent) {
        emit(LoadingTasksState());
        final failureOrTasks = await getAllTasksUseCase();
        emit(_mapFailureOrTasksToState(failureOrTasks));
      }
    });
  }
  TaskState _mapFailureOrTasksToState(Either<Failure, List<Tasks>> either) {
    return either.fold(
      (failure) => ErrorTasksState(message: emptyCashFailureMessage),
      (tasks) => LoadedTasksState(
        task: tasks,
      ),
    );
  }
}
