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
        await storageService.uploadImageToStorage('posts', file, true);
    final postId = const Uuid().v1();
    final post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage);
    firestore.collection('posts').doc(postId).set(post.toJson());
  }
}
