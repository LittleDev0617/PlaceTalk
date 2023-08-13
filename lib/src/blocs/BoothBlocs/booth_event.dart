part of 'booth_bloc.dart';

sealed class BoothEvent extends Equatable {
  const BoothEvent();

  @override
  List<Object> get props => [];
}

class FetchBoothData extends BoothEvent {
  final int placeID;

  const FetchBoothData(this.placeID);

  @override
  List<Object> get props => [placeID];
}
