import 'package:formz/formz.dart';

enum CommentValidationError { empty }

class CommentValidate extends FormzInput<String, CommentValidationError> {
  const CommentValidate.pure() : super.pure('');
  const CommentValidate.dirty([String value = '']) : super.dirty(value);

  @override
  CommentValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : CommentValidationError.empty;
  }
}
