part of 'achievements_bloc.dart';

@immutable
abstract class AchievementsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAchievementsEvent extends AchievementsEvent {}
