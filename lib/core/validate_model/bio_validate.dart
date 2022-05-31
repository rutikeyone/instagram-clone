import 'package:formz/formz.dart';

enum BioValidationError { empty }

class BioValidate extends FormzInput<String, BioValidationError> {
  const BioValidate.pure() : super.pure('');
  const BioValidate.dirty([String value = '']) : super.dirty(value);

  @override
  BioValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : BioValidationError.empty;
  }
}
