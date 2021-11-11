import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/componentes/TextFieldLoginPadrao.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaLoginCelular extends StatefulWidget {
  TelaLoginCelular({Key? key}) : super(key: key);

  @override
  _TelaLoginCelularState createState() => _TelaLoginCelularState();
}

class _TelaLoginCelularState extends State<TelaLoginCelular> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF026ABC),
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "Insira seu número de celular com DDD",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NunitoSansBold'),
                    ),
                    Text(
                      "que enviaremos um sms com o código.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NunitoSansBold'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 59),
                    ),
                    FieldLoginCelular(
                      onChanged: (text) {
                        _controladorUsuario.usuario.email = text;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 54),
                    ),
                    Text(
                      "Adicionando seu número de celular você concorda em receber",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'NunitoSans',
                      ),
                    ),
                    Text(
                      "um sms. Pode haver cobrança de taxas de envio de mensagens",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'NunitoSans',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 106),
                    ),
                    ButtonEnviarCelular(
                      value: "ENVIAR",
                      onTap: () {
                        UtilCarregamento.exibirCarregamento(context);

                        Navigator.pushReplacementNamed(
                            context, "/telaLoginCodigoCelular");
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/telaLogin");
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "NunitoSans",
                              fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
