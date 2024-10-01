import 'package:flutter/material.dart';
import 'package:ezcart/models/product_data.dart';
import 'product_cell.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductData>(
        builder: (context, productData, child) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final product = productData.productsList[index];
                return GestureDetector(
                  onLongPress: () {
                    Provider.of<ProductData>(context, listen: false).deleteProduct(product.id!);
                    print(product.id);
                  },
                  child: ProductCell(
                      label: product.labelTitle!,
                      amount: product.amount!,
                      price: product.labelPrice!
                  ),
                );
              },
            itemCount: Provider.of<ProductData>(context, listen: false).productsList.length,
          );
        }
    );
  }
}
