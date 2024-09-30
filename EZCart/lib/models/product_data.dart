import 'package:flutter/widgets.dart';
import 'package:ezcart/database.dart';
import 'product.dart';

class ProductData extends ChangeNotifier{

  List<Product> productsList = [];

  void addProduct(Product product) {
    productsList.add(product);
    var price = product.labelPrice!.replaceAll(',', '.');
    EZCartDB().create(title: product.labelTitle!, price: double.parse(price), amount: product.amount!);
    notifyListeners();
    print(productsList);
  }

  void showData() async{
    productsList = await EZCartDB().fetchAll;
    notifyListeners();
  }

  void getTotalCartPrice() {

  }
}