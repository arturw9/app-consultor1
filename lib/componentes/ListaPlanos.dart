import 'package:flutter/material.dart';

import 'package:app_consultor/controladores/ControladorPesquisaPlanos.dart';
import 'package:app_consultor/modelos/Plano.dart';
import 'package:app_consultor/util/EnumPesquisaEstado.dart';

// ignore: must_be_immutable
class ListaPlanos extends StatelessWidget {
  ScrollController scrollController;
  ControladorPesquisaPlanos controlador;
  ValueChanged<Plano> onTap;
  ListaPlanos({
    Key? key,
    required this.scrollController,
    required this.controlador,
    required this.onTap,
  }) : super(key: key);
  double posicaoScroll = 0.0;

  gereciadorEstado(PesquisaEstado estado) {
    scrollController = ScrollController(initialScrollOffset: posicaoScroll);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          controlador.pesquisaEstado.value != PesquisaEstado.novoConteudo &&
          controlador.paginaAtual != controlador.paginasTotal + 1) {
        posicaoScroll = scrollController.position.pixels;
        controlador.carregaPlanos();
      }
    });
    switch (estado) {
      case PesquisaEstado.carregarConteudo:
         controlador.pesquisaPlano();
         
        return   Center(
          child: CircularProgressIndicator(
            strokeWidth: 7,
          ),
        );
      case PesquisaEstado.carregando:
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
            return controlador.pesquisaPlano();
          },
          child: ListBuilderPlanos(
              onTap: onTap,
              scrollController: scrollController,
              controlador: controlador),
        );
      case PesquisaEstado.novoConteudo:
        return Stack(
          children: [
            ListBuilderPlanos(
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
                  onPressed: () => controlador.pesquisaPlano(),
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
      animation: controlador.pesquisaEstado,
      builder: (context, child) {
        return gereciadorEstado(controlador.pesquisaEstado.value);
      },
    );
  }
}

class ListBuilderPlanos extends StatelessWidget {
  final ScrollController scrollController;
  final ControladorPesquisaPlanos controlador;
  final ValueChanged<Plano> onTap;
  const ListBuilderPlanos({
    Key? key,
    required this.scrollController,
    required this.controlador,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        controller: scrollController,
        itemCount: controlador.listaPlano!.length,
        itemBuilder: (context, index) {
          final Plano plano = controlador.listaPlano![index];
          return GestureDetector(
            onTap: () {
              onTap(plano);
            },
            child: PlanoWidget(
                valor: plano.valorPlanoMensal.toStringAsFixed(2),
                descricao: plano.descricao.toString(),
                horario: plano.horario.toString()),
          );
        });
  }
}

class PlanoWidget extends StatelessWidget {
  final String descricao;
  final String horario;
  final String valor;
  const PlanoWidget({
    Key? key,
    required this.descricao,
    required this.horario,
    required this.valor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ListTile(
                title: Text(
                  "$descricao",
                  style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: Text("$horario"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(r"R$ " + valor),
              alignment: Alignment.bottomCenter,
            )
          ],
        ),
      ),
    );
  }
}
