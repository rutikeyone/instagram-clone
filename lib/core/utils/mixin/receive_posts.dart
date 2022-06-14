import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/core/model/post.dart';

class ReceivePosts {
  Future<List<Post>> receivePosts(FirebaseFirestore firebaseFirestore) async {
    final data = await firebaseFirestore
        .collection('posts')
        .orderBy('datePublished')
        .get();
    final documents = data.docs;
    final posts = documents.map((e) => Post.fromSnapshot(e)).toList();
    return posts;
  }
}
