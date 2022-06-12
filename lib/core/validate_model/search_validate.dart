import 'package:formz/formz.dart';

enum SearchValidationError { empty }

class SearchValidate extends FormzInput<String, SearchValidationError> {
  const SearchValidate.pure() : super.pure('');
  const SearchValidate.dirty([String value = '']) : super.dirty(value);

  @override
  SearchValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : SearchValidationError.empty;
  }
}
