import 'package:flutter/material.dart';

class AppText extends StatelessWidget {

  double  size;
  final String text;
  final Color color;
  final TextAlign textAlign;
  AppText({Key ? key ,
    this.size = 16,
    this.textAlign = TextAlign.left, // Default alignment

    required this.text,
    this.color = Colors.black54}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style : TextStyle(
        color : color,
        fontSize : size,
      ),
      textAlign: textAlign, // Apply textAlign

    );
  }
}
