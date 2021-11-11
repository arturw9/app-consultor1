import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/componentes/ImagemCadastro.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
                    GetIt.I.get<ControladorCarrinho>().limparCarrinho();
                    GetIt.I.get<ControladorUsuario>().logoutUsuario(
                        deslogar: () {
                      Navigator.pushReplacementNamed(context, "/telaSplash");
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                )
                // FieldNome(
                //   valorInicial: usuario.nome,
                //   onChanged: (text) {
                //     //    _usuario.nome = text;
                //   },
                // ),
                // FieldCPF(
                //   onChanged: (text) {
                //     //    _usuario.cpf = text;
                //   },
                // ),
                // FieldCelular(
                //   onChanged: (text) {
                //     //    _usuario.celular = text;
                //   },
                // ),
                // FieldEmail(
                //   onChanged: (text) {
                //     //    _usuario.email = text;
                //   },
                // ),
                // FieldDataNasc(
                //     //     onChanged: (text) {
                //     //    _usuario.dataNasc = text;
                //     //    },
                //     ),
                // FieldCEP(
                //   onChanged: (text) {
                //     //    _usuario.cep = text;
                //   },
                // ),
              ],
            ),
            //   ),
          ),
        ),
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Container(
      //       height: 100,
      //       child: Center(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             ButtonDeslogarPerfil(
      //               value: "DESLOGAR",
      //               onTap: () {
      //                 GetIt.I.get<ControladorUsuario>().logoutUsuario(
      //                     deslogar: () {
      //                   Navigator.pushReplacementNamed(context, "/telaSplash");
      //                 });
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
