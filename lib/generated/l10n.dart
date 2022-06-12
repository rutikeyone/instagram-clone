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

  /// `Weak password`
  String get weak_password {
    return Intl.message(
      'Weak password',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `Email Already In Use`
  String get email_already_in_use {
    return Intl.message(
      'Email Already In Use',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Operation Not Allowed`
  String get operation_not_allowed {
    return Intl.message(
      'Operation Not Allowed',
      name: 'operation_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `User Disabled`
  String get user_disabled {
    return Intl.message(
      'User Disabled',
      name: 'user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Password`
  String get wrong_password {
    return Intl.message(
      'Wrong Password',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Create a post`
  String get create_a_post {
    return Intl.message(
      'Create a post',
      name: 'create_a_post',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo`
  String get take_a_photo {
    return Intl.message(
      'Take a photo',
      name: 'take_a_photo',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get choose_from_gallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'choose_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Post to`
  String get post_to {
    return Intl.message(
      'Post to',
      name: 'post_to',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Write a caption`
  String get write_a_caption {
    return Intl.message(
      'Write a caption',
      name: 'write_a_caption',
      desc: '',
      args: [],
    );
  }

  /// `likes`
  String get likes {
    return Intl.message(
      'likes',
      name: 'likes',
      desc: '',
      args: [],
    );
  }

  /// `View all comments`
  String get view_all_comments {
    return Intl.message(
      'View all comments',
      name: 'view_all_comments',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Comment as`
  String get comments_as {
    return Intl.message(
      'Comment as',
      name: 'comments_as',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Search for a user`
  String get search_for_a_user {
    return Intl.message(
      'Search for a user',
      name: 'search_for_a_user',
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
