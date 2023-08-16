import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:placetalk/src/repositories/PlaceRepo.dart';

import '../../models/PlaceInfoModel.dart';
import '../../repositories/PlaceInfoRepo.dart';

part 'place_info_event.dart';
part 'place_info_state.dart';

class PlaceInfoBloc extends Bloc<PlaceInfoEvent, PlaceInfoState> {
  final PlaceInfoRepo _placeInfoRepo;
  final PlaceRepo _placeRepo;

  PlaceInfoBloc(this._placeInfoRepo, this._placeRepo)
      : super(PlaceInfoInitial()) {
    on<FetchPlaceInfoData>((event, emit) async {
      emit(PlaceInfoLoading());
      final placeInfoList =
          await _placeInfoRepo.fetchPlaceInfoData(event.placeID);

      final Map<String, dynamic> items =
          await _placeRepo.fetchIdData(event.placeID);
      emit(PlaceInfoLoaded(placeInfoList, items));
    });
  }
}

class PlaceTimeBloc extends Bloc<PlaceInfoEvent, PlaceInfoState> {
  final PlaceInfoRepo _placeInfoRepo;

  PlaceTimeBloc(this._placeInfoRepo) : super(PlaceInfoInitial()) {
    on<FetchPlaceTimeData>((event, emit) async {
      emit(PlaceInfoLoading());
      final placeTimeList =
          await _placeInfoRepo.fetchPlaceTimeData(event.placeID);

      emit(PlaceTimeLoaded(placeTimeList));
    });
  }
}
