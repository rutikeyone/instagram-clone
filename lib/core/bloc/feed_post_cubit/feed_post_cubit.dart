import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../model/post.dart';

part 'feed_post_state.dart';

class FeedPostCubit extends Cubit<FeedPostState> {
  final FirebaseFirestore firebaseFirestore;
  final Stream<QuerySnapshot<Map<String, dynamic>>> postsStream;

  FeedPostCubit({required this.firebaseFirestore})
      : postsStream = firebaseFirestore.collection('posts').snapshots(),
        super(const FeedPostInitial(posts: []));

  void listen() {
    postsStream.listen((data) {
      if (state is FeedPostInitial) {
        final feedPostInitial = state as FeedPostInitial;
        final List<Post> updatedList = [];
        for (int i = 0; i < data.docs.length; i++) {
          final newPost = Post.fromSnapshot(data.docs[i]);
          updatedList.add(newPost);
        }

        emit(FeedPostInitial(posts: updatedList));
      }
    });
  }
}
