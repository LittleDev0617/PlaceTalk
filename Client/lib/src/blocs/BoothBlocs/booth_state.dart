part of 'booth_bloc.dart';

sealed class BoothState extends Equatable {
  const BoothState();

  @override
  List<Object> get props => [];
}

class BoothInitial extends BoothState {}

class BoothLoading extends BoothState {}

class BoothLoaded extends BoothState {
  final Set<NMarker> markers;
  final Map<String, dynamic> itemsLatLng;

  const BoothLoaded(this.markers, this.itemsLatLng);

  @override
  List<Object> get props => [markers, itemsLatLng];
}
