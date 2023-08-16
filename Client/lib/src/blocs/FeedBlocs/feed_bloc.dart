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
      close();
    });
  }
}

class FeedEventBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepo _feedEventRepo;
  FeedEventBloc(this._feedEventRepo) : super(FeedEventInitial()) {
    on<FetchEventFeedData>((event, emit) async {
      emit(FeedEventLoading());
      final feedList = await _feedEventRepo.fetchEventFeedData(event.placeId);
      emit(FeedEventLoaded(feedList: feedList));

      void dispose() {
        super.close();
      }
    });

    on<ToFeedInitial>((event, emit) {
      emit(FeedInitial());
    });
  }
}
