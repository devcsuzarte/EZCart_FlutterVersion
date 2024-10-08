import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ezcart/models/product_data.dart';
import 'package:provider/provider.dart';

class CartAppbar extends StatelessWidget {
  const CartAppbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 70.0, bottom: 20.0, right: 25.0, left: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.cart,
                          size: 40,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          'R\$${Provider.of<ProductData>(context, listen: true).totalCartPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            RawMaterialButton(
              child: Icon(
                CupertinoIcons.trash_fill,
                color: CupertinoColors.destructiveRed,
              ),
              constraints: BoxConstraints.tightFor(
                width: 48.0,
                height: 48.0,
              ),
              shape: CircleBorder(),
              fillColor: Colors.white,
              onPressed: () => Provider.of<ProductData>(context, listen: false).cleanCartList(),
            ),
          ],
        ),
      ),
    );
  }
}
