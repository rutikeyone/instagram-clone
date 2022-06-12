import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/service/firestore.dart';
import 'package:instagram_clone/core/service/storage.dart';
import 'package:uuid/uuid.dart';

class FirestoreImpl extends Firestore {
  final Storage storageService;
  final FirebaseFirestore firestore;

  FirestoreImpl({required this.storageService, required this.firestore});

  @override
  Future<void> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    final photoUrl =
        await storageService.uploadImageToStorage('posts', file, true, uid);
    final postId = const Uuid().v1();
    final post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profileImage: profImage);
    firestore.collection('posts').doc(postId).set(post.toJson());
  }

  @override
  Future<void> likePost(String postId, String uid, List likes) async {
    if (!likes.contains(uid)) {
      await firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  @override
  Future<void> notLikePost(String postId, String uid, List likes) async {
    await firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayRemove([uid])
    });
  }

  @override
  void postComment(String postId, String comment, String uid, String name,
      String profilePicture) {
    String commentId = const Uuid().v1();
    Map<String, dynamic> data = {
      'profilePicture': profilePicture,
      'name': name,
      'uid': uid,
      'comment': comment,
      'commentId': commentId,
      'datePublished': DateTime.now(),
    };
    firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .set(data);
  }

  @override
  Future<void> deletePost(String postId) async {
    await firestore.collection('posts').doc(postId).delete();
  }
}
