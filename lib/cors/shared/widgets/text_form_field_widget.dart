import 'package:authentication/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final bool? autofocus;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextAlign? textAlign;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  const TextFormFieldWidget({
    super.key,
    this.autofocus,
    this.controller,
    this.textInputAction,
    this.keyboardType,
    this.obscureText,
    this.maxLength,
    this.validator,
    this.hintText,
    this.suffixIcon,
    this.textAlign,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus ?? true,
      controller: controller,
      cursorColor: Styles.deepPurpleAccent,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      maxLength: maxLength,
      validator: validator,
      textAlign: textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Styles.deepPurple.withOpacity(0.1),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.deepPurple),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent.withOpacity(0.8)),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.deepPurple),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          color: Styles.deepPurple.withOpacity(0.8),
        ),
        contentPadding: const EdgeInsets.only(left: 12, right: 12),
      ),
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
    );
  }
}
