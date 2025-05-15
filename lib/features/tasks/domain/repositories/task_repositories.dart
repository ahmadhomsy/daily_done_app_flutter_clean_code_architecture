import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/task.dart';

abstract class TaskRepositories {
  Future<Either<Failure, List<Tasks>>> getAllTasks();
  Future<Either<Failure, Unit>> deleteTask(int id);
  Future<Either<Failure, Unit>> updateTask(Tasks task);
  Future<Either<Failure, Unit>> addTask(Tasks task);
  Future<Either<Failure, Map<String, int>>> gitAchievements();
}
