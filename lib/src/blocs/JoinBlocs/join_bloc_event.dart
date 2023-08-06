part of 'join_bloc.dart';

abstract class JoinBlocEvent extends Equatable {
  const JoinBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchJoinDataEvent extends JoinBlocEvent {}
