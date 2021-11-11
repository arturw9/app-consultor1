import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/componentes/Situacao.dart';
import 'package:app_consultor/controladores/ControladorAluno.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/util/FormatarData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class TelaPerfilAluno extends StatefulWidget {
  TelaPerfilAluno({Key? key}) : super(key: key);

  @override
  _TelaPerfilAlunoState createState() => _TelaPerfilAlunoState();
}

ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
ControladorAluno _controlador = GetIt.I.get<ControladorAluno>();
DateTime dob = DateTime.parse(
    '${_controlador.aluno!.dataNascimento != null ? _controlador.aluno!.dataNascimento! : ''}');
Duration dur = DateTime.now().difference(dob);
String differenceInYears = (dur.inDays / 365).floor().toString();

class _TelaPerfilAlunoState extends State<TelaPerfilAluno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon:
                new Icon(Icons.arrow_back_ios, color: Colors.black, size: 24)),
        title: Text("PERFIL DO ALUNO",
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 16,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          backgroundImage: _controlador.aluno!.imageUri == null
                              ? null
                              : NetworkImage(
                                  _controlador.aluno!.imageUri.toString()),
                          child: _controlador.aluno!.imageUri == null
                              ? SvgPicture.asset(
                                  "assets/images/fotoPadrao.svg",
                                  allowDrawingOutsideViewBox: true,
                                  height: 160,
                                )
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          _controlador.aluno!.nome.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "Matrícula: ${_controlador.aluno!.matricula}",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: SituacaoWidget(aluno: _controlador.aluno!)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Card(
                    elevation: 5,
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
                          height: 190,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: Row(
                                  children: [
                                    Text(
                                      "Dados pessoais",
                                      style: TextStyle(
                                          color: Color(0XFF0380E3),
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                        ),
                                        child: Text(
                                            "Data de nascimento: ${_controlador.aluno!.dataNascimento != null ? FormatarData.formatarData(_controlador.aluno!.dataNascimento!) : '-'}",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ),

                                      /*Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, right: 11),
                                        child: Text("Idade:  anos",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      )*/
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 4),
                                        child: Text(
                                            "Idade: $differenceInYears anos",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 19, right: 19),
                              ),
                              Row(
                                children: [
                                  Text("Contato",
                                      style: TextStyle(
                                          color: Color(0XFF0380E3),
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))
                                ],
                              ),
                              Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          _controlador.aluno!.telefones!.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Text("Telefone: ",
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12)),
                                            Text(
                                                "${_controlador.aluno!.telefones![index].tipo} : ${_controlador.aluno!.telefones![index].numero}",
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    fontSize: 12)),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                              Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          _controlador.aluno!.emails!.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              child: Text("Email:",
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoSans',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 12)),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                    " ${_controlador.aluno!.emails![index].toString()}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NunitoSans',
                                                        fontSize: 12)),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(10),
                      title: Text("Detalhamento do Plano",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Nome",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Text("Valor",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("FULL + Musculação diluida",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans', fontSize: 12)),
                              Text("RS 250,00",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans', fontSize: 12))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Contrato",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Text("Vigência",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("000000",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans', fontSize: 12)),
                              Text("00/00/0000 à 00/00/0000",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans', fontSize: 12))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Situação",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(10),
                      title: Text("Modalidades de contrato ativo ",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Crossfit Especial",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(10),
                      title: Text("Avisos",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _controlador.aluno!.avisos!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                              "${_controlador.aluno!.avisos![index].toString()}",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontFamily: 'NunitoSans',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(10),
                      title: Text("Observações",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      _controlador.aluno!.observacoes!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: 310,
                                          child: Text(
                                              "${_controlador.aluno!.observacoes![index].toString()}",
                                              style: TextStyle(
                                                  fontFamily: 'NunitoSans',
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 90,
        child: Center(
          child: Container(
            width: 350,
            child: ButtonNovaVenda(
                value: " NOVA VENDA",
                onTap: () {
                  _controladorCarrinho.aluno = _controlador.aluno;
                  Navigator.pushNamed(context, "/telaCarrinho");
                }),
          ),
        ),
      ),
    );
  }
}
