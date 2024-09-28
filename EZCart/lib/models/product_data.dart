import 'package:flutter/widgets.dart';
import 'package:ezcart/database.dart';
import 'product.dart';

class ProductData extends ChangeNotifier{

  List<Product> productsList = [
    Product(2, "05.99", "ARROZ PRETO"),
    Product(4, "015.99", "FEIJAO BRANCO"),
    Product(10, "09.99", "SUCO DE FARINHA"),
  ];



  void addProduct(Product product) {
    productsList.add(product);
    var price = product.labelPrice.replaceAll(',', '.');
    EZCartDB().create(title: product.labelTitle, price: double.parse(price), amount: product.amount);
    notifyListeners();
    print(productsList);
  }

  void getTotalCartPrice() {

  }
}