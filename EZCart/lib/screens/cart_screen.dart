import 'package:ezcart/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'scan_screen.dart';
import 'package:ezcart/widgets//product_cell.dart';
import 'package:ezcart/models/product_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EZCart'),
        actions: [
          IconButton(
              onPressed: () => print('cleanup'),
              icon: Icon(
                Icons.clear,
                color: Colors.greenAccent,
              ),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanScreen())),
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
      body: ProductsList()
    );
  }
}
