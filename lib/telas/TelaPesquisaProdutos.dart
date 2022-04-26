import 'package:app_consultor/componentes/AppBarra.dart';
import 'package:app_consultor/componentes/ListaProdutos.dart';
import 'package:app_consultor/componentes/PesquisaBarra.dart';
import 'package:app_consultor/controladores/ControladorPesquisaProdutos.dart';
import 'package:app_consultor/servicos/ServicosProduto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(TelaPesquisaProdutos());

class TelaPesquisaProdutos extends StatefulWidget {
  @override
  _TelaPesquisaProdutosState createState() => _TelaPesquisaProdutosState();
}

class _TelaPesquisaProdutosState extends State<TelaPesquisaProdutos> {
  ServicosProduto servicosProdutos = ServicosProduto();
  ControladorPesquisaProdutos controladorPesquisaProdutos =
      ControladorPesquisaProdutos(diaria: false);
  var textController = TextEditingController();
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
      bottomNavigationBar: AppBarra(
        iconeNavegacao: IconeNavegacao.busca,
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24)),
        title: Text('PRODUTOS',
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 16,
            )),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: 80,
              child: PesquisaBarra(
                  textController: textController,
                  onSubmitted: (text) {
                    controladorPesquisaProdutos.pesquisaProdutos(
                        produto: textController.text);
                  },
                  onChanged: (text) {
                    controladorPesquisaProdutos.pesquisaProdutos(
                        produto: textController.text);
                  },
                  hintText: 'Busque por produto ou código'),
            )),
      ),
      body: ListaProdutos(
        scrollController: _scrollController,
        controlador: controladorPesquisaProdutos,
      ),
    );
  }
}
