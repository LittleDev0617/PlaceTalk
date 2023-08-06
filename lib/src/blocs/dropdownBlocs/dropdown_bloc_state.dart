part of 'dropdown_bloc.dart';

abstract class DropdownBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DropdownInitial extends DropdownBlocState {}

class DropdownWithData extends DropdownBlocState {
  final Map<String, dynamic> itemsLatLng;
  final NaverMapController controller;
  DropdownWithData(this.itemsLatLng, this.controller);

  @override
  List<Object?> get props => [itemsLatLng, controller];
}

class DropdownWithNoData extends DropdownBlocState {}
