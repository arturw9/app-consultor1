import 'package:app_consultor/modelos/ModalidadePlano.dart';
import 'package:app_consultor/modelos/VezesModalidade.dart';
import 'package:flutter/material.dart';

import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/modelos/Pacote.dart';

class CardPacotePlano extends StatelessWidget {
  final ControladorCarrinho controladorCarrinho;
  final Function atualizar;
  const CardPacotePlano({
    Key? key,
    required this.controladorCarrinho,
    required this.atualizar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        initiallyExpanded: true,
        childrenPadding: EdgeInsets.all(12),
        title: Text("Pacotes",
            style: TextStyle(
                color: Color(0XFF0380E3),
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: controladorCarrinho.plano!.pacotesNormais.length,
              itemBuilder: (context, index) {
                Pacote pacote =
                    controladorCarrinho.plano!.pacotesNormais[index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<Pacote>(
                            toggleable: true,
                            value: controladorCarrinho
                                .plano!.pacotesNormais[index],
                            groupValue:
                                controladorCarrinho.plano!.pacoteSelecionado,
                            onChanged: (pacote) {
                              controladorCarrinho.plano!.pacoteSelecionado =
                                  pacote;
                              controladorCarrinho.plano!.pacotesAdicionais
                                  .forEach((e) => e.selecionado = false);
                              controladorCarrinho.selecionarModalidadesPacote(
                                  null,
                                  pacoteAdicional: true,
                                  modalidadeNaoEspecifica: true);
                              controladorCarrinho
                                  .selecionarModalidadesPacote(pacote);
                              atualizar.call();
                            }),
                        Text(
                          pacote.descricao,
                          overflow: TextOverflow.visible,
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 5),
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                              "R\$ ${(pacote.precoComposicao.toStringAsFixed(2))}  ",
                              style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13)),
                        ),
                      ],
                    ),
                    if (!pacote.modalidadesEspecificas &&
                        controladorCarrinho.plano!.pacoteSelecionado == pacote)
                      CardModalidadePacote(
                          pacote: pacote,
                          controladorCarrinho: controladorCarrinho,
                          atualizar: atualizar)
                  ],
                );
              }),
          SizedBox(
            height: 10,
          ),
          if (controladorCarrinho.plano!.pacoteSelecionado != null)
            PacotesAdicionaisWidget(
                controladorCarrinho: controladorCarrinho, atualizar: atualizar)
        ],
      ),
    );
  }
}

class PacotesAdicionaisWidget extends StatelessWidget {
  final ControladorCarrinho controladorCarrinho;
  final Function atualizar;
  const PacotesAdicionaisWidget(
      {Key? key, required this.controladorCarrinho, required this.atualizar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Divider(
        thickness: 3,
      ),
      Container(
          padding: EdgeInsets.only(top: 6, left: 6),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Pacotes Adicionais",
                      style: TextStyle(
                          color: Color(0XFF0380E3),
                          fontWeight: FontWeight.bold))),
              SizedBox(
                height: 25,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      controladorCarrinho.plano!.pacotesAdicionais.length,
                  itemBuilder: (context, index) {
                    Pacote pacote =
                        controladorCarrinho.plano!.pacotesAdicionais[index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                value: controladorCarrinho.plano!
                                    .pacotesAdicionais[index].selecionado,
                                onChanged: (valor) {
                                  controladorCarrinho
                                      .plano!
                                      .pacotesAdicionais[index]
                                      .selecionado = valor;
                                  controladorCarrinho
                                      .selecionarModalidadesPacote(
                                          valor! ? pacote : null,
                                          pacoteAdicional: true,
                                          modalidadeNaoEspecifica:
                                              !pacote.modalidadesEspecificas);

                                  atualizar.call();
                                }),
                            Text(
                              pacote.descricao,
                              overflow: TextOverflow.visible,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 5),
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                  "R\$ ${(pacote.precoComposicao.toStringAsFixed(2))}  ",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13)),
                            ),
                          ],
                        ),
                        if (!pacote.modalidadesEspecificas &&
                            pacote.selecionado!)
                          CardModalidadePacote(
                              pacote: pacote,
                              controladorCarrinho: controladorCarrinho,
                              atualizar: atualizar)
                      ],
                    );
                  }),
            ],
          ))
    ]);
  }
}

