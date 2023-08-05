part of 'booth_bloc.dart';

abstract class BoothBlocEvent extends Equatable {
  const BoothBlocEvent();

  @override
  List<Object?> get props => [];
}

class FetchBoothDataEvent extends BoothBlocEvent {
  final NLatLng position;
  final NMarker mainMaker;
  const FetchBoothDataEvent(this.position, this.mainMaker);

  @override
  List<Object?> get props => [position];
}

class PopBoothDataEvent extends BoothBlocEvent {
  final NLatLng position;
  const PopBoothDataEvent(this.position);

  @override
  List<Object?> get props => [position];
}
