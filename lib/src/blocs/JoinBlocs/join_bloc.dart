import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:placetalk/src/repositories/PlaceRepo.dart';

part 'join_event.dart';
part 'join_state.dart';

class JoinBloc extends Bloc<JoinEvent, JoinState> {
  final PlaceRepo _placeRepo;

  JoinBloc(this._placeRepo) : super(JoinInitial()) {
    on<JoinEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchJoinDataEvent>((event, emit) async {
      emit((JoinLoading()));
      Map<String, dynamic> datas = await _placeRepo.fetchData();

      emit((JoinLoaded(datas['itemsLatLng'])));
    });
  }
}
