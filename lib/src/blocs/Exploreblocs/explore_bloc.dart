import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:placetalk/src/repositories/PlaceRepo.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final PlaceRepo _placeRepo;
  ExploreBloc(this._placeRepo) : super(ExploreInitial()) {
    on<ExploreEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchExploreDataEvent>((event, emit) async {
      emit((ExploreLoading()));
      Map<String, dynamic> datas = await _placeRepo.fetchData();
      Map<String, dynamic> itemsLatLng = datas['itemsLatLng'];
      // Map<String, dynamic> itemsLatLngBound = {};

      // const latlng = NLatLng(37.5435, 127.0775);
      // var bounds = NLatLngBounds.from([
      //   latlng.offsetByMeter(northMeter: 1063, eastMeter: 1063),
      //   latlng.offsetByMeter(northMeter: -1063, eastMeter: 1063),
      //   latlng.offsetByMeter(northMeter: 1063, eastMeter: -1063),
      //   latlng.offsetByMeter(northMeter: -1063, eastMeter: 1063),
      // ]);

      // for (var key in itemsLatLng.keys.toList()) {
      //   if (bounds.containsPoint(NLatLng(
      //       itemsLatLng[key]['latitude'], itemsLatLng[key]['longitude']))) {
      //     itemsLatLngBound[key] = {
      //       'latitude': itemsLatLng[key]['latitude'],
      //       'longitude': itemsLatLng[key]['longitude'],
      //       'startDate': itemsLatLng[key]['startDate'],
      //       'endDate': itemsLatLng[key]['endDate'],
      //     };
      //   }
      // }

      emit((ExploreLoaded(itemsLatLng)));
    });
  }
}
