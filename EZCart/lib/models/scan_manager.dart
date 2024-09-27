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

class ScanManager {

  ScanManager();

  String labelText = "";
  String labelPrice = "";

  var labelTxtController = TextEditingController();
  var priceTxtController = TextEditingController();


  final textManager = TextManager();
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
    labelText = textManager.possibleLables.length > 0 ? textManager.possibleLables[0] : "PRODUTO";
    labelPrice = textManager.possiblePrices.length > 0 ? textManager.possiblePrices[0] : "0,00";
    labelTxtController.text = labelText;
    priceTxtController.text = labelPrice;
  }

  void scanLabel() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("DEBUG - IMAGE PICKED SUCCESSFULLY");
        processScan(pickedFile);
    } else {
        print('SOMETHING WENT WRONG');
    }
  }

  void setTitle(String title) {
    labelTxtController.text = textManager.possibleLables[0];
  }

  void setPrice(String title) {
    labelTxtController.text = textManager.possiblePrices[0];
  }


}