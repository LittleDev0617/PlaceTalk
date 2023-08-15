part of 'board_bloc.dart';

sealed class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object> get props => [];
}

class FetchBoardData extends BoardEvent {
  final int placeID;
  FetchBoardData(this.placeID);

  @override
  List<Object> get props => [placeID];
}
