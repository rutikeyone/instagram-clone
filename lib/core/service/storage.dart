import 'dart:typed_data';

abstract class Storage {
  Future<String> uploadImageForPost(String childName, Uint8List file);

  Future<String> uploadAvatar(String childName, Uint8List file, String uid);
}
