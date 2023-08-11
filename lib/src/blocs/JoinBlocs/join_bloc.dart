import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/placeDataRepo.dart';

part 'join_bloc_event.dart';
part 'join_bloc_state.dart';

class JoinBloc extends Bloc<JoinBlocEvent, JoinBlocState> {
  final placeDataRepo placesDataRepo;
  JoinBloc(this.placesDataRepo) : super(JoinInitial()) {
    // on<JoinBlocEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<FetchJoinDataEvent>((event, emit) async {
      emit((JoinDataLoading()));
      Map<String, dynamic> datas = await placesDataRepo.fetchData();

      List<String> namesList = datas['names'];

      Map<String, dynamic> itemsLatLng = datas['itemsLatLng'];

      emit((JoinDataLoaded(namesList, itemsLatLng)));
    });
  }
}
