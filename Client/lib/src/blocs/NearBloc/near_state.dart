part of 'near_bloc.dart';

class NearState extends Equatable {
  const NearState();

  @override
  List<Object> get props => [];
}

class NearInitial extends NearState {}

class NearLoding extends NearState {}

class NearLoaded extends NearState {
  final Map<String, Map<String, dynamic>> itemsLatLng;

  const NearLoaded(this.itemsLatLng);

  @override
  List<Object> get props => [itemsLatLng];
}
