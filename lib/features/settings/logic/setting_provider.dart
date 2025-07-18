import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localizationProvider = StateProvider((ref) {
  return const Locale('en');
});

final themeModeProvider = StateProvider((ref) {
  return ThemeMode.light;
});
