import 'dart:typed_data';

abstract class Firestore {
  Future<void> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage);

  Future<void> likePost(String postId, String uid, List likes);

  Future<void> notLikePost(String postId, String uid, List likes);

  void postComment(String postId, String comment, String uid, String name,
      String profilePicture);

  Future<void> deletePost(String postId);
}
