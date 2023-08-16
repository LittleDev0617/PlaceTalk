part of 'place_info_bloc.dart';

sealed class PlaceInfoEvent extends Equatable {
  const PlaceInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaceInfoData extends PlaceInfoEvent {
  final int placeID;

  const FetchPlaceInfoData(this.placeID);

  @override
  List<Object> get props => [placeID];
}

class FetchPlaceTimeData extends PlaceInfoEvent {
  final int placeID;

  const FetchPlaceTimeData(this.placeID);

  @override
  List<Object> get props => [placeID];
}
