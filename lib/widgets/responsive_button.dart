import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/misc/colors.dart';
import 'package:learn/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  final bool? isResponsive;
  final double? width;
  final double? height;
  final String? text; // Add a text property

  ResponsiveButton({
    super.key,
    this.height=60,
    this.width = null,
    this.isResponsive = false,
    this.text, // Initialize text property
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Expanded(
        child: Container(
          width: isResponsive == true ? double.maxFinite : width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal,
          ),
          child: Row(
            mainAxisAlignment: isResponsive == true
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              // Display text if provided
              if (text != null)
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Expanded(child: AppText(text: text!, color: Colors.white)),
                ),
        
            ],
          ),
        ),
      ),
    );
  }
}
