import 'package:daily_done/core/error/failure.dart';
import 'package:daily_done/features/tasks/data/models/task_model.dart';
import 'package:daily_done/features/tasks/domain/entities/task.dart';
import 'package:daily_done/features/tasks/domain/repositories/task_repositories.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../data_sources/data.dart';

class TaskRepositoriesImpl implements TaskRepositories {
  final Data data;

  TaskRepositoriesImpl({required this.data});
  @override
  Future<Either<Failure, List<Tasks>>> getAllTasks() async {
    try {
      final tasks = await data.getCashedTasks();
      return Right(tasks);
    } on EmptyCashException {
      return left(EmptyCashFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addTask(Tasks task) async {
    final TaskModel taskModel = TaskModel(
      task: task.task,
      description: task.description,
      dateTime: task.dateTime,
    );
    await data.addTask(taskModel);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> updateTask(Tasks task) async {
    final TaskModel taskModel = TaskModel(
        task: task.task,
        isComplete: task.isComplete,
        description: task.description,
        dateTime: task.dateTime,
        id: task.id);
    await data.updateTask(taskModel);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(int id) async {
    await data.deleteTask(id);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Map<String, int>>> gitAchievements() async {
    try {
      final achievements = await data.gitAchievements();
      return Right(achievements);
    } on EmptyCashException {
      return left(EmptyCashFailure());
    }
  }
}
