import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/BoardModel.dart';
import '../../repositories/BoardRepo.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardRepo _boardRepo;

  BoardBloc(this._boardRepo) : super(BoardInitial()) {
    on<BoardEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchBoardData>((event, emit) async {
      emit(BoardLoading());
      final boardList = await _boardRepo.fetchBoardData(event.placeID);
      emit(BoardLoaded(boardList));
    });
  }
}
