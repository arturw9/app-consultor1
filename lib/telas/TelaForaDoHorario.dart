import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaForaDoHorario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0XFF026ABC),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Você esta fora do horario de acesso",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'NunitoSansBold'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Gostaria de relogar?",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'NunitoSans'),
              ),
              IconButton(
                onPressed: () {
                  GetIt.I.get<ControladorUsuario>().estaDentroDoHorario(
                      foraHorario: () {
                    UtilDialog.exibirInformacoes(context,
                        titulo: "Ops!",
                        mensagem:
                            "Você ainda esta fora de seu horario de acesso, tente relogar mais tarde");
                  }, dentroHorario: (() {
                    GetIt.I.get<ControladorUsuario>().listarUrl(
                        erro: (erro) => null,
                        sucesso: () {
                          Navigator.pushReplacementNamed(
                              context, "/telaInicio");
                        });
                  }));
                },
                icon: Icon(Icons.refresh),
                color: Colors.white,
                iconSize: 60,
              ),
              TextButton(
                  child: Text(
                    "Voltar para tela de login",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    GetIt.I.get<ControladorUsuario>().logoutUsuario();
                    Navigator.pushReplacementNamed(context, "/telaLogin");
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
