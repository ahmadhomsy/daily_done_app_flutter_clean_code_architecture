import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/task.dart';
import '../repositories/task_repositories.dart';

class UpdateTaskUseCase {
  final TaskRepositories repository;

  UpdateTaskUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Tasks task) async {
    return await repository.updateTask(task);
  }
}
