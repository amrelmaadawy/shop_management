import 'package:flutter/material.dart';
import 'package:small_managements/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.prefixIcon,
    required this.labelText,
    required this.validator,
    this.suffixIcon,
    this.focusNode,
    this.onChange,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final String? Function(String?) validator;
  final void Function(String)? onChange;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onChanged: onChange,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.kUnselectedItemDarkMode),
      cursorColor: AppColors.kUnselectedItemDarkMode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: const TextStyle(
          color:  AppColors.kUnselectedItemDarkMode,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: AppColors.kGreyElevatedButtonDarkMode,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color:  AppColors.kUnselectedItemDarkMode),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color:  AppColors.kUnselectedItemDarkMode),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.kUnselectedItemDarkMode),
        ),
      ),
    );
  }
}
