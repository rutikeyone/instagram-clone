import 'package:formz/formz.dart';

enum EmailValidationError { empty, notEmail }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isNotEmpty == true &&
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(this.value)) return EmailValidationError.notEmail;
    return value?.isNotEmpty == true ? null : EmailValidationError.empty;
  }
}
