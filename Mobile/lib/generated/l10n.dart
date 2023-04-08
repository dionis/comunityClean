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

  /// `Press the button (+)`
  String get tCompletos1 {
    return Intl.message(
      'Press the button (+)',
      name: 'tCompletos1',
      desc: '',
      args: [],
    );
  }

  /// ` and request your first service.`
  String get tCompletos2 {
    return Intl.message(
      ' and request your first service.',
      name: 'tCompletos2',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get tPendientes {
    return Intl.message(
      'Pending',
      name: 'tPendientes',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get tCompletados {
    return Intl.message(
      'Completed',
      name: 'tCompletados',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get tDireccion {
    return Intl.message(
      'Address',
      name: 'tDireccion',
      desc: '',
      args: [],
    );
  }

  /// `Between Streets`
  String get tEntreCalles {
    return Intl.message(
      'Between Streets',
      name: 'tEntreCalles',
      desc: '',
      args: [],
    );
  }

  /// `Province`
  String get tProvincia {
    return Intl.message(
      'Province',
      name: 'tProvincia',
      desc: '',
      args: [],
    );
  }

  /// `Municipality`
  String get tMunicipio {
    return Intl.message(
      'Municipality',
      name: 'tMunicipio',
      desc: '',
      args: [],
    );
  }

  /// `The field must not be empty`
  String get tValidateV {
    return Intl.message(
      'The field must not be empty',
      name: 'tValidateV',
      desc: '',
      args: [],
    );
  }

  /// `Meters of garbage`
  String get tMetrosBasura {
    return Intl.message(
      'Meters of garbage',
      name: 'tMetrosBasura',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get tImagen {
    return Intl.message(
      'Image',
      name: 'tImagen',
      desc: '',
      args: [],
    );
  }

  /// `Reference Image`
  String get tImagenR {
    return Intl.message(
      'Reference Image',
      name: 'tImagenR',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get tAtras {
    return Intl.message(
      'Back',
      name: 'tAtras',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get tFinalizar {
    return Intl.message(
      'Finish',
      name: 'tFinalizar',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get tSiguiente {
    return Intl.message(
      'Next',
      name: 'tSiguiente',
      desc: '',
      args: [],
    );
  }

  /// `Cubic Meters of Garbage`
  String get tMetrosBasuraC {
    return Intl.message(
      'Cubic Meters of Garbage',
      name: 'tMetrosBasuraC',
      desc: '',
      args: [],
    );
  }

  /// `The value must be a valid number`
  String get tValidateIValid {
    return Intl.message(
      'The value must be a valid number',
      name: 'tValidateIValid',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {name}`
  String tWelcome(Object name) {
    return Intl.message(
      'Welcome $name',
      name: 'tWelcome',
      desc: '',
      args: [name],
    );
  }

  /// `Username: `
  String get tNombre {
    return Intl.message(
      'Username: ',
      name: 'tNombre',
      desc: '',
      args: [],
    );
  }

  /// `Email: `
  String get tEmail {
    return Intl.message(
      'Email: ',
      name: 'tEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password: `
  String get tContra {
    return Intl.message(
      'Password: ',
      name: 'tContra',
      desc: '',
      args: [],
    );
  }

  /// `Request your Service`
  String get tServicio {
    return Intl.message(
      'Request your Service',
      name: 'tServicio',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get tHome {
    return Intl.message(
      'Home',
      name: 'tHome',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get tUser {
    return Intl.message(
      'User',
      name: 'tUser',
      desc: '',
      args: [],
    );
  }

  /// `Submitting Request Please Wait...`
  String get tSubiendo {
    return Intl.message(
      'Submitting Request Please Wait...',
      name: 'tSubiendo',
      desc: '',
      args: [],
    );
  }

  /// `Amount of Garbage`
  String get tCantBasura {
    return Intl.message(
      'Amount of Garbage',
      name: 'tCantBasura',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this contract?`
  String get tPregunta {
    return Intl.message(
      'Are you sure you want to delete this contract?',
      name: 'tPregunta',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get tConfirmacion {
    return Intl.message(
      'Confirmation',
      name: 'tConfirmacion',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get tCancelar {
    return Intl.message(
      'Cancel',
      name: 'tCancelar',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get tAceptar {
    return Intl.message(
      'Accept',
      name: 'tAceptar',
      desc: '',
      args: [],
    );
  }

  /// `Locate on the Map`
  String get tUbicar {
    return Intl.message(
      'Locate on the Map',
      name: 'tUbicar',
      desc: '',
      args: [],
    );
  }

  /// `Save Position`
  String get tSavePosition {
    return Intl.message(
      'Save Position',
      name: 'tSavePosition',
      desc: '',
      args: [],
    );
  }

  /// `Between`
  String get tEntre {
    return Intl.message(
      'Between',
      name: 'tEntre',
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
      Locale.fromSubtags(languageCode: 'es'),
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
