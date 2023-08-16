import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:placetalk/src/repositories/PlaceRepo.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final PlaceRepo _placeRepo;
  ExploreBloc(this._placeRepo) : super(ExploreInitial()) {
    on<ExploreEvent>((event, emit) {});

    on<FetchExploreDataEvent>((event, emit) async {
      emit((ExploreLoading()));
      Map<String, dynamic> datas = await _placeRepo.fetchExploreData();
      Map<String, dynamic> itemsLatLng = datas['itemsLatLng'];

      emit((ExploreLoaded(itemsLatLng)));
    });
  }
}
