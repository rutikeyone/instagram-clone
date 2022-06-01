import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feed_post_state.dart';

class FeedPostCubit extends Cubit<FeedPostState> {
  FeedPostCubit() : super(FeedPostInitial());
}
