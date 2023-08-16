part of 'explore_bloc.dart';

sealed class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

final class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final Map<String, dynamic> datas;

  const ExploreLoaded(this.datas);

  @override
  List<Object> get props => [datas];
}
