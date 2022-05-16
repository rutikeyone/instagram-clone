import 'package:formz/formz.dart';

enum PasswordValidationError { empty, lessThanSixElements }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if (value?.isNotEmpty == true && value!.length <= 6) {
      return PasswordValidationError.lessThanSixElements;
    }
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
