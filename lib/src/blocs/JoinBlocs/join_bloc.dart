import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:placetalk/src/repositories/JoinRepo.dart';

import 'package:placetalk/src/repositories/PlaceRepo.dart';

part 'join_event.dart';
part 'join_state.dart';

class JoinBloc extends Bloc<JoinEvent, JoinState> {
  final PlaceRepo _placeRepo;
  final JoinRepo _joinRepo;

  JoinBloc(this._placeRepo, this._joinRepo) : super(JoinInitial()) {
    on<JoinEvent>((event, emit) {});

    on<FetchJoinDataEvent>((event, emit) async {
      emit((JoinLoading()));
      Map<String, dynamic> datas = await _placeRepo.fetchJoinData(event.userID);

      emit((JoinLoaded(datas['itemsLatLng'])));
    });

    on<ToExitEvnet>((event, emit) async {
      _joinRepo.toExitBoard(event.placeID);
      emit(JoinInitial());
    });
  }
}
