part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class FetchCommentsEvent extends CommentEvent {
  final int postId;

  const FetchCommentsEvent(this.postId);
}
