import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ezcart/models/text_manager.dart';

// TODO: Create Refresh Functions


class ScanManager {

 // ScanManager();

  String labelText = "";
  String labelPrice = "";
  var labelTxtController = TextEditingController();
  var priceTxtController = TextEditingController();

  int titleIndex = 0;
  int priceIndex = 0;


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
    labelText = textManager.possibleLables.length > 0 ? textManager.possibleLables[titleIndex] : "PRODUTO";
    labelPrice = textManager.possiblePrices.length > 0 ? textManager.possiblePrices[priceIndex] : "0,00";
    labelTxtController.text = labelText;
    priceTxtController.text = labelPrice;
  }

  void scanLabel() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        processScan(pickedFile);
    } else {
        print('SOMETHING WENT WRONG');
    }
  }

  void refreshTitle() {
    titleIndex < textManager.possibleLables.length - 1 ? titleIndex++ : titleIndex = 0;
    labelTxtController.text = textManager.possibleLables[titleIndex];
  }

  void refreshPrice() {
    priceIndex < textManager.possiblePrices.length - 1 ? priceIndex++ : priceIndex = 0;
    priceTxtController.text = textManager.possiblePrices[priceIndex];
  }
}