part of 'join_bloc.dart';

sealed class JoinEvent extends Equatable {
  const JoinEvent();

  @override
  List<Object> get props => [];
}

class FetchJoinDataEvent extends JoinEvent {}
