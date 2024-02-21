import 'package:flutter/material.dart';

class ArrowValueNotifier {
  ValueNotifier valueNotifier = ValueNotifier(0);
  void changePosition({required int value}) {
    valueNotifier.value = value;
  }
}
