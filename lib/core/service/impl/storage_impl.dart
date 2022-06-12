import 'dart:typed_data';

import 'package:instagram_clone/core/service/storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageImpl extends Storage {
  late final FirebaseStorage _storage;

  StorageImpl() {
    _storage = FirebaseStorage.instance;
  }

  @override
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost, String uid) async {
    Reference ref = _storage.ref().child(childName).child(uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
