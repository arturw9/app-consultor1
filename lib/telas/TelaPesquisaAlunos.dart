import 'package:app_consultor/componentes/AppBarra.dart';
import 'package:app_consultor/componentes/ListaAlunos.dart';
import 'package:app_consultor/componentes/PesquisaBarra.dart';
import 'package:app_consultor/controladores/ControladorAluno.dart';
import 'package:app_consultor/controladores/ControladorPesquisaAlunos.dart';
import 'package:app_consultor/telas/TelaPerfilAluno.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

class TelaPesquisaAlunos extends StatefulWidget {
  TelaPesquisaAlunos({Key? key}) : super(key: key);

  @override
  _TelaPesquisaAlunosState createState() => _TelaPesquisaAlunosState();
}

class _TelaPesquisaAlunosState extends State<TelaPesquisaAlunos> {
  ControladorAluno _aluno = GetIt.I.get<
      ControladorAluno>(); //controlador de aluno que salva o aluno e passa para outras telas
  ControladorPesquisaAluno controladorPesquisaAluno =
      ControladorPesquisaAluno(); //controlador da pesquisa do aluno
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
        title: Text("ALUNOS",
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
                textController: _textController,
                onSubmitted: (text) {
                  controladorPesquisaAluno.pesquisaAluno(
                      aluno: text.toString());
                },
                onChanged: (text) {
                  controladorPesquisaAluno.pesquisaAluno(
                      aluno: text.toString());
                },
                hintText: "Busque por nome ou CPF",
              ),
            )),
      ),
      body: ListaAlunos(
        //o compente realiza a listagem de alunos no body da pagina
        scrollController: _scrollController,
        controlador: controladorPesquisaAluno,
        onTap: (aluno) {
          _aluno.obterAluno(
            aluno.codigo!,
            sucesso: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TelaPerfilAluno()));
            },
            erro: (mensagem) {
              Navigator.pop(context);
              UtilDialog.exibirInformacoes(context,
                  mensagem: "Erro ao obter aluno", titulo: "Ops!");
            },
          );

          UtilCarregamento.exibirCarregamento(context);
        },
      ),
      bottomNavigationBar: AppBarra(iconeNavegacao: IconeNavegacao.busca),
    );
  }
}
