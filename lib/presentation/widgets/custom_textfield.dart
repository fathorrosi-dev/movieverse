import 'package:flutter/material.dart';
import 'package:movieverse/main.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final IconButton? suffixIcon;
  final bool obscureText;
  final String? errorText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.suffixIcon,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: $styles.text.bodyMedium,
      onChanged: onChanged,
      onEditingComplete:
          onEditingComplete == null ? null : () => onEditingComplete!(),
      decoration: InputDecoration(
        prefixIconColor: $styles.theme.tertiaryColor,
        labelText: label,
        labelStyle: $styles.text.labelLarge,
        hoverColor: $styles.theme.neutralColor,
        focusColor: $styles.theme.tertiaryColor,
        prefixIcon: Icon(icon),
        errorText: errorText,
        errorBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: $styles.theme.tertiaryColor, width: 1)),
        errorStyle: $styles.text.labelSmall
            .copyWith(color: $styles.theme.tertiaryColor),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: $styles.theme.tertiaryColor, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: $styles.theme.neutralColor, width: 1.0)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
