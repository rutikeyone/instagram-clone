import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'feed_post_state.dart';

class FeedPostCubit extends Cubit<FeedPostState> {
  final FirebaseFirestore firebaseFirestore;
  final Stream<QuerySnapshot<Map<String, dynamic>>> postsStream;

  FeedPostCubit({required this.firebaseFirestore})
      : postsStream = firebaseFirestore.collection('posts').snapshots(),
        super(FeedPostInitial());

  void listen() {
    postsStream.listen((data) {
      print(data.docs[0].data());
    });
  }
}
