import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final int maxLines;
  final double borderRadius;
  final bool autocorrect;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool autofocus;
  final bool enableSuggestions;
  final ValueChanged? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final bool enabled;

  const AppTextField({
    Key? key,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.maxLines = 1,
    this.borderRadius = 5,
    this.autocorrect = false,
    this.textInputAction,
    this.textInputType,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = true,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onChanged: onChanged,
      autofocus: autofocus,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.top,
      autocorrect: autocorrect,
      textInputAction: textInputAction,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      // textAlign: textAlign,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFEAEAEA),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFFEAEAEA),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFFEAEAEA),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(width: 1, color: Colors.red.shade400),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(width: 1, color: Colors.red.shade400),
        ),
        errorStyle: GoogleFonts.nunitoSans(
          color: Colors.red.shade400,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: GoogleFonts.nunitoSans(
            color: const Color(0xFF898989),
            fontSize: 17,
            fontWeight: FontWeight.w600),
        prefixIcon: prefixIcon,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
