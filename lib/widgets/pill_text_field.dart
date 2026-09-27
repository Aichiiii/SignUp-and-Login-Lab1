import 'package:flutter/material.dart';
import '../main.dart';

// A rounded "pill" shaped text field, styled after Pinterest's
// login/signup inputs — filled background, no visible border,
// fully rounded corners, with optional leading icon, a show/hide
// toggle for passwords, and built-in validation support.
class PillTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;

  const PillTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<PillTextField> createState() => _PillTextFieldState();
}

class _PillTextFieldState extends State<PillTextField> {
  late bool _obscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    // Note: the pill background/shadow now lives on the InputDecoration
    // itself (via `filled`/`fillColor` + border), not on a wrapping
    // Container. A wrapping Container would paint its background behind
    // the *entire* widget — including the error text below the input —
    // which is what made the pill stretch to swallow the red error line.
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscured,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      style: const TextStyle(color: AppColors.brownDark, fontSize: 15),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.hint),
        filled: true,
        fillColor: AppColors.fieldFill,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppColors.brown, size: 20)
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscured ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.hint,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscured = !_obscured),
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.brown, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        ),
        errorMaxLines: 2,
        errorStyle: const TextStyle(fontSize: 12, height: 0.9),
      ),
    );
  }
}