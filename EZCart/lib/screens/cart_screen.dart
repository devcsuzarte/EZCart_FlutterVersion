import 'package:ezcart/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'scan_screen.dart';
import 'package:ezcart/models/product_data.dart';
import 'package:provider/provider.dart';
import 'package:ezcart/widgets/cart_appbar.dart';
import 'package:ezcart/models/scan_manager.dart';

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
      body: ProductsList()
    );
  }
}


// return Scaffold(
// appBar: AppBar(
// title: Text(
// 'R\$ ${Provider.of<ProductData>(context, listen: true).totalCartPrice.toStringAsFixed(2)}',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// ),
// ),
// actions: [
// IconButton(
// onPressed: () {
// Provider.of<ProductData>(context, listen: false).cleanCartList();
// },
// icon: Icon(
// Icons.clear,
// color: Colors.greenAccent,
// ),
// ),
// IconButton(
// onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanScreen())),
// icon: Icon(
// CupertinoIcons.cart_badge_plus,
// color: Colors.greenAccent,
// ),
// ),
// ],
// ),
// body: ProductsList()
// );
// AppBar(
// title: Text(
// 'Meu Carrinho',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// ),
// ),
// toolbarHeight: 120,
// flexibleSpace: Container(
// child: Column(
// children: [
// Text("Total: 35.90"),
// Text("7 itens"),
// ],
// ),
// ),
// actions: [
// IconButton(
// onPressed: () {
// Provider.of<ProductData>(context, listen: false).cleanCartList();
// },
// icon: Icon(
// Icons.clear,
// color: Colors.greenAccent,
// ),
// ),
// ],
// ),