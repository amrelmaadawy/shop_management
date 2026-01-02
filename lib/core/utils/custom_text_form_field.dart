import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.inputFormatters,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final String? Function(String?) validator;
  final void Function(String)? onChange;
  final FocusNode? focusNode;
 final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
       inputFormatters:inputFormatters,
      focusNode: focusNode,
      onChanged: onChange,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style:  TextStyle(color:isDark? AppColors.kUnselectedItemDarkMode:AppColors.kUnselectedItemLightMode),
      cursorColor: isDark? AppColors.kUnselectedItemDarkMode:AppColors.kUnselectedItemLightMode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle:  TextStyle(
          color:  isDark? AppColors.kUnselectedItemDarkMode:AppColors.kUnselectedItemLightMode,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor:isDark? AppColors.kGreyElevatedButtonDarkMode:AppColors.kGreyElevatedButtonLightMode,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color:  isDark? AppColors.kUnselectedItemDarkMode:AppColors.kUnselectedItemLightMode),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: isDark? AppColors.kUnselectedItemDarkMode:AppColors.kUnselectedItemLightMode),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: isDark? AppColors.kUnselectedItemDarkMode:AppColors.kUnselectedItemLightMode),
        ),
      ),
    );
  }
}
