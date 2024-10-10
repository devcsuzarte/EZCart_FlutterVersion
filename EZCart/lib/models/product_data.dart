import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:ezcart/database.dart';
import 'product.dart';

class ProductData extends ChangeNotifier{

  List<Product> productsList = [];
  double totalCartPrice = 0.0;

  void addProduct(Product product) {
    productsList.add(product);
    var price = product.labelPrice!.replaceAll(',', '.');
    EZCartDB().create(title: product.labelTitle!, price: double.parse(price), amount: product.amount!);
    showData();
    print(productsList);
  }

  void showData() async{
    productsList = await EZCartDB().fetchAll;
    setTotalCartPrice();
    notifyListeners();
  }

  void deleteProduct(int productID) {
    EZCartDB().delete(id: productID);
    showData();
  }

  void cleanCartList() {
    EZCartDB().deleteTable();
    showData();
  }


  void setTotalCartPrice() {
    var total = 0.0;
    for (Product product in productsList) {
      total = total + (double.parse(product.labelPrice!) * product.amount!);
    }
    print(total);
    totalCartPrice = total;
  }
}