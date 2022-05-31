import 'package:formz/formz.dart';

enum PostValidationError { empty }

class PostValidate extends FormzInput<String, PostValidationError> {
  const PostValidate.pure() : super.pure('');
  const PostValidate.dirty([String value = '']) : super.dirty(value);

  @override
  PostValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PostValidationError.empty;
  }
}
