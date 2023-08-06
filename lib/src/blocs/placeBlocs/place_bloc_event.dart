part of 'place_bloc.dart';

abstract class PlaceBlocEvent extends Equatable {
  const PlaceBlocEvent();

  @override
  List<Object?> get props => [];
}

class FetchNaverMapDataEvent extends PlaceBlocEvent {}
