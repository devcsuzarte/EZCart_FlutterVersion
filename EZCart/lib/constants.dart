import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// COLORS

const kProductLabelColor = Color(0xFFFFF203);
const kPrimaryColor = Color(0xFFA8E6CF);
const kSecondaryColor = CupertinoColors.systemGreen;

const kDialogTitleText = Text('Deseja limpar o carrinho?');
const kDialogContentText = Text('Deseja limpar o carrinho?');
const kDialogActionDefaultText = Text('Sim');
const kDialogActionDismissText = Text('Não');

const kBodyTextStyle = TextStyle(
  fontSize: 20.0,
);
const kBodyWhiteTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
);

const kProductLabelTextFieldStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.w600,
);

const kProductLabelTextFieldDecoration = InputDecoration(
    hintText: 'PRODUTO',
    border: InputBorder.none
);