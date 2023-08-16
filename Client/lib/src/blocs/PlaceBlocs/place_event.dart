part of 'place_bloc.dart';

sealed class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object?> get props => [];
}

class RequestLocationPermission extends PlaceEvent {}

class FetchNaverMapDataEvent extends PlaceEvent {
  const FetchNaverMapDataEvent({this.position});

  final NCameraPosition? position;

  @override
  List<Object?> get props => [position];
}

class FetchCategoryMapDataEvent extends PlaceEvent {
  const FetchCategoryMapDataEvent(
      {required this.category, required this.position});

  final String category;
  final NCameraPosition position;

  @override
  List<Object?> get props => [category, position];
}
