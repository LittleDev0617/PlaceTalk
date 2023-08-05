import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:placex/src/repositories/placeDataRepo.dart';

part 'dropdown_bloc_event.dart';
part 'dropdown_bloc_state.dart';

class DropdownBloc extends Bloc<DropdownBlocEvent, DropdownBlocState> {
  DropdownBloc() : super(DropdownInitial()) {
    // on<DropdownBlocEvent>((event, emit) {});
    on<FetchDataEvent>((event, emit) async {
      Map<String, dynamic> datas = await placeDataRepo().fetchData();
      if (datas.isNotEmpty) {
        emit(DropdownWithData(datas['itemsLatLng'], event.controller));
      } else {
        emit(DropdownWithNoData());
      }
    });

    on<AddDataEvent>((event, emit) async {
      Map<String, dynamic> datas = await placeDataRepo().fetchData();
      if (datas.isNotEmpty) {
        Map<String, Map<String, double>> itemsLatLng = datas['itemsLatLng'];
        itemsLatLng[event.item] = {
          'latitude': event.latitude,
          'longitude': event.longitude
        };
        emit(DropdownWithData(itemsLatLng, event.controller));
      } else {
        emit(DropdownWithNoData());
      }
    });
  }
}
