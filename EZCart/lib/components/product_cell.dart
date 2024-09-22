import 'package:flutter/material.dart';

class ProductCell extends StatelessWidget {
  const ProductCell({
    super.key,
    required this.label,
    required this.amount,
    required this.price});

  final String label;
  final int amount;
  final double price;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${amount}x ${label}',
               style: TextStyle(
                fontSize: 20.0,
            ),
          ),
          Text(
              'Preço Unidade: ${price.toStringAsFixed(2)}',
               style: TextStyle(
                 fontSize: 15.0,
                 fontWeight: FontWeight.bold,
               ),
          ),
        ],
      ),
    );
  }
}
