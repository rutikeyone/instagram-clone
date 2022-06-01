import 'dart:typed_data';

abstract class Firestore {
  Future<void> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage);
}
