import 'package:app_consultor/controladores/controladorPesquisaModalidades.dart';
import 'package:flutter/material.dart';

import 'package:app_consultor/modelos/Modalidade.dart';
import 'package:app_consultor/util/EnumPesquisaEstado.dart';

// ignore: must_be_immutable
class ListaModalidades extends StatelessWidget {
  ControladorPesquisaModalidades controlador;
  ValueChanged<Modalidade> onTap;
  ListaModalidades({
    Key? key,
    required this.controlador,
    required this.onTap,
  }) : super(key: key);
  double posicaoScroll = 0.0;

  gereciadorEstado(PesquisaEstado estado) {
    switch (estado) {
      case PesquisaEstado.carregando:
        controlador.pesquisaModalidade();
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
            return controlador.pesquisaModalidade();
          },
          child: ListBuilderModalidades(onTap: onTap, controlador: controlador),
        );
      case PesquisaEstado.erro:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Não há resulados para a busca"),
              IconButton(
                  onPressed: () => controlador.pesquisaModalidade(),
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

class ListBuilderModalidades extends StatelessWidget {
  final ControladorPesquisaModalidades controlador;
  final ValueChanged<Modalidade> onTap;
  const ListBuilderModalidades({
    Key? key,
    required this.controlador,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: controlador.listaModalidade!.length,
        itemBuilder: (context, index) {
          final Modalidade modalidade = controlador.listaModalidade![index];
          return GestureDetector(
              onTap: () {
                onTap(modalidade);
              },
              child: ModalidadeWidget(
                valor: modalidade.valorMensal.toString(),
                descricao: modalidade.nome,
                horario: '',
              ));
        });
  }
}

class ModalidadeWidget extends StatelessWidget {
  final String descricao;
  final String horario;
  final String valor;
  const ModalidadeWidget({
    Key? key,
    required this.descricao,
    required this.horario,
    required this.valor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Container(
            width: 260,
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Text(r"R$ " + valor),
            ),
          )
        ],
      ),
    );
  }
}
