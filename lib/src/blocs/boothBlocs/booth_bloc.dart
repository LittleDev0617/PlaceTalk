import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../../models/boothsModel.dart';
import '../../repositories/boothDataRepo.dart';

part 'booth_bloc_event.dart';
part 'booth_bloc_state.dart';

class BoothBloc extends Bloc<BoothBlocEvent, BoothBlocState> {
  final boothDataRepo dataRepo;

  BoothBloc(this.dataRepo) : super(BoothInitial()) {
    // on<BoothBlocEvent>((event, emit) {});
    on<FetchBoothDataEvent>((event, emit) async {
      emit(BoothLoading());

      final data = await dataRepo.fetchData();

      emit(BoothLoaded(
          markers: data['markers'],
          dataList: data['dataList'],
          position: event.position,
          mainMaker: event.mainMaker));
    });

    on<PopBoothDataEvent>((event, emit) async {
      emit(BoothPoped(position: event.position));
    });
  }
}
