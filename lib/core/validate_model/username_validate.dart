import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class UsernameValidate extends FormzInput<String, UsernameValidationError> {
  const UsernameValidate.pure() : super.pure('');
  const UsernameValidate.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
  }
}