class CardModalidadePacote extends StatefulWidget {
  final ControladorCarrinho controladorCarrinho;
  final Function atualizar;
  final Pacote pacote;

  CardModalidadePacote(
      {Key? key,
      required this.controladorCarrinho,
      required this.atualizar,
      required this.pacote})
      : super(key: key);

  @override
  State<CardModalidadePacote> createState() => _CardModalidadePacoteState();
}

class _CardModalidadePacoteState extends State<CardModalidadePacote> {
  var _qtdModalSelect = 0;

  @override
  Widget build(BuildContext context) {
    List<ModalidadePlano> modalidades = widget.pacote.modalidades;
    List<ModalidadePlano> modalidadesPacote =
        widget.controladorCarrinho.plano!.modalidadesPorPacote(modalidades);
    return Column(
      children: [
        Text("Selecione até 3 modalidades",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'NunitoSans',
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$_qtdModalSelect",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NunitoSans',
                )),
            Text(
              " de ",
            ),
            Text(
              "${widget.pacote.quantidadeModalidades}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'NunitoSans',
              ),
            )
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: modalidadesPacote.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                      checkColor: Color(0XFF0380E3),
                      activeColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) {
                          return BorderSide(
                              width: 1.0, color: Color(0XFF0380E3));
                        },
                      ),
                      value: modalidadesPacote[index].selecionadoPacote! ||
                              modalidadesPacote[index]
                                  .selecionadoPacoteAdicional!
                          ? modalidadesPacote[index].selecionado
                          : modalidadesPacote[index]
                              .selecionadoPacoteNaoEspecifico,
                      onChanged: ((modalidadesPacote[index]
                                      .selecionadoPacote! ||
                                  modalidadesPacote[index]
                                      .selecionadoPacoteAdicional!) &&
                              !modalidadesPacote[index]
                                  .selecionadoPacoteNaoEspecifico!)
                          ? null
                          : (valor) {
                              modalidadesPacote[index].selecionado = valor;
                              modalidadesPacote[index]
                                  .selecionadoPacoteAdicional = valor;
                              modalidadesPacote[index]
                                  .selecionadoPacoteNaoEspecifico = valor;
                              modalidadesPacote[index].pacoteCodigo =
                                  widget.pacote.codigo;

                              setState(() {
                                valor! ? _qtdModalSelect++ : _qtdModalSelect--;
                                widget.pacote.qtdModalidadesSelecionadas =
                                    _qtdModalSelect;
                              });

                              widget.atualizar.call();
                            }),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text("${modalidadesPacote[index].nome.toString()}",
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 13)),
                  ),
                  DropdownButton<VezesModalidade>(
                      autofocus: true,
                      borderRadius: BorderRadius.circular(20),
                      alignment: Alignment.centerRight,
                      value: modalidadesPacote[index].numeroVezesSelecionado,
                      items: modalidadesPacote[index]
                          .numeroVezes
                          .map((VezesModalidade value) {
                        return new DropdownMenuItem<VezesModalidade>(
                            value: value,
                            child: Text("${value.numeroVezes.toString() + "x"}",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13)));
                      }).toList(),
                      onChanged: (value) {
                        modalidadesPacote[index].vezesAtual =
                            value!.numeroVezes;

                        widget.atualizar.call();
                      }),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text(
                        "R\$ ${(widget.controladorCarrinho.obterValorTotalModalidade(modalidadesPacote[index]).toStringAsFixed(2))}  ",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 13)),
                  ),
                ],
              );
            }),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
