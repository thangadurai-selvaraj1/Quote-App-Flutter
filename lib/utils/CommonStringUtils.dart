import 'dart:math';

import 'package:flutter/material.dart';

class CommonStringUtils {
  static String trimFirst(String text) {
    return text.split(" ").first.toUpperCase();
  }

  static Color picColors() {
    List colors = [Colors.green, Colors.yellow,Colors.blue,Colors.brown,Colors.deepPurple   ];
    return colors[getRandom()];
  }

  static getRandom(){
    return Random().nextInt(5);
  }
}
