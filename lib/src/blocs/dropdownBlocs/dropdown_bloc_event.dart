part of 'dropdown_bloc.dart';

// dropdown_event.dart

abstract class DropdownBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDataEvent extends DropdownBlocEvent {
  final NaverMapController controller;

  FetchDataEvent(this.controller);
}

class AddDataEvent extends DropdownBlocEvent {
  final String item;
  final double latitude;
  final double longitude;

  final NaverMapController controller;

  AddDataEvent(this.item, this.controller, this.latitude, this.longitude);
}
