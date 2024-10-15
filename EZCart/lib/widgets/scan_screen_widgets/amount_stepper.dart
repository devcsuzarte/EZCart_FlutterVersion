import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ezcart/constants.dart';

class AmountStepper extends StatelessWidget {
  const AmountStepper({
    super.key,
    required this.addPressed,
    required this.minusPressed,
    required this.amount,
  });

  final VoidCallback addPressed;
  final VoidCallback minusPressed;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFA8E6CF),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          offset: Offset(2, 3),
        )],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
              onPressed: addPressed,
              icon: Icon(CupertinoIcons.add_circled_solid, size: 35, color: CupertinoColors.black,),
            ),
          ),
          Text('${amount}x',
              style: kBodyTextStyle
          ),
          IconButton(
            onPressed: minusPressed,
            icon: Icon(CupertinoIcons.minus_circle_fill, size: 35, color: CupertinoColors.black,),
          ),
        ],
      ),
    );
  }
}