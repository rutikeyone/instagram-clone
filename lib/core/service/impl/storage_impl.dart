import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/service/storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageImpl extends Storage {
  late final FirebaseStorage _storage;
  late final FirebaseAuth _auth;

  StorageImpl() {
    _storage = FirebaseStorage.instance;
    _auth = FirebaseAuth.instance;
  }

  @override
  Future<String> uploadImageForPost(String childName, Uint8List file) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    String id = const Uuid().v1();
    ref = ref.child(id);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<String> uploadAvatar(
      String childName, Uint8List file, String uid) async {
    Reference ref = _storage.ref().child(childName).child(uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
