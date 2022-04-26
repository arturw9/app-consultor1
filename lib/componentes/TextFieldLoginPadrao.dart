import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class FieldLoginUsuario extends StatelessWidget {
  final Function(String text) onChanged;
  const FieldLoginUsuario({Key? key, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'NunitoSans',
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(25, 10, 25, 10),
        prefixIcon: Icon(Icons.person_outline_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: 'Usuário',
        labelStyle: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSansBold',
        ),
      ),
    );
  }
}

class FieldLoginCelular extends StatelessWidget {
  final Function(String text) onChanged;
  const FieldLoginCelular({Key? key, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'NunitoSans',
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(25, 10, 25, 10),
        prefixIcon: Icon(
          Icons.add_call,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: '62 99000-0000',
        labelStyle: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSansBold',
        ),
      ),
    );
  }
}

class FieldLoginSenha extends StatefulWidget {
  final Function(String text) onChanged;
  const FieldLoginSenha({Key? key, required this.onChanged}) : super(key: key);

  @override
  _FieldLoginSenhaState createState() => _FieldLoginSenhaState();
}

class _FieldLoginSenhaState extends State<FieldLoginSenha> {
  bool _visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscureText: _visiblePassword,
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'NunitoSans',
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(25, 10, 25, 10),
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: InkWell(
            onTap: _togglePassowordView,
            child: Icon(_visiblePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: 'Senha',
        labelStyle: TextStyle(
          fontSize: 18,
          fontFamily: 'NunitoSansBold',
        ),
      ),
    );
  }

  void _togglePassowordView() {
    setState(() {
      _visiblePassword = !_visiblePassword;
    });
  }
}

class FieldLancarDesconto extends StatelessWidget {
  final Function(String text) onChanged;
  const FieldLancarDesconto({Key? key, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(
          locale: 'pt',
          decimalDigits: 2,
          symbol: r'R$ ',
        ),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: Icon(Icons.add_task_rounded),
      ),
    );
  }
}
