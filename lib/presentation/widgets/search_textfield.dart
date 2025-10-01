import 'package:flutter/material.dart';
import 'package:movieverse/main.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final IconButton? suffixIcon;
  final bool obscureText;
  final Function(String)? onChanged;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.icon,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: $styles.text.bodyMedium,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        prefixIconColor: $styles.theme.tertiaryColor,
        hintText: 'Search for a movie or tv show...',
        hintStyle:
            $styles.text.bodyMedium.copyWith(color: $styles.theme.neutralColor),
        hoverColor: $styles.theme.neutralColor,
        focusColor: $styles.theme.tertiaryColor,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: $styles.theme.tertiaryColor, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: $styles.theme.tertiaryColor, width: 1.0)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
