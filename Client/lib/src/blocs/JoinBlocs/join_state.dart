part of 'join_bloc.dart';

sealed class JoinState extends Equatable {
  const JoinState();

  @override
  List<Object> get props => [];
}

final class JoinInitial extends JoinState {}

class JoinLoading extends JoinState {}

class JoinLoaded extends JoinState {
  final Map<String, Map<String, dynamic>> itemsLatLng;

  const JoinLoaded(this.itemsLatLng);

  @override
  List<Object> get props => [itemsLatLng];
}
