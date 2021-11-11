import 'package:app_consultor/componentes/ModalPesquisa.dart';
import 'package:app_consultor/componentes/TextFieldLoginPadrao.dart';
import 'package:app_consultor/controladores/ControladorLancarDiaria.dart';
import 'package:app_consultor/controladores/ControladorPesquisaAlunos.dart';
import 'package:app_consultor/controladores/controladorPesquisaModalidades.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaLancarDiaria2 extends StatefulWidget {
  TelaLancarDiaria2({Key? key}) : super(key: key);

  @override
  _TelaLancarDiaria2State createState() => _TelaLancarDiaria2State();
}

class _TelaLancarDiaria2State extends State<TelaLancarDiaria2> {
  ControladorLancarDiaria _controladorLancarDiaria =
      GetIt.I.get<ControladorLancarDiaria>();
  ControladorPesquisaAluno controladorPesquisaAluno =
      ControladorPesquisaAluno();
  ControladorPesquisaModalidades controladorPesquisaModalidades =
      ControladorPesquisaModalidades();

  final textController = TextEditingController();
  double total = 0;

  DateTime _data = new DateTime.now();
  DateTime _datadepois = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: new Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 24)),
          backgroundColor: Colors.white,
          title: Text(
            "LANÇAR DIÁRIA",
            style: TextStyle(
                fontFamily: "NunitoSans", fontSize: 16, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: BotaoPesquisaAluno(
                      aluno: _controladorLancarDiaria.aluno,
                      context: context,
                      controladorPesquisaAluno: controladorPesquisaAluno,
                      textController: textController,
                      onTap: (aluno) {
                        Navigator.pop(context);
                        setState(() {
                          _controladorLancarDiaria.aluno = aluno;
                        });
                      }),
                ),
                SizedBox(
                  height: 36,
                ),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 70,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Text("Data de Início",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Text("Lançamento",
                                        style: TextStyle(
                                            color: Color(0XFFA0A0A0),
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Container(
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Text(
                                            "${formatDate(_datadepois, [
                                                  dd,
                                                  '-',
                                                  mm,
                                                  '-',
                                                  yyyy
                                                ])}",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontSize: 16)),
                                        IconButton(
                                            onPressed: () async {
                                              final dtPick =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2100));

                                              if (dtPick != null &&
                                                  dtPick != _datadepois) {
                                                setState(() {
                                                  _datadepois = dtPick;
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.calendar_today_outlined,
                                              size: 18,
                                              color: Color(0XFF60380E3),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Container(
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Text(
                                            "${formatDate(_data, [
                                                  dd,
                                                  '-',
                                                  mm,
                                                  '-',
                                                  yyyy
                                                ])}",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontSize: 16)),
                                        IconButton(
                                            onPressed: () async {
                                              final dtPick =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(2100));

                                              if (dtPick != null &&
                                                  dtPick != _data) {
                                                setState(() {
                                                  _data = dtPick;
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.calendar_today_outlined,
                                              size: 18,
                                              color: Color(0XFF60380E3),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                      child: BotaoPesquisaModalidades(
                          modalidade: _controladorLancarDiaria.modalidade,
                          context: context,
                          textController: textController,
                          onTap: (modalidade) {
                            Navigator.pop(context);
                            setState(() {
                              _controladorLancarDiaria.modalidade = modalidade;
                            });
                          },
                          controladorPesquisaModalidades:
                              controladorPesquisaModalidades)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Container(
                        width: 130,
                        height: 40,
                        child: Center(
                          child: Text(
                            "ADICIONAR DIARIA",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "NunitoSans",
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(top: 20, left: 18),
                  child: Row(
                    children: [
                      Text(
                        "Produtos",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0380E3)),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: IconButton(
                            iconSize: 20,
                            color: Colors.blue,
                            icon: Icon(Icons.add_rounded, color: Colors.white),
                            onPressed: () {}),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),*/
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 380,
                      color: Color(0xFFF3F3F4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 25),
                                child: Text(
                                  "Nome",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "NunitoSans",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 25),
                                child: Text(
                                  "Valor",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "NunitoSans",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Desconto",
                                style: TextStyle(
                                  color: Color(0XFF0380E3),
                                  fontFamily: "NunitoSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*Padding(
                          padding: const EdgeInsets.only(right: 2, left: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                r"R$ 00,00",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontSize: 18,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, bottom: 15),
                                child: Icon(
                                  Icons.add_task_rounded,
                                  size: 26,
                                ),
                              )
                            ],
                          ),
                        ),*/
                        FieldLancarDiaria(onChanged: (text) {}),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 77,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 5,
                color: Colors.black,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 19, right: 44),
                  child: Text(
                    r"Total R$" + total.toStringAsFixed(2),
                    style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(bottom: 17),
                  width: 163.5,
                  height: 70,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      primary: Color(0XFF0380E3),
                    ),
                    icon: Icon(Icons.local_grocery_store_outlined),
                    onPressed: () {
                      showDialog(
                        // traz um diálogo em cima da tela
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Card(
                                margin: EdgeInsets.all(24),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Confirma o lançamento da Diaria",
                                        style: TextStyle(
                                            fontFamily: "NunitoSans",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      Divider(),
                                      Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Produto:",
                                                  style: TextStyle(
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Dados da api ",
                                                  style: TextStyle(
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Container(
                                              color: Color(0XFF2EC750),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Modalidade:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "NunitoSans",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${_controladorLancarDiaria.modalidade!.nome}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "NunitoSans",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Data de Inicio:",
                                                  style: TextStyle(
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${formatDate(_datadepois, [
                                                        dd,
                                                        '-',
                                                        mm,
                                                        '-',
                                                        yyyy
                                                      ])}",
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoSans',
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Valor:",
                                                  style: TextStyle(
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Dados da api ",
                                                  style: TextStyle(
                                                      fontFamily: "NunitoSans",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 50,
                                            child: ElevatedButton(
                                              child: Text(
                                                "CANCELAR",
                                                style: TextStyle(
                                                    fontFamily: "NunitoSans",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                primary: Color(0XFFFFFFFF),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 150,
                                            height: 50,
                                            child: ElevatedButton(
                                              child: Text(
                                                "CONFIRMAR",
                                                style: TextStyle(
                                                    fontFamily: "NunitoSans",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 5,
                                                primary: Color(0XFF0380E3),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    "/telaFechamentoDiaria");
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                      );
                    },
                    label: Text(
                      'FECHAR VENDA',
                      style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
