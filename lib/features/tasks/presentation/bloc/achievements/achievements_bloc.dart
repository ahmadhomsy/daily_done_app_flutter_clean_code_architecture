import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/usecases/git_achievements.dart';
part 'achievements_event.dart';
part 'achievements_state.dart';

class AchievementsBloc extends Bloc<AchievementsEvent, AchievementsState> {
  final GitAchievementsUseCase gitAchievementsUseCase;

  AchievementsBloc({required this.gitAchievementsUseCase})
      : super(AchievementsInitial()) {
    on<AchievementsEvent>((event, emit) async {
      if (event is GetAchievementsEvent) {
        emit(LoadingAchievementsState());
        final failureOrAchievements = await gitAchievementsUseCase();
        emit(_mapFailureOrTasksToState(failureOrAchievements));
      }
    });
  }
  AchievementsState _mapFailureOrTasksToState(
      Either<Failure, Map<String, int>> either) {
    return either.fold(
      (failure) => ErrorAchievementsState(message: emptyCashFailureMessage),
      (achievements) => LoadedAchievementsState(
        achievements: achievements,
      ),
    );
  }
}
