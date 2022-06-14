import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/core/model/comment.dart';
import 'package:instagram_clone/core/model/post.dart';

class ReceiveCommentsWithPost {
  Future<List<Comment>> receiveCommentsWithPost(
      Post post, FirebaseFirestore firebaseFirestore) async {
    final data = await firebaseFirestore
        .collection('posts')
        .doc(post.postId)
        .collection('comments')
        .orderBy('datePublished')
        .get();
    final documents = data.docs;
    final List<Comment> comments =
        documents.map((e) => Comment.fromSnapshot(e)).toList();
    return comments;
  }
}
