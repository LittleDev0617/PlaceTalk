part of 'join_bloc.dart';

sealed class JoinEvent extends Equatable {
  const JoinEvent();

  @override
  List<Object> get props => [];
}

class FetchJoinDataEvent extends JoinEvent {
  final int userID;
  const FetchJoinDataEvent(this.userID);
  @override
  List<Object> get props => [userID];
}

class ToExitEvnet extends JoinEvent {
  final int placeID;
  const ToExitEvnet(this.placeID);

  @override
  List<Object> get props => [placeID];
}
