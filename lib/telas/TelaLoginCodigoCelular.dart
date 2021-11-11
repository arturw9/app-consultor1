import 'dart:ui';
import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get_it/get_it.dart';

class TelaLoginCodigoCelular extends StatefulWidget {
  TelaLoginCodigoCelular({Key? key}) : super(key: key);

  @override
  _TelaLoginCodigoCelularState createState() => _TelaLoginCodigoCelularState();
}

class _TelaLoginCodigoCelularState extends State<TelaLoginCodigoCelular> {
  @override
  Widget build(BuildContext context) {
    ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
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
                      "Insira o código de 6 dígitos enviado",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NunitoSansBold'),
                    ),
                    Text(
                      "para o número 62 99000-000 ",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NunitoSansBold'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 59),
                    ),
                    VerificationCode(
                      textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                      underlineColor: Colors.white,
                      keyboardType: TextInputType.number,
                      length: 6,
                      onCompleted: (String value) {
                        setState(() {
                          //        _code = value;
                        });
                      },
                      onEditing: (bool value) {
                        setState(() {
                          //      _onEditing = value;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 54),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 5,
                                  sigmaY: 5,
                                ),
                                child: Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 28.0),
                                        child: Text("Reenviar código para:",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'NunitoSans',
                                            )),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text("62 99000-0000",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            fontFamily: 'NunitoSans',
                                          )),
                                      SizedBox(
                                        height: 36,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ButtonLoginReenviarCodigoCelular(
                                            value: "SIM",
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ButtonLoginReenviarCodigoCelular(
                                            value: "CANCELAR",
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text("Não recebi o código",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'NunitoSans')),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Entrar com login e senha",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'NunitoSans')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                    ),
                    ButtonLoginEntrarCodigoCelular(
                      value: "ENTRAR",
                      onTap: () {
                        UtilCarregamento.exibirCarregamento(context);
                        _controladorUsuario.logarUsuario(
                          sucesso: () {
                            Navigator.pushReplacementNamed(
                                context, "/telaUnidades");
                          },
                          erro: (mensagem) {
                            Navigator.pop(context);
                            UtilDialog.exibirInformacoes(context,
                                titulo: "Ops!", mensagem: mensagem);
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, "/telaLoginCelular");
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
