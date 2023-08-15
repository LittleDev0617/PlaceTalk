part of 'feed_bloc.dart';

class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<FeedModel> feedList;

  const FeedLoaded({required this.feedList});

  @override
  List<Object> get props => [feedList];
}

class FeedEventInitial extends FeedState {}

class FeedEventLoading extends FeedState {}

class FeedEventLoaded extends FeedState {
  final List<FeedModel> feedList;

  const FeedEventLoaded({required this.feedList});

  @override
  List<Object> get props => [feedList];
}
