import 'package:flutter/material.dart';

import 'package:app_consultor/componentes/AlunoWidget.dart';
import 'package:app_consultor/controladores/ControladorPesquisaAlunos.dart';
import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/util/EnumPesquisaEstado.dart';

// ignore: must_be_immutable
class ListaAlunos extends StatelessWidget {
  ScrollController scrollController;
  ControladorPesquisaAluno controlador;
  bool primeiraPesquisa = true;
  ValueChanged<Aluno>
      onTap; //declara um ValueChanged do tipo aluno, que ira passar o dado informado na declaração do onTap(funcionamento igual ao dos onchaged de textfields)
  ListaAlunos({
    Key? key,
    required this.scrollController,
    required this.controlador,
    required this.onTap,
  }) : super(key: key);
  double posicaoScroll = 0.0;
  //função que retorna o widget que ira aparecer na tela dependendo do estado atual da pesquisa
  gereciadorEstado(PesquisaEstado estado) {
    scrollController = ScrollController(initialScrollOffset: posicaoScroll);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          controlador.pesquisaEstado.value != PesquisaEstado.novoConteudo &&
          controlador.paginaAtual != controlador.paginasTotal + 1) {
        posicaoScroll = scrollController.position.pixels;
        controlador.carregaAlunos();
      }
    });
    switch (estado) {
      case PesquisaEstado.carregando:
        if (primeiraPesquisa) {
          controlador.pesquisaAluno();
          primeiraPesquisa = false;
        }
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 7,
          ),
        );
      case PesquisaEstado.sucesso:
        return RefreshIndicator(
          strokeWidth: 4,
          onRefresh: () {
            posicaoScroll = 0;
            return controlador.pesquisaAluno();
          },
          child: ListBuilderAlunos(
              onTap: onTap,
              scrollController: scrollController,
              controlador: controlador),
        );
      case PesquisaEstado.novoConteudo:
        return Stack(
          children: [
            ListBuilderAlunos(
                onTap: onTap,
                scrollController: scrollController,
                controlador: controlador),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 7,
                  ),
                ),
              ),
            ),
          ],
        );
      case PesquisaEstado.erro:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Não há resulados para a busca"),
              IconButton(
                  onPressed: () => controlador.pesquisaAluno(),
                  icon: Icon(Icons.refresh_outlined))
            ],
          ),
        );
      default:
        Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //widget que rebuilda somente a si mesmo assim que o valor da animation é alterado
      animation: controlador.pesquisaEstado,
      builder: (context, child) {
        return gereciadorEstado(controlador.pesquisaEstado.value);
      },
    );
  }
}

class ListBuilderAlunos extends StatelessWidget {
  final ScrollController scrollController;
  final ControladorPesquisaAluno controlador;
  final ValueChanged<Aluno> onTap;
  const ListBuilderAlunos({
    Key? key,
    required this.scrollController,
    required this.controlador,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      //lista os alunos em caso de sucesso
      itemCount: controlador.listaAluno!.length,
      itemBuilder: (BuildContext context, int index) {
        final Aluno aluno = controlador.listaAluno![index];
        return GestureDetector(
          onTap: () {
            onTap(aluno); //chama a função que passa o aluno no index atual
          },
          child: AlunoWidget(
           aluno: aluno,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
