import 'package:flutter/material.dart';

class BoxStyles {
  static final BoxDecoration gradientBox = BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Colors.indigo, Colors.blue]));
}
