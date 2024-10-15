import 'package:ezcart/widgets/cart_screen_widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ezcart/models/product_data.dart';
import 'package:provider/provider.dart';
import 'package:ezcart/widgets/cart_screen_widgets/cart_appbar.dart';
import 'package:ezcart/controller/scan_manager.dart';

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
    var scanManager = ScanManager(context: context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scanManager.scanLabel();
        },
        tooltip: "Ler etiqueta",
        child: Icon(
          CupertinoIcons.barcode_viewfinder,
          size: 50,),
      ),
      appBar: PreferredSize(
          preferredSize: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.18),
          child: CartAppbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ProductsList(),
      )
    );
  }
}