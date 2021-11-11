import 'package:app_consultor/componentes/ModalPesquisa.dart';
import 'package:app_consultor/componentes/PesquisaBarra.dart';
import 'package:app_consultor/controladores/ControladorLancarDiaria.dart';
import 'package:app_consultor/controladores/ControladorPesquisaAlunos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaLancarDiaria extends StatefulWidget {
  TelaLancarDiaria({Key? key}) : super(key: key);

  @override
  _TelaLancarDiariaState createState() => _TelaLancarDiariaState();
}

class _TelaLancarDiariaState extends State<TelaLancarDiaria> {
  final textController = TextEditingController();
  ControladorLancarDiaria _controladorLancarDiaria =
      GetIt.I.get<ControladorLancarDiaria>();
  ControladorPesquisaAluno controladorPesquisaAluno =
      ControladorPesquisaAluno();
  final _textController = TextEditingController();

  int _value = 1;
  int _valor = 5;

  get controladorPesquisaPlanos => null;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon:
                new Icon(Icons.arrow_back_ios, color: Colors.black, size: 24)),
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
          child: Center(
            child: Column(
              children: [
                BotaoPesquisaAluno(
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
                Container(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 12),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Lançamento",
                                style: TextStyle(
                                    fontFamily: "NunitoSans",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "00/00/0000 ",
                                    style: TextStyle(
                                        fontFamily: "NunitoSans",
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Icon(Icons.calendar_today_outlined,
                                      color: Color(0XFF60380E3))
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Data de Início",
                                style: TextStyle(
                                    fontFamily: "NunitoSans",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "00/00/0000 ",
                                    style: TextStyle(
                                        fontFamily: "NunitoSans",
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Icon(Icons.calendar_today_outlined,
                                      color: Color(0XFF60380E3))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffe4e5e6),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 29, left: 30, bottom: 5),
                    child: Container(
                      child: Text(
                        "Planos",
                        style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: PesquisaBarra(
                    textController: _textController,
                    onSubmitted: (text) {
                      controladorPesquisaPlanos.pesquisaPlano(
                          plano: text.toString());
                    },
                    hintText: "Busque pelo nome do plano",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text("Modalidade",
                          style: TextStyle(
                              fontFamily: "NunitoSans",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(
                        width: 116,
                      ),
                      Text("Desconto",
                          style: TextStyle(
                              fontFamily: "NunitoSans",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Colors.blue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        height: 42,
                        width: 150,
                        child: Center(
                          child: DropdownButton<int>(
                            hint: Text("Selecione"),
                            style: TextStyle(
                                fontFamily: "NunitoSans",
                                fontSize: 16,
                                color: Colors.black),
                            value: _value,
                            items: [
                              DropdownMenuItem(
                                child: Text("Musculação"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Natação"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("Luta"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("Ballet"),
                                value: 4,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Colors.blue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        width: 150,
                        height: 42,
                        child: Center(
                          child: DropdownButton<int>(
                            hint: Text("Selecione"),
                            style: TextStyle(
                                fontFamily: "NunitoSans",
                                fontSize: 16,
                                color: Colors.black),
                            value: _valor,
                            items: [
                              DropdownMenuItem(
                                child: Text("5%"),
                                value: 5,
                              ),
                              DropdownMenuItem(
                                child: Text("10%"),
                                value: 6,
                              ),
                              DropdownMenuItem(
                                child: Text("15%"),
                                value: 7,
                              ),
                              DropdownMenuItem(
                                child: Text("Sem desconto"),
                                value: 8,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _valor = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      'Total: RS 0,00',
                      style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 170,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0XFF0380E3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: Text(
                                "Receber",
                                style: TextStyle(
                                    fontFamily: "NunitoSans",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: 170,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0XFF0380E3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                    fontFamily: "NunitoSans",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
