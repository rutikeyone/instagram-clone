import 'package:formz/formz.dart';

enum PasswordValidationError { empty, lessThanSixElements }

class PasswordValidate extends FormzInput<String, PasswordValidationError> {
  const PasswordValidate.pure() : super.pure('');
  const PasswordValidate.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if (value?.isNotEmpty == true && value!.length <= 6) {
      return PasswordValidationError.lessThanSixElements;
    }
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
