import 'package:flutter/material.dart';

class ProductCell extends StatelessWidget {
  const ProductCell({
    super.key,
    required this.label,
    required this.amount,
    required this.price});

  final String label;
  final int amount;
  final String price;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: CircleAvatar(
            child: Text(
              '${amount}x',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  label,
                   softWrap: true,
                   style: TextStyle(
                    fontSize: 20.0,
                ),
              ),
              Text(
                  'Preço Unidade: R\$$price',
                   style: TextStyle(
                     fontSize: 15.0,
                     fontWeight: FontWeight.bold,
                   ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
