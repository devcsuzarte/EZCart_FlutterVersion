import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_data.dart';


void cupertinoDialog(BuildContext context) {
  showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Deseja limpar o carrinho?'),
      content: Text('Todos os itens serão deletados'),
      actions: <CupertinoDialogAction> [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Sim'),
          onPressed: () {
            Provider.of<ProductData>(context, listen: false).cleanCartList();
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text('Não'),
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
          title: Text('Deseja limpar o carrinho?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
                Text('Todos os itens serão deletados'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Provider.of<ProductData>(context, listen: false).cleanCartList();
                Navigator.pop(context);
              },
                child: Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
                child: Text('Não'),
            ),
          ],
        );
      }
    );
  }
