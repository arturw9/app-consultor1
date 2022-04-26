import 'package:app_consultor/componentes/AppBarra.dart';
import 'package:app_consultor/componentes/CartaoInicio.dart';
import 'package:app_consultor/componentes/PerfilBarra.dart';
import 'package:flutter/material.dart';

//tela de homePage que carrega os cards de navegação
class TelaInicio extends StatefulWidget {
  TelaInicio({Key? key}) : super(key: key);

  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 74,
        flexibleSpace: PerfilBarra(),
      ),
      bottomNavigationBar: AppBarra(iconeNavegacao: IconeNavegacao.home),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              spacing: 20,
              runSpacing: 16,
              children: [
                //chama os componentes de card do inicio
                CartaoInicio(
                  child: ConteudoBuscarAluno(),
                ),
                CartaoInicio(
                  child: ConteudoCadastro(),
                ),
                CartaoInicio(
                  child: ConteudoVendasPlanos(),
                ),
                CartaoInicio(
                  child: ConteudoVendasProdutos(),
                ),
                CartaoInicio(
                  child: ConteudoLancarDiaria(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.pushReplacementNamed(context, "/telaChat");
        },
        label: const Text('Chat'),
        icon: const Icon(Icons.chat_sharp),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
