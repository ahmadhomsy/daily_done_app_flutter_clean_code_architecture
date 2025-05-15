import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/task_repositories.dart';

class GitAchievementsUseCase {
  final TaskRepositories repository;

  GitAchievementsUseCase(this.repository);

  Future<Either<Failure, Map<String, int>>> call() async {
    return await repository.gitAchievements();
  }
}
