import 'package:flutter/widgets.dart';

import 'product.dart';

class ProductData extends ChangeNotifier{

  List<Product> productsList = [
    Product(2, "05.99", "ARROZ PRETO"),
    Product(4, "015.99", "FEIJAO BRANCO"),
    Product(10, "09.99", "SUCO DE FARINHA"),
  ];

  void addProduct(Product product) {
    productsList.add(product);
    notifyListeners();
    print(productsList);
  }
}