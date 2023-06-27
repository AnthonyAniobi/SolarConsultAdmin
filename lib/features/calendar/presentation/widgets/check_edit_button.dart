import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CheckEditButton extends StatelessWidget {
  const CheckEditButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });
  final String text;
  final Function onPressed;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            vertical: 0.5.w,
            horizontal: 1.w,
          ),
          height: 7.h,
          decoration: BoxDecoration(
              color: enabled ? Colors.green : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.w),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 2),
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                )
              ]),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: enabled ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
