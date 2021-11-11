import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/componentes/TextFieldLoginPadrao.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

//tela de login do usuario
class TelaLogin extends StatefulWidget {
  TelaLogin({Key? key}) : super(key: key);
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<
      ControladorUsuario>(); //chama a instancia do GetIt do controlador do usuario

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
                    SvgPicture.asset(
                      "assets/images/pactoLogoWhite.svg",
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Olá, bem-vindo!",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'NunitoSansBold'),
                    ),
                    Text(
                      "Faça login para continuar",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NunitoSans'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                    ),
                    FieldLoginUsuario(
                      onChanged: (text) {
                        _controladorUsuario.usuario.email = text;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                    ),
                    FieldLoginSenha(
                      onChanged: (text) {
                        _controladorUsuario.usuario.senha = text;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                    ),
                    ButtonLogin(
                      value: "LOGIN",
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
                      padding: EdgeInsets.only(bottom: 25),
                    ),
                    // UTILIZAR NA PRÓXIMA VERSAO
                    // ButtonLoginEntrarCelular(
                    //   value: "ENTRAR COM CELULAR",
                    //   onTap: () {
                    //     UtilCarregamento.exibirCarregamento(context);
                    //     Navigator.pushReplacementNamed(
                    //         context, "/telaLoginCelular");
                    //   },
                    // ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 79),
                    ),
                    Text(
                      "V.0.1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
