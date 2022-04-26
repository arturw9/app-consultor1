import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  Widget cancelaButton = ElevatedButton(
    child: Text("Cancelar"),
    onPressed: () {},
  );
  Widget continuaButton = ElevatedButton(
    child: Text("Continar"),
    onPressed: () {},
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Autenticar"),
    content: Text("Digite sua senha para confirmar recebindo via dinheiro."),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
