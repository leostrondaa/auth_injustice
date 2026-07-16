import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool showError;

  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.showError = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // O parâmetro inválido 'showError' foi removido daqui de dentro!
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: showError ? validator : null, // A lógica continua ativa aqui
      onChanged: onChanged,
      cursorColor: context.colors.onPrimary,
      style: TextStyle(
        color: context.colors.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: context.colors.onSurface),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: context.colors.primary.withValues(alpha: 0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.onPrimary.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.onPrimary.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.onPrimary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
