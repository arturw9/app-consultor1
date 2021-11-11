import 'package:flutter/material.dart';

class BotaoPadraoDialog extends StatelessWidget {
  final String value;
  final Function() onTap;
  const BotaoPadraoDialog({
    Key? key,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite, // width largura maxima
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        onPressed: onTap,
        child: Text(
          ("$value"),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
