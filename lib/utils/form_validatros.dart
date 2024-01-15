import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FormValidators {
  static bool isValidForm(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'enterEmail'.tr();
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
      return 'enterValidEmail'.tr();
    }
    return null;
  }

  static String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'enterValidName'.tr();
    }
    return null;
  }

  static String? validateReminderTitle(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'enterValidTitle'.tr();
    }
    return null;
  }

  static String? validateReminderBody(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'enterValidDescription'.tr();
    }
    return null;
  }

  static String? validateDate(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'enterValidDate'.tr();
    }
    return null;
  }

  static String? validateWeight(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'enterWeight'.tr();
    }
    if (!RegExp(r'^\d+\.?\d{0,2}').hasMatch(value)) {
      return 'enterValidWeight'.tr();
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'enterPassword'.tr();
    }
    if (value.length < 8) {
      return 'passwordLength'.tr();
    }
    return null;
  }

  static String? confirmPassword(String? confirmNewPassWord, String newPassWord, BuildContext context) {
    if (confirmNewPassWord == null || confirmNewPassWord.isEmpty) {
      return 'confirmNewPassword'.tr();
    }
    if (confirmNewPassWord != newPassWord) {
      return 'passwordsNotMatch'.tr();
    }
    return null;
  }
}
