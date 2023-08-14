part of 'feed_bloc.dart';

sealed class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class FetchFeedData extends FeedEvent {}

class FetchEventFeedData extends FeedEvent {
  final int placeId;

  const FetchEventFeedData(this.placeId);

  @override
  List<Object> get props => [placeId];
}
