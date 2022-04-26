import 'package:flutter/material.dart';

class ServicoNavegacao {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navegarPara(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
}