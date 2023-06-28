import 'package:cyberwatch/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? fontSize;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? radius;

  const ButtonWidget(
      {Key? key,
      this.radius = 5,
      this.textColor = Colors.white,
      required this.label,
      required this.onPressed,
      this.width = 300,
      this.fontSize = 18,
      this.height = 50,
      this.color = const Color(0xff0579cc)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!)),
        minWidth: width,
        height: height,
        color: color,
        onPressed: onPressed,
        child:
            TextRegular(text: label, fontSize: fontSize!, color: textColor!));
  }
}
