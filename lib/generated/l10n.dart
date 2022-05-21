// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Username or email`
  String get username_or_email {
    return Intl.message(
      'Username or email',
      name: 'username_or_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `The login or mail field should not be empty`
  String get the_login_or_password_validate_message_1 {
    return Intl.message(
      'The login or mail field should not be empty',
      name: 'the_login_or_password_validate_message_1',
      desc: '',
      args: [],
    );
  }

  /// `The password field cannot be empty`
  String get the_password_validate_message_1 {
    return Intl.message(
      'The password field cannot be empty',
      name: 'the_password_validate_message_1',
      desc: '',
      args: [],
    );
  }

  /// `The email field cannot be empty`
  String get the_email_validate_message_1 {
    return Intl.message(
      'The email field cannot be empty',
      name: 'the_email_validate_message_1',
      desc: '',
      args: [],
    );
  }

  /// `The username field cannot be empty`
  String get the_username_validate_message_1 {
    return Intl.message(
      'The username field cannot be empty',
      name: 'the_username_validate_message_1',
      desc: '',
      args: [],
    );
  }

  /// `The bio field cannot be empty`
  String get the_bio_validate_message_1 {
    return Intl.message(
      'The bio field cannot be empty',
      name: 'the_bio_validate_message_1',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get log_in {
    return Intl.message(
      'Log in',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get don_t_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'don_t_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Not email`
  String get the_email_validate_message_2 {
    return Intl.message(
      'Not email',
      name: 'the_email_validate_message_2',
      desc: '',
      args: [],
    );
  }

  /// `There must be more than six elements in the password field`
  String get the_password_validate_message_2 {
    return Intl.message(
      'There must be more than six elements in the password field',
      name: 'the_password_validate_message_2',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
