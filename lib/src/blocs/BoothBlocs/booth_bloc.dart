import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:placetalk/src/repositories/BoothRepo.dart';

part 'booth_event.dart';
part 'booth_state.dart';

class BoothBloc extends Bloc<BoothEvent, BoothState> {
  final BoothRepo _boothRepo;

  BoothBloc(this._boothRepo) : super(BoothInitial()) {
    on<BoothEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchBoothData>((event, emit) async {
      emit(BoothLoading());
      final datas = await _boothRepo.fetchData(event.placeID);

      Set<NMarker> markers = datas['markers'];
      Map<String, dynamic> itemsLatLng = datas['itemsLatLng'];

      emit(BoothLoaded(markers, itemsLatLng));
    });
  }
}
