import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:placetalk/src/repositories/PlaceRepo.dart';

import '../../models/LocationPermissionStatusModel.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepo _placeRepo;

  PlaceBloc(this._placeRepo) : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<RequestLocationPermission>((event, emit) async {
      final permission = await _placeRepo.checkLocationPermission();
      if (permission == LocationPermissionStatusModel.granted) {
        emit(LocationPermissionGranted());
      } else if (permission == LocationPermissionStatusModel.denied) {
        emit(LocationPermissionDenied());
      } else {
        emit(LocationPermissionUnknown());
      }
    });
    on<FetchNaverMapDataEvent>((event, emit) async {
      emit(PlaceLoading());

      Map<String, dynamic> datas = await _placeRepo.fetchData();

      emit(PlaceLoaded(datas['markers'], datas['itemsLatLng']));
    });
  }
}

//Observer
class PlaceBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('onEvent: $event');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('onTransition: $transition');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('onError: $error');
    }
  }
}
