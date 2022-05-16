import 'dart:ffi';
import 'dart:typed_data';

abstract class Storage {
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost);
}
