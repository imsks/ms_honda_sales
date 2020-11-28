import 'package:flutter/material.dart';
import 'package:ms_honda_sales/utilities/globalConstants.dart';

final AppBar globalAppBar = AppBar(
  title: Center(
    child: const Text('MS Honda'),
  ),
  actions: [
    Center(
      child: Text("Hi user"),
    ),
  ],
  backgroundColor: kBlackColor,
);
