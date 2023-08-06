part of 'explore_bloc.dart';

abstract class ExploreBloceState extends Equatable {
  const ExploreBloceState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreBloceState {}

class ExploreDataLoading extends ExploreBloceState {}

class ExploreDataLoaded extends ExploreBloceState {
  final Map<String, dynamic> datas;

  ExploreDataLoaded(this.datas);

  @override
  List<Object> get props => [datas];
}
