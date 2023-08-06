import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/placeDataRepo.dart';

part 'explore_bloc_event.dart';
part 'explore_bloc_state.dart';

class ExploreBloc extends Bloc<ExploreBlocEvent, ExploreBloceState> {
  final placeDataRepo placesDataRepo;
  ExploreBloc(this.placesDataRepo) : super(ExploreInitial()) {
    // on<ExploreEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<FetchExploreDataEvent>((event, emit) async {
      emit((ExploreDataLoading()));
      Map<String, dynamic> datas = await placesDataRepo.fetchData();
      Map<String, dynamic> itemsLatLng = datas['itemsLatLng'];

      emit((ExploreDataLoaded(itemsLatLng)));
    });
  }
}
