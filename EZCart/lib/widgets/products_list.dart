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
          return ListView.separated(
            itemBuilder: (context, index) {
                final product = productData.productsList[index];
                return Dismissible(
                  key: Key(product.id!.toString()),
                  onDismissed: (direction) {
                    Provider.of<ProductData>(context, listen: false).deleteProduct(product.id!);
                  },
                  background: Container(
                    color: Colors.red, // Background color when swiped
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Icon(Icons.delete, color: Colors.white,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: Icon(Icons.delete, color: Colors.white,),
                        ),
                      ],
                    ), // Icon to indicate delete action
                  ),
                  child: ProductCell(
                      label: product.labelTitle!,
                      amount: product.amount!,
                      price: product.labelPrice!
                  ),
                );
              },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: Provider.of<ProductData>(context, listen: false).productsList.length,
          );
        }
    );
  }
}
