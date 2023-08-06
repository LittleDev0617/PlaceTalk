part of 'place_bloc.dart';

abstract class PlaceBlocState extends Equatable {
  const PlaceBlocState();

  @override
  List<Object?> get props => [];
}

class NaverMapInitial extends PlaceBlocState {}

class NaverMapLoading extends PlaceBlocState {}

class NaverMapLoaded extends PlaceBlocState {
  final Set<NMarker> markers;

  NaverMapLoaded(this.markers);

  @override
  List<Object?> get props => [markers];
}
