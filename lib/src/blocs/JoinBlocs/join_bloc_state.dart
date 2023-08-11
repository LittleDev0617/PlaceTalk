part of 'join_bloc.dart';

abstract class JoinBlocState extends Equatable {
  const JoinBlocState();

  @override
  List<Object> get props => [];
}

class JoinInitial extends JoinBlocState {}

class JoinDataLoading extends JoinBlocState {}

class JoinDataLoaded extends JoinBlocState {
  final List<String> namesList;

  Map<String, dynamic> datas;
  JoinDataLoaded(
    this.namesList,
    this.datas,
  );

  @override
  List<Object> get props => [namesList, datas];
}
