part of 'explore_bloc.dart';

abstract class ExploreBlocEvent extends Equatable {
  const ExploreBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchExploreDataEvent extends ExploreBlocEvent {}
