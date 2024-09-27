import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ezcart/models/text_manager.dart';
import 'package:ezcart/models/product.dart';
import 'package:ezcart/models/product_data.dart';
import 'package:provider/provider.dart';

// TODO: When clicks on scan clean up possible prices
// TODO: Finish getConvertedPrice()


class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  int amount = 0;
  late String displayLabel = "";
  late String displayPrice = "";

  final textManager = TextManager();

  var labelTxtController = TextEditingController();
  var priceTxtController = TextEditingController();

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  void processScan(XFile labelImage) async{
    final inputImage = InputImage.fromFile(File(labelImage.path));
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        print("LABEL TEXT: ${line.text}");
        if(textManager.isTextValid(line.text)) {
          textManager.possibleLables.add(line.text);
        }
        if(textManager.isPriceValid(line.text)) {
          textManager.possiblePrices.add(line.text);
        }
      }
    }

    print(textManager.possibleLables);
    setState(() {
      displayLabel = textManager.possibleLables.length > 0 ? textManager.possibleLables[0] : "PRODUTO";
      labelTxtController.text = displayLabel;
    });
    print(textManager.possiblePrices);
    setState(() {
      displayPrice = textManager.possiblePrices.length > 0 ? textManager.possiblePrices[0] : "0,00";
      priceTxtController.text = textManager.getConvertedPrice(displayPrice).toString();
    });

  }

    void scanLabel() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("DEBUG - IMAGE PICKED SUCCESSFULLY");
      setState(() {
        processScan(pickedFile);
      });
    } else {
      setState(() {
        print('SOMETHING WENT WRONG');
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan'),
        actions: [
         IconButton(
           onPressed: () => scanLabel(),
           color: Colors.greenAccent,
           icon: Icon(
                 CupertinoIcons.barcode_viewfinder),
         ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                      onPressed: () => print('refresh'),
                      icon: Icon(Icons.refresh),
                      color: Colors.greenAccent,
                      iconSize: 40.0,
                  ),
                ),
                Expanded(
                  flex: 3,
                    child: SizedBox(
                ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                                'R\$',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
        
                      ),
                      Expanded(
                          flex: 2,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 40.0
                            ),
                          controller: priceTxtController,
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
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () => print('refresh'),
                    icon: Icon(Icons.refresh),
                    color: Colors.greenAccent,
                    iconSize: 40.0,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),),
                Expanded(
                  flex: 7,
                    child: TextField(
                      textAlign: TextAlign.center,
                  controller: labelTxtController,
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                    decoration: InputDecoration(
                    hintText: 'PRODUTO',
                    border: InputBorder.none
                  ),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Quantidade ${amount}x:',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                SizedBox(
                  width: 100.0,
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              amount++;
                            });
                          },
                          icon: Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            amount > 0 ? amount-- : amount = 0;
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                    ],
                  ),
                )
              ],
            ),
            MaterialButton(
              color: CupertinoColors.systemGreen,
              onPressed: () {
                var newProduct = Product(amount, displayPrice, displayLabel);
                Provider.of<ProductData>(context, listen: false).addProduct(newProduct);
                Navigator.pop(context);
              },
              child: Text('Adicionar Item'),
            )
          ],
        ),
      ),
    );
  }
}
