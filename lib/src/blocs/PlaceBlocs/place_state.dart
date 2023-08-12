part of 'place_bloc.dart';

sealed class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final Set<NMarker> markers;
  final Map<String, Map<String, dynamic>> itemsLatLng;

  const PlaceLoaded(this.markers, this.itemsLatLng);

  @override
  List<Object> get props => [markers, itemsLatLng];
}

class LocationPermissionGranted extends PlaceState {}

class LocationPermissionDenied extends PlaceState {}

class LocationPermissionUnknown extends PlaceState {}
