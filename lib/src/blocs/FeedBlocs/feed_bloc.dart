import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:placetalk/src/repositories/FeedRepo.dart';

import '../../models/FeedModel.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepo _feedRepo;
  FeedBloc(this._feedRepo) : super(FeedInitial()) {
    on<FeedEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchFeedData>((event, emit) async {
      emit(FeedLoading());
      final feedList = await _feedRepo.fetchFeedData();
      emit(FeedLoaded(feedList: feedList));
    });
  }
}
