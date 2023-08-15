part of 'booth_bloc.dart';

sealed class BoothEvent extends Equatable {
  const BoothEvent();

  @override
  List<Object> get props => [];
}

class FetchBoothData extends BoothEvent {
  final int locID;

  const FetchBoothData(this.locID);

  @override
  List<Object> get props => [locID];
}
