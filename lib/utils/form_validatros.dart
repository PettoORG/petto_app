import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FormValidators {
  static bool isValidForm(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterEmail;
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
      return AppLocalizations.of(context)!.enterValidEmail;
    }
    return null;
  }

  static String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterValidName;
    }
    return null;
  }

  static String? validateReminderTitle(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Ingresa un titulo valido';
    }
    return null;
  }

  static String? validateReminderBody(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Ingresa una descripcion valida';
    }
    return null;
  }

  static String? validateDate(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una fecha valida';
    }
    return null;
  }

  static String? validateWeight(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un peso';
    }
    if (!RegExp(r'^\d+\.?\d{0,2}').hasMatch(value)) {
      return 'Ingrese un peso valido';
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    }
    if (value.length < 8) {
      return AppLocalizations.of(context)!.passwordLength;
    }
    return null;
  }

  static String? confirmPassword(String? confirmNewPassWord, String newPassWord, BuildContext context) {
    if (confirmNewPassWord == null || confirmNewPassWord.isEmpty) {
      return 'Confirme su nueva contraseña';
    }
    if (confirmNewPassWord != newPassWord) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
