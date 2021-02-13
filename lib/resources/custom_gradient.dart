import 'package:flutter/material.dart';

class CustomGradient extends LinearGradient {
  static const List<Color> color123 = [
    const Color(0xFF0D47A1),
    const Color(0xFF1976D2),
  ];

  const CustomGradient() : super(colors: color123);
}