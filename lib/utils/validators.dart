import 'package:flutter/material.dart';

// Small, reusable field validators for use with TextFormField's
// `validator` callback across the app.
class Validators {
  Validators._();

  static final RegExp _emailRegex =
      RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');

  static final RegExp _phoneRegex = RegExp(r'^[0-9+\-\s]{7,15}$');

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? email(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(trimmed)) return 'Enter a valid email address';
    return null;
  }

  /// Looser check for the Login screen, which accepts either an
  /// email or a username.
  static String? emailOrUsername(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Email or username is required';
    if (trimmed.length < 3) return 'Must be at least 3 characters';
    return null;
  }

  static String? phone(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Phone number is required';
    if (!_phoneRegex.hasMatch(trimmed)) return 'Enter a valid phone number';
    return null;
  }

  static String? password(String? value, {int minLength = 8}) {
    final v = value ?? '';
    if (v.isEmpty) return 'Password is required';
    if (v.length < minLength) return 'At least $minLength characters';
    if (!RegExp(r'[A-Za-z]').hasMatch(v) || !RegExp(r'[0-9]').hasMatch(v)) {
      return 'Include both letters and numbers';
    }
    return null;
  }

  /// For Login, where we just need *a* password, not a strong one.
  static String? passwordSimple(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return null;
  }

  static String? Function(String?) confirmPassword(
      TextEditingController originalController) {
    return (value) {
      if (value == null || value.isEmpty) return 'Please confirm password';
      if (value != originalController.text) return 'Passwords do not match';
      return null;
    };
  }
}