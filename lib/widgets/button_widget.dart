import 'package:crop_analytical_system/utils/colors.dart';
import 'package:crop_analytical_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? fontSize;
  final double? height;
  final Color? color;

  const ButtonWidget(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.width = 300,
      this.fontSize = 18,
      this.height = 50,
      this.color = const Color(0xff53BA2E)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minWidth: width,
        height: height,
        color: color,
        onPressed: onPressed,
        child:
            TextRegular(text: label, fontSize: fontSize!, color: Colors.white));
  }
}
