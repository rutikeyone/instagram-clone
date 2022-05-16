import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

abstract class Picker {
  Future<Uint8List?> pickImage(ImageSource source);
}
