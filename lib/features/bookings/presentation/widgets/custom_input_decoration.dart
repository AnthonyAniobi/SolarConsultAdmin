import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomInputDecoration {
  static InputDecoration basic(String label) => InputDecoration(
      label: Text(label),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: const BorderSide(
            color: Colors.blueAccent,
          )));
}
