import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/product_data_manager.dart';
import 'package:ezcart/constants.dart';


void cupertinoDialog(BuildContext context) {
  showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
      title: kDialogTitleText,
      content: kDialogContentText,
      actions: <CupertinoDialogAction> [
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: kDialogActionDefaultText,
          onPressed: () {
            Provider.of<ProductData>(context, listen: false).cleanCartList();
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: kDialogActionDismissText,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
   );
  }

  Future<void> materialDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: kDialogTitleText,
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
                kDialogTitleText,
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Provider.of<ProductData>(context, listen: false).cleanCartList();
                Navigator.pop(context);
              },
                child: kDialogActionDefaultText,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
                child: kDialogActionDismissText,
            ),
          ],
        );
      }
    );
  }
