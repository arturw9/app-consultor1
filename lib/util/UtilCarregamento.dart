import 'dart:ui';

import 'package:flutter/material.dart';

class UtilCarregamento {
  static void exibirCarregamento(BuildContext context,
      {String? titulo, String? mensagem}) {
    showDialog(
      // traz um diálogo em cima da tela
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                strokeWidth: 7,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
