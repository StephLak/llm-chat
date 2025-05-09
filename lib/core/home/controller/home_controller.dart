import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worklyn_task/core/chat/view/chat_screen.dart';

class HomeController extends GetxController {
  // Tab Index
  final tabIndex = 0.obs;

  // Change Tab Index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  List<Widget> screens = [ChatScreen(), Container(), Container()];
}
