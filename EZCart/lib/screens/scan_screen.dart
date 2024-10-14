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
import 'package:ezcart/widgets/price_label.dart';

class ScanScreen extends StatefulWidget {

  late List<String> labelsList;
  late List<String> priceList;
  ScanScreen({super.key, required this.labelsList, required this.priceList});

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 400),
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          offset: Offset(1, 3),
                        )],
                        color: Color(0xFFFFF203),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {
                                  labelIndex < widget.labelsList.length - 1 ? labelIndex++ : labelIndex = 0;
                                  textLabelController.text = widget.labelsList[labelIndex];
                                },
                                icon: Icon(
                                  CupertinoIcons.refresh_bold,
                                  color: CupertinoColors.systemGreen,
                                  size: 45,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: TextField(
                                maxLines: null,
                                textAlign: TextAlign.center,
                                controller: textLabelController,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                    hintText: 'PRODUTO',
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 150),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFA8E6CF),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              offset: Offset(2, 3),
                            )],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      amount++;
                                    });
                                  },
                                  icon: Icon(CupertinoIcons.add_circled_solid, size: 35, color: CupertinoColors.black,),
                                ),
                              ),
                              Text('${amount}x',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    amount > 1 ? amount-- : amount = 1;
                                  });
                                },
                                icon: Icon(CupertinoIcons.minus_circle_fill, size: 35, color: CupertinoColors.black,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PriceLabel(
                              textPriceController: textPriceController,
                              onPressed: () {
                                priceIndex < widget.priceList.length - 1 ? priceIndex++ : priceIndex = 0;
                                textPriceController.text = widget.priceList[priceIndex];
                              },
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Expanded(
                              child: MaterialButton(
                                color: CupertinoColors.systemGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                onPressed: () {
                                  var newProduct = Product(amount: amount, labelPrice:  textPriceController.text, labelTitle:  textLabelController.text);
                                  Provider.of<ProductData>(context, listen: false).addProduct(newProduct);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                          'Adicionar Item',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      CupertinoIcons.cart_badge_plus,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
      ),
    );
  }
}
