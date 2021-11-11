import 'dart:ui';
import 'package:app_consultor/util/BotaoPadraoDialog.dart';
import 'package:flutter/material.dart';

class UtilDialog {
  static void exibirInformacoes(BuildContext context,
      {String? titulo, String? mensagem}) {
    showDialog(
      // traz um diálogo em cima da tela
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Center(
            child: Card(
                margin: EdgeInsets.all(24),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "$titulo",
                        style: TextStyle(fontSize: 16),
                      ),
                      Divider(),
                      Text("$mensagem"),
                      SizedBox(
                        height: 16,
                      ),
                      BotaoPadraoDialog(
                        value: "Ok, entendido!",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
