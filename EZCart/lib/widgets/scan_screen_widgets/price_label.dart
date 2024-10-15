import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PriceLabel extends StatelessWidget {
  const PriceLabel({
    super.key,
    required this.textPriceController,
    required this.onPressed,
  });

  final TextEditingController textPriceController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFA8E6CF),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          offset: Offset(1,2),
        )],
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                CupertinoIcons.refresh_bold,
                color: CupertinoColors.systemGreen,
                size: 45,
              ),
            ),
          ),
          Expanded(child: Text(
            'R\$',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              style: TextStyle(
                  fontSize: 40.0
              ),
              controller: textPriceController,
              decoration: InputDecoration(
                hintText: "00,00",
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}