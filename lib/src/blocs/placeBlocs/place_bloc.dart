import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:placex/src/repositories/placeDataRepo.dart';

import '../boothBlocs/booth_bloc.dart';

part 'place_bloc_event.dart';
part 'place_bloc_state.dart';

class PlaceBloc extends Bloc<PlaceBlocEvent, PlaceBlocState> {
  final placeDataRepo placesDataRepo;
  final BoothBloc boothBloc;
  PlaceBloc(this.placesDataRepo, this.boothBloc) : super(NaverMapInitial()) {
    // on<PlaceBlocEvent>((event, emit) {});

    on<FetchNaverMapDataEvent>((event, emit) async {
      emit(NaverMapLoading());

      Map<String, dynamic> datas = await placesDataRepo.fetchData();
      emit(NaverMapLoaded(datas['markers']));
    });

    on<FetchJoinDataEvent>((event, emit) async {
      emit((JoinDataLoading()));
      Map<String, dynamic> datas = await placesDataRepo.fetchData();
      List<String> namesList = datas['names'];

      emit((JoinDataLoaded(namesList)));
    });
  }
}
