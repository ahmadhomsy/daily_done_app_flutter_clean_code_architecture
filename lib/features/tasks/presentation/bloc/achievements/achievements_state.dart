part of 'achievements_bloc.dart';

@immutable
abstract class AchievementsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AchievementsInitial extends AchievementsState {}

class LoadingAchievementsState extends AchievementsState {}

class LoadedAchievementsState extends AchievementsState {
  final Map<String, int> achievements;
  LoadedAchievementsState({required this.achievements});
  @override
  List<Object> get props => [achievements];
}

class ErrorAchievementsState extends AchievementsState {
  final String message;
  ErrorAchievementsState({required this.message});
  @override
  List<Object> get props => [message];
}
