part of 'place_bloc.dart';

class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object?> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final Set<NMarker> markers;
  final Map<String, Map<String, dynamic>> itemsLatLng;
  final NCameraPosition? position;

  const PlaceLoaded(this.markers, this.itemsLatLng, {this.position});

  @override
  List<Object?> get props => [markers, itemsLatLng, position];
}

class LocationPermissionGranted extends PlaceState {}

class LocationPermissionDenied extends PlaceState {}

class LocationPermissionUnknown extends PlaceState {}
