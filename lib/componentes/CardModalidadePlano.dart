import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/modelos/VezesModalidade.dart';
import 'package:flutter/material.dart';

class CardModalidadePlano extends StatefulWidget {
  final ControladorCarrinho controladorCarrinho;

  final Function(int? selecionado) selecionar;
  final Function? atualizar;
  CardModalidadePlano(
      {Key? key,
      required this.controladorCarrinho,
      required this.selecionar,
      this.atualizar})
      : super(key: key);

  @override
  _CardModalidadePlanoState createState() => _CardModalidadePlanoState();
}

class _CardModalidadePlanoState extends State<CardModalidadePlano> {
  @override
  Widget build(BuildContext context) {
    ControladorCarrinho _controladorCarrinho = widget.controladorCarrinho;
    switch (_controladorCarrinho.plano!.tipoPlano) {
      case "PLANO_NORMAL":
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ExpansionTile(
            initiallyExpanded: true,
            childrenPadding: EdgeInsets.all(12),
            title: Text("Modalidades",
                style: TextStyle(
                    color: Color(0XFF0380E3),
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controladorCarrinho.plano!.modalidades.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                            value: _controladorCarrinho
                                .plano!.modalidades[index].selecionado,
                            onChanged: (_controladorCarrinho
                                        .plano!
                                        .modalidades[index]
                                        .selecionadoPacote! ||
                                    _controladorCarrinho
                                        .plano!
                                        .modalidades[index]
                                        .selecionadoPacoteAdicional!)
                                ? null
                                : (valor) => setState(() {
                                      widget.atualizar!.call();
                                      _controladorCarrinho
                                          .plano!
                                          .modalidades[index]
                                          .selecionado = valor!;
                                    })),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: Text(
                              "${_controladorCarrinho.plano!.modalidades[index].nome.toString()}",
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
                            value: _controladorCarrinho.plano!
                                .modalidades[index].numeroVezesSelecionado,
                            items: _controladorCarrinho
                                .plano!.modalidades[index].numeroVezes
                                .map((VezesModalidade value) {
                              return new DropdownMenuItem<VezesModalidade>(
                                  value: value,
                                  child: Text(
                                      "${value.numeroVezes.toString() + "x"}",
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13)));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget.atualizar!.call();
                                _controladorCarrinho.plano!.modalidades[index]
                                    .vezesAtual = value!.numeroVezes;
                              });
                            }),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                              "R\$ ${_controladorCarrinho.obterValorTotalModalidade(_controladorCarrinho.plano!.modalidades[index]).toStringAsFixed(2)}  ",
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
          ),
        );
      case "PLANO_RECORRENCIA":
        _controladorCarrinho.plano!.modalidades
            .forEach((x) => x.selecionado = true);
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ExpansionTile(
            initiallyExpanded: true,
            childrenPadding: EdgeInsets.all(12),
            title: Text("Modalidades",
                style: TextStyle(
                    color: Color(0XFF0380E3),
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controladorCarrinho.plano!.modalidades.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(value: true, onChanged: null),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Text(
                              "${_controladorCarrinho.plano!.modalidades[index].nome.toString()}  ",
                              style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                        ),
                        DropdownButton<VezesModalidade>(
                            autofocus: true,
                            borderRadius: BorderRadius.circular(20),
                            alignment: Alignment.centerRight,
                            value: _controladorCarrinho.plano!
                                .modalidades[index].numeroVezesSelecionado,
                            items: _controladorCarrinho
                                .plano!.modalidades[index].numeroVezes
                                .map((VezesModalidade value) {
                              return new DropdownMenuItem<VezesModalidade>(
                                  value: value,
                                  child: Text(
                                      "${value.numeroVezes.toString() + "x"}",
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13)));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget.atualizar!.call();
                                _controladorCarrinho.plano!.modalidades[index]
                                    .vezesAtual = value!.numeroVezes;
                              });
                            }),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                              "R\$ ${_controladorCarrinho.obterValorTotalModalidade(_controladorCarrinho.plano!.modalidades[index]).toStringAsFixed(2)}  ",
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
          ),
        );
      case "PLANO_CREDITO":
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ExpansionTile(
            initiallyExpanded: true,
            childrenPadding: EdgeInsets.all(12),
            title: Text("Modalidades",
                style: TextStyle(
                    color: Color(0XFF0380E3),
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controladorCarrinho.plano!.modalidades.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                            value: _controladorCarrinho
                                .plano!.modalidades[index].selecionado,
                            onChanged: (valor) => setState(() {
                                  widget.atualizar!.call();
                                  _controladorCarrinho.plano!.modalidades[index]
                                      .selecionado = valor!;
                                })),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Text(
                              "${_controladorCarrinho.plano!.modalidades[index].nome.toString()}  ",
                              style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                        ),
                        DropdownButton<VezesModalidade>(
                            autofocus: true,
                            borderRadius: BorderRadius.circular(20),
                            alignment: Alignment.centerRight,
                            value: _controladorCarrinho.plano!
                                .modalidades[index].numeroVezesSelecionado,
                            items: _controladorCarrinho
                                .plano!.modalidades[index].numeroVezes
                                .map((VezesModalidade value) {
                              return new DropdownMenuItem<VezesModalidade>(
                                  value: value,
                                  child: Text(
                                      "${value.numeroVezes.toString() + "x"}",
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13)));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget.atualizar!.call();
                                _controladorCarrinho.plano!.modalidades[index]
                                    .vezesAtual = value!.numeroVezes;
                              });
                            }),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                              "R\$ ${_controladorCarrinho.obterValorTotalModalidade(_controladorCarrinho.plano!.modalidades[index]).toStringAsFixed(2)}  ",
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
              )
            ],
          ),
        );
      default:
        return Container();
    }
  }
}
