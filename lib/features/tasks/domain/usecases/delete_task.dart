import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/task_repositories.dart';

class DeleteTaskUseCase {
  final TaskRepositories repository;

  DeleteTaskUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteTask(id);
  }
}
