part of 'place_info_bloc.dart';

sealed class PlaceInfoState extends Equatable {
  const PlaceInfoState();

  @override
  List<Object> get props => [];
}

final class PlaceInfoInitial extends PlaceInfoState {}

class PlaceInfoLoading extends PlaceInfoState {}

class PlaceInfoLoaded extends PlaceInfoState {
  final List<PlaceInfoModel> placeInfoList;
  final Map<String, dynamic> items;

  const PlaceInfoLoaded(this.placeInfoList, this.items);

  @override
  List<Object> get props => [placeInfoList, items];
}

class PlaceTimeLoaded extends PlaceInfoState {
  final Map<String, dynamic> placeTimeList;

  const PlaceTimeLoaded(this.placeTimeList);

  @override
  List<Object> get props => [placeTimeList];
}
