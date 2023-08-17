import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/CommentModel.dart';
import '../../repositories/CommentRepo.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepo _commentRepo;

  CommentBloc(this._commentRepo) : super(CommentInitial()) {
    on<CommentEvent>((event, emit) {});

    on<FetchCommentsEvent>((event, emit) async {
      emit(CommentLoading());
      final List<CommentModel> comments =
          await _commentRepo.fetchCommentData(event.postId);
      emit(CommentLoaded(comments));
    });
  }
}
