import 'package:app_consultor/componentes/ListaPlanos.dart';

import 'package:app_consultor/controladores/ControladorPesquisaPlanos.dart';
import 'package:app_consultor/controladores/ControladorPlano.dart';
import 'package:flutter/material.dart';
import 'package:app_consultor/componentes/AppBarra.dart';
import 'package:app_consultor/componentes/PesquisaBarra.dart';
import 'package:get_it/get_it.dart';

class TelaPesquisaPlanos extends StatefulWidget {
  TelaPesquisaPlanos({Key? key}) : super(key: key);

  @override
  _TelaPesquisaPlanosState createState() => _TelaPesquisaPlanosState();
}

class _TelaPesquisaPlanosState extends State<TelaPesquisaPlanos> {
  ControladorPlano _controladorPlano = GetIt.I.get<ControladorPlano>();
  ControladorPesquisaPlanos controladorPesquisaPlanos =
      ControladorPesquisaPlanos();
  final _textController = TextEditingController();
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon:
                new Icon(Icons.arrow_back_ios, color: Colors.black, size: 24)),
        backgroundColor: Colors.white,
        title: Text(
          "PLANOS",
          style: TextStyle(
              fontFamily: "NunitoSans", fontSize: 16, color: Colors.black),
        ),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: 80,
              child: PesquisaBarra(
                textController: _textController,
                onSubmitted: (text) {
                  controladorPesquisaPlanos.pesquisaPlano(
                      plano: text.toString());
                },
                onChanged: (text) {
                  controladorPesquisaPlanos.pesquisaPlano(
                      plano: text.toString());
                },
                hintText: "Busque pelo nome do plano",
              ),
            )),
      ),
      body: ListaPlanos(
        onTap: (plano) {
          _controladorPlano.plano = plano;
          Navigator.pushNamed(context, "/telaDetalhePlano");
        },
        scrollController: _scrollController,
        controlador: controladorPesquisaPlanos,
      ),
      bottomNavigationBar: AppBarra(
        iconeNavegacao: IconeNavegacao.busca,
      ),
    );
  }
}
