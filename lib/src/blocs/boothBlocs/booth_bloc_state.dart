part of 'booth_bloc.dart';

abstract class BoothBlocState extends Equatable {
  const BoothBlocState();

  @override
  List<Object?> get props => [];

  get position => null;
}

class BoothInitial extends BoothBlocState {
  @override
  List<Object?> get props => [];
}

class BoothLoading extends BoothBlocState {
  @override
  List<Object?> get props => [];
}

class BoothLoaded extends BoothBlocState {
  final Set<NMarker> markers;
  final List<boothModel> dataList;
  final NLatLng position;
  final NMarker mainMaker;

  const BoothLoaded(
      {required this.position,
      required this.markers,
      required this.dataList,
      required this.mainMaker});

  @override
  List<Object?> get props => [markers, dataList, position];
}

class BoothPoped extends BoothBlocState {
  final NLatLng position;
  const BoothPoped({required this.position});

  @override
  List<Object?> get props => [position];
}
