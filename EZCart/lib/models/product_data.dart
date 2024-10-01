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
    notifyListeners();
  }

  void deleteProduct(int productID) {
    EZCartDB().delete(id: productID);
    showData();
  }

  void getTotalCartPrice() {
    for (Product product in productsList) {
      totalCartPrice = totalCartPrice + double.parse(product.labelPrice!);
    }
    print(totalCartPrice);
  }
}