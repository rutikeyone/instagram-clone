// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bio": MessageLookupByLibrary.simpleMessage("Биография"),
        "don_t_have_an_account":
            MessageLookupByLibrary.simpleMessage("У вас нет учетной записи?"),
        "done": MessageLookupByLibrary.simpleMessage("Ок"),
        "email": MessageLookupByLibrary.simpleMessage("Почта"),
        "email_already_in_use":
            MessageLookupByLibrary.simpleMessage("Данная почта уже занята"),
        "log_in": MessageLookupByLibrary.simpleMessage("Войти"),
        "operation_not_allowed":
            MessageLookupByLibrary.simpleMessage("Операция не разрешена"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Создать"),
        "the_bio_validate_message_1": MessageLookupByLibrary.simpleMessage(
            "Поле биографии не может быть пустым"),
        "the_email_validate_message_1": MessageLookupByLibrary.simpleMessage(
            "Поле почты не может быть пустым"),
        "the_email_validate_message_2":
            MessageLookupByLibrary.simpleMessage("Не почта"),
        "the_login_or_password_validate_message_1":
            MessageLookupByLibrary.simpleMessage(
                "Поле логина и почты не должен быть пустым"),
        "the_password_validate_message_1": MessageLookupByLibrary.simpleMessage(
            "Поле пароля не может быть пустым"),
        "the_password_validate_message_2": MessageLookupByLibrary.simpleMessage(
            "В поле пароля должно быть больше шести элементов"),
        "the_username_validate_message_1": MessageLookupByLibrary.simpleMessage(
            "Поле имени не может быть пустым"),
        "username": MessageLookupByLibrary.simpleMessage("Имя"),
        "username_or_email":
            MessageLookupByLibrary.simpleMessage("Имя или почта"),
        "weak_password": MessageLookupByLibrary.simpleMessage("Слабый пароль")
      };
}
