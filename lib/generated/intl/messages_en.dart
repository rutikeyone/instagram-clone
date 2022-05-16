// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bio": MessageLookupByLibrary.simpleMessage("Bio"),
        "don_t_have_an_account":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "log_in": MessageLookupByLibrary.simpleMessage("Log in"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
        "the_bio_validate_message_1": MessageLookupByLibrary.simpleMessage(
            "The bio field cannot be empty"),
        "the_email_validate_message_1": MessageLookupByLibrary.simpleMessage(
            "The email field cannot be empty"),
        "the_email_validate_message_2":
            MessageLookupByLibrary.simpleMessage("Not email"),
        "the_login_or_password_validate_message_1":
            MessageLookupByLibrary.simpleMessage(
                "The login or mail field should not be empty"),
        "the_password_validate_message_1": MessageLookupByLibrary.simpleMessage(
            "The password field cannot be empty"),
        "the_username_validate_message_1": MessageLookupByLibrary.simpleMessage(
            "The username field cannot be empty"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "username_or_email":
            MessageLookupByLibrary.simpleMessage("Username or email")
      };
}
