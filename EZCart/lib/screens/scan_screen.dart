import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ezcart/models/text_manager.dart';
import 'package:ezcart/models/product.dart';
import 'package:ezcart/models/product_data.dart';
import 'package:provider/provider.dart';
import 'package:ezcart/models/scan_manager.dart';

class ScanScreen extends StatefulWidget {

  late List<String> labelsList;
  late List<String> priceList;
  ScanScreen({required this.labelsList, required this.priceList});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final textManager = TextManager();
  final scanManager = ScanManager();
  final textLabelController = TextEditingController();
  final textPriceController = TextEditingController();

  int labelIndex = 0;
  int priceIndex = 0;
  int amount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textLabelController.text = widget.labelsList.length > 0 ? widget.labelsList[labelIndex] : "PRODUTO";
    textPriceController.text = widget.priceList.length > 0 ? widget.priceList[priceIndex] : "0,00";
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 400),
                    color: Color(0xFFFFF203),
                    child: TextField(
                      maxLines: null,
                      textAlign: TextAlign.center,
                      controller: textLabelController,
                      style: TextStyle(
                          fontSize: 25.0
                      ),
                      decoration: InputDecoration(
                          hintText: 'PRODUTO',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
            ),
            Flexible(
              child: Container(
                color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              priceIndex < widget.priceList.length - 1 ? priceIndex++ : priceIndex = 0;
                                              textPriceController.text = widget.priceList[priceIndex];
                                            },
                                            icon: Icon(
                                              CupertinoIcons.refresh_bold,
                                              color: CupertinoColors.systemGreen,
                                              size: 45,
                                            ),
                                        ),
                                    ),
                                    Expanded(child: Text(
                                      'R\$',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 40.0
                                        ),
                                        controller: textPriceController,
                                        decoration: InputDecoration(
                                          hintText: "00,00",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            ),
                          ],
                        ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                amount++;
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                          Text(' ${amount}x:',
                            style: TextStyle(
                                fontSize: 20.0
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                amount > 1 ? amount-- : amount = 1;
                              });
                            },
                            icon: Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: MaterialButton(
                color: CupertinoColors.systemGreen,
                onPressed: () {
                  var newProduct = Product(amount: amount, labelPrice:  textPriceController.text, labelTitle:  textLabelController.text);
                  Provider.of<ProductData>(context, listen: false).addProduct(newProduct);
                  Navigator.pop(context);
                },
                child: Text('Adicionar Item'),
              ),
            ),
          ],
    );
  }
}
