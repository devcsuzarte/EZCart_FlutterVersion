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

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  void processScan(XFile labelImage) async{
    final inputImage = InputImage.fromFile(File(labelImage.path));
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        print(line.text);
      }
    }
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

  int amount = 0;
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
                          decoration: InputDecoration(
                          hintText: '00,00',
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
          ],
        ),
      ),
    );
  }
}
