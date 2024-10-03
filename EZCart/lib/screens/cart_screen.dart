import 'package:ezcart/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'scan_screen.dart';
import 'package:ezcart/models/product_data.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductData>(context, listen: false).showData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'R\$ ${Provider.of<ProductData>(context, listen: true).totalCartPrice}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ProductData>(context, listen: false).cleanCartList();
              },
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
