part of 'board_bloc.dart';

sealed class BoardState extends Equatable {
  const BoardState();

  @override
  List<Object> get props => [];
}

final class BoardInitial extends BoardState {}

class BoardLoading extends BoardState {}

class BoardLoaded extends BoardState {
  final List<BoardModel> boards;
  const BoardLoaded(this.boards);
}

class BoardJoinLoading extends BoardState {
  final int codes;

  const BoardJoinLoading({required this.codes});
}
