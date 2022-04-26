import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/componentes/ImagemCadastro.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorLancarDiaria.dart';
import 'package:app_consultor/controladores/ControladorPagamento.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'TelaSplash.dart';

class TelaPerfil extends StatefulWidget {
  TelaPerfil({Key? key}) : super(key: key);

  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  Usuario usuario = GetIt.I.get<ControladorUsuario>().usuario;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PERFIL",
          style: TextStyle(fontSize: 16, fontFamily: 'NunitoSans'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            // child: Form(
            child: Column(
              children: [
                ImagemPerfil(
                  imageUri: usuario.urlFoto,
                ),
                Text(
                  " ${usuario.nome}",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF6F747B),
                  ),
                ),
                SizedBox(height: 25),
                ButtonDeslogarPerfil(
                  value: "DESLOGAR",
                  onTap: () {
                    GetIt.I.get<ControladorUsuario>().logoutUsuario(
                        deslogar: () {
                      limparGetIt();
                      Navigator.of(context).pushAndRemoveUntil(
                          //retira as telas anteriores
                          MaterialPageRoute(builder: (context) => TelaSplash()),
                          (Route<dynamic> route) => false);
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
            //   ),
          ),
        ),
      ),
    );
  }

  void limparGetIt() {
    GetIt.I.unregister<ControladorLancarDiaria>();
    GetIt.I.registerLazySingleton<ControladorLancarDiaria>(
        () => ControladorLancarDiaria());
    GetIt.I.unregister<ControladorCarrinho>();
    GetIt.I.registerLazySingleton<ControladorCarrinho>(
        () => ControladorCarrinho());
    GetIt.I.unregister<ControladorPagamento>();
    GetIt.I.registerLazySingleton<ControladorPagamento>(
        () => ControladorPagamento());
  }
}
