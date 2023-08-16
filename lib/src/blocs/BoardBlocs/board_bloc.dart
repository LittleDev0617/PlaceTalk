import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:placetalk/src/repositories/JoinRepo.dart';

import '../../models/BoardModel.dart';
import '../../repositories/BoardRepo.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardRepo _boardRepo;
  final JoinRepo _joinRepo;

  BoardBloc(this._boardRepo, this._joinRepo) : super(BoardInitial()) {
    on<BoardEvent>((event, emit) {});

    on<FetchBoardData>((event, emit) async {
      emit(BoardLoading());
      final boardList = await _boardRepo.fetchBoardData(event.placeID);
      emit(BoardLoaded(boardList));
    });

    on<ToJoinEvnet>((event, emit) async {
      final code = await _joinRepo.toJoinBoard(event.placeID);
      emit(BoardJoinLoading(codes: code));
    });

    on<FetchLikeOrderData>((event, emit) async {
      emit(BoardLoading());
      final boardList =
          await _boardRepo.fetchLikeOrderData(event.placeID, event.order);
      emit(BoardLoaded(boardList));
    });
  }
}
