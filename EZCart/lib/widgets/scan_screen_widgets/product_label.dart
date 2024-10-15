import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ezcart/constants.dart';

class ProductLabel extends StatelessWidget {
  const ProductLabel({
    super.key,
    required this.textLabelController,
    required this.onPressed,
  });

  final TextEditingController textLabelController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        constraints: BoxConstraints(maxHeight: 400),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: Offset(1, 3),
          )],
          color: kProductLabelColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    CupertinoIcons.refresh_bold,
                    color: kSecondaryColor,
                    size: 45,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: TextField(
                    maxLines: null,
                    textAlign: TextAlign.center,
                    controller: textLabelController,
                    style: kProductLabelTextFieldStyle,
                    decoration: kProductLabelTextFieldDecoration
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}