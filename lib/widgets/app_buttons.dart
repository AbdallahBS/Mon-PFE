import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/widgets/app_text.dart';

import '../misc/colors.dart';

class AppButtons extends StatelessWidget {
  final Color color ;
  final Color backgroundColor;
  double size;
  String? text;
  IconData? icon;
  bool? isIcon;
  final Color borderColor;
   AppButtons({super.key,
     this.isIcon = false,
     this.text="Hi",
     this.icon,
     required this.size,
    required this.color,
    required this.backgroundColor,
    required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
        border: Border.all(color: borderColor,
        width: 1.0),
      ),
      child: isIcon==false? Center(child: AppText(text: text! , color: color,)):Center(child: Icon(icon , color: color,)),
    );
  }
}
