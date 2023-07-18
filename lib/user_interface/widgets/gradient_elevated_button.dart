import 'package:atb_flutter_demo/resources/styles.dart';
import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  final String text;
  final BorderRadius? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  const GradientElevatedButton({
    Key? key,
    required this.text,
    this.textStyle = AppTextStyles.elevatedButton,
    required this.onPressed,
    this.borderRadius,
    this.height = 50.0,
    this.width,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(14);
    return Container(
      width: width ?? 180,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
