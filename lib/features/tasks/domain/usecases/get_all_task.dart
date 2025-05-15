import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/task.dart';
import '../repositories/task_repositories.dart';

class GetAllTasksUseCase {
  final TaskRepositories repository;

  GetAllTasksUseCase(this.repository);

  Future<Either<Failure, List<Tasks>>> call() async {
    return await repository.getAllTasks();
  }
}
