import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ezcart/models/text_manager.dart';
import 'package:ezcart/screens/scan_screen.dart';

class ScanManager extends ChangeNotifier {

ScanManager({this.context});

  BuildContext? context;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  void processScan(XFile labelImage) async{
    final textManager = TextManager();
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
    print('CONTEXT: $context');
    showModalBottomSheet(
      context: context!,
      builder: (context) => ScanScreen(labelsList: textManager.possibleLables, priceList: textManager.possiblePrices,),
      enableDrag: true,
      showDragHandle: true,
    );
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
}