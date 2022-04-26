import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/modelos/DuracaoPlano.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardDuracao extends StatefulWidget {
  final ControladorCarrinho controladorCarrinho;
  var mesSelecionadoValor;

  CardDuracao({
    Key? key,
    required this.controladorCarrinho,
    this.mesSelecionadoValor,
  }) : super(key: key);

  @override
  State<CardDuracao> createState() => _CardDuracaoState();
}

class _CardDuracaoState extends State<CardDuracao> {
  @override
  Widget build(BuildContext context) {
    ControladorCarrinho _controladorCarrinho = widget.controladorCarrinho;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        initiallyExpanded: true,
        childrenPadding: EdgeInsets.all(12),
        title: Text("Durações",
            style: TextStyle(
                color: Color(0XFF0380E3),
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _controladorCarrinho.plano!.duracoes!.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio<DuracaoPlano>(
                        value: _controladorCarrinho.plano!.duracoes![index],
                        groupValue:
                            _controladorCarrinho.plano!.duracaoSelecionada,
                        onChanged: (value) => {
                              setState(() {
                                _controladorCarrinho.plano!.duracaoSelecionada =
                                    value;
                              }),
                            }),
                    Container(
                      child: Text(
                          "${_controladorCarrinho.plano!.duracoes![index].duracaoNumeroMeses.toString() + ' Mês(s) '} ",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                    ),
                    Container(
                      child: Text(
                          "R\$ ${_controladorCarrinho.plano!.duracoes![index].valorEspecifico!.toStringAsFixed(2)}",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                    ),
                    Container(
                      child: Text(
                          "R\$ ${_controladorCarrinho.plano!.duracoes![index].percentualdesconto!.toStringAsFixed(2)}  ",
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
  }
}
