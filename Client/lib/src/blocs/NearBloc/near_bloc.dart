import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:placetalk/src/repositories/PlaceRepo.dart';

part 'near_event.dart';
part 'near_state.dart';

class NearBloc extends Bloc<NearEvent, NearState> {
  final PlaceRepo _placeRepo;

  NearBloc(this._placeRepo) : super(NearInitial()) {
    on<NearEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchNearMapDataEvent>((event, emit) async {
      emit(NearLoding());
      Map<String, dynamic> datas = await _placeRepo.fetchNearData();
      Map<String, Map<String, dynamic>> itemsLatLng = datas['itemsLatLng'];
      emit(NearLoaded(itemsLatLng));
    });
  }
}
