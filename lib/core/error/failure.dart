import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class EmptyCashFailure extends Failure {
  @override
  List<Object?> get props => [];
}
