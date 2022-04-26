import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/modelos/HorarioPlano.dart';
import 'package:flutter/material.dart';


class CardHorario extends StatefulWidget {
  final ControladorCarrinho controladorCarrinho;

  CardHorario(
      {Key? key, required this.controladorCarrinho})
      : super(key: key);

  @override
  State<CardHorario> createState() => _CardHorarioState();
}

class _CardHorarioState extends State<CardHorario> {
  @override
  Widget build(BuildContext context) {
    ControladorCarrinho _controladorCarrinho = widget.controladorCarrinho;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        initiallyExpanded: true,
        childrenPadding: EdgeInsets.all(12),
        title: Text("Horários",
            style: TextStyle(
                color: Color(0XFF0380E3),
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: _controladorCarrinho.plano!.horarios!.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Radio<HorarioPlano>(
                        value: _controladorCarrinho.plano!.horarios![index],
                        groupValue:
                            _controladorCarrinho.plano!.horarioPlanoSelecionado,
                        onChanged: (value) => {
                              setState(() {
                                _controladorCarrinho
                                    .plano!.horarioPlanoSelecionado = value;
                              }),
                            }),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                          "${_controladorCarrinho.plano!.horarios![index].descricao.toString()}",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                          "${_controladorCarrinho.plano!.horarios![index].tipoOperacao!.toString()}",
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      alignment: Alignment.centerRight,
                      child: Text(
                          "R\$ ${_controladorCarrinho.plano!.horarios![index].percentualdesconto!.toStringAsFixed(2)}",
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
