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

class ToJoinEvnet extends BoardEvent {
  final int placeID;
  const ToJoinEvnet(this.placeID);

  @override
  List<Object> get props => [placeID];
}

class FetchLikeOrderData extends BoardEvent {
  final int placeID;
  final int order;
  const FetchLikeOrderData(this.placeID, this.order);

  @override
  List<Object> get props => [placeID, order];
}
