import 'package:app_consultor/componentes/ButtonPadrao.dart';

import 'package:app_consultor/componentes/Situacao.dart';
import 'package:app_consultor/controladores/ControladorAluno.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';

import 'package:app_consultor/util/FormatarData.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaPerfilAluno extends StatefulWidget {
  TelaPerfilAluno({Key? key}) : super(key: key);

  @override
  _TelaPerfilAlunoState createState() => _TelaPerfilAlunoState();
}

class _TelaPerfilAlunoState extends State<TelaPerfilAluno> {
  @override
  Widget build(BuildContext context) {
    ControladorCarrinho _controladorCarrinho =
        GetIt.I.get<ControladorCarrinho>();
    ControladorAluno _controlador = GetIt.I.get<ControladorAluno>();

    DateTime dataNascimento = DateTime.parse(
        '${_controlador.aluno!.dataNascimento != null ? _controlador.aluno!.dataNascimento! : ''}');
    Duration diferencaDatas = DateTime.now().difference(dataNascimento);
    String idade = (diferencaDatas.inDays / 365).floor().toString();

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
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                textDirection: TextDirection.rtl,
                                children: [
                                  if (_controlador.aluno!.situacaoContrato !=
                                      null)
                                    Situacao(
                                        tipo: _controlador
                                            .aluno!.situacaoContrato!),
                                  if (_controlador.aluno!.situacao != null)
                                    Situacao(
                                        tipo: _controlador.aluno!.situacao!),
                                ],
                              ),
                            )),
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
                                            "Data de nascimento:  ${_controlador.aluno!.dataNascimento != null ? FormatarData.formatarData(_controlador.aluno!.dataNascimento!) : '-'}",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, right: 11),
                                        child: Text("Idade:  $idade",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 19, right: 19),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Text("Contato",
                                        style: TextStyle(
                                            color: Color(0XFF0380E3),
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: _controlador
                                            .aluno!.telefones!.length,
                                        itemBuilder: (context, index) {
                                          var tel = _controlador
                                              .aluno!.telefones![index].numero;
                                          Future<void> launchWhatsapp({
                                            @required numero,
                                            @required msmAut,
                                          }) async {
                                            var url =
                                                'https://api.whatsapp.com/send?phone=55$numero&text=$msmAut';
                                            await canLaunch(url)
                                                ? launch(
                                                    url,
                                                  )
                                                : UtilDialog.exibirInformacoes(
                                                    context,
                                                    titulo: "Ops!",
                                                    mensagem:
                                                        "Não foi possível abrir o WhatsApp",
                                                  );
                                          }

                                          return Row(
                                            children: [
                                              Text("Telefone: ",
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoSans',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 12)),
                                              Text(
                                                  "${_controlador.aluno!.telefones![index].tipo} : ${_controlador.aluno!.telefones![index].numero}",
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoSans',
                                                      fontSize: 12)),
                                              _controlador.aluno!
                                                      .telefones![index].tipo
                                                      .contains('CELULAR')
                                                  ? TextButton(
                                                      onPressed: () {
                                                        launchWhatsapp(
                                                            numero:
                                                                tel.replaceAll(
                                                                    RegExp(
                                                                        r"\D"),
                                                                    ""),
                                                            //https://api.chatpro.com.br - gerar texto compativel whatasapp
                                                            msmAut:
                                                                "Ol%C3%A1%2C+Bem+Vindo+%C3%A0+Pacto+Vendas%21+");
                                                      },
                                                      child: Text("WhatsApp",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontFamily:
                                                                  'NunitoSans',
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .green)))
                                                  : Text(""),
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(
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
                                                        fontFamily:
                                                            'NunitoSans',
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
                              ),
                              Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _controlador.vinculos!.length,
                                      itemBuilder: (context, index) {
                                        var tipo = _controlador
                                            .vinculos![index].tipoDeVinculo;

                                        switch (tipo) {
                                          case 'CO':
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text("Consultor: ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoSans',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 12)),
                                                    Text(
                                                        "${_controlador.vinculos![index].nome} ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoSans',
                                                            fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            );

                                          case 'PR':
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text("Professor: ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoSans',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 12)),
                                                    Text(
                                                        "${_controlador.vinculos![index].nome} ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoSans',
                                                            fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            );
                                          case 'TW':
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "Professor(TreinoWeb): ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoSans',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 12)),
                                                    Text(
                                                        "${_controlador.vinculos![index].nome} ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'NunitoSans',
                                                            fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            );

                                          default:
                                        }
                                        return SizedBox();
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
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
                                  itemCount:
                                      _controlador.aluno!.avisos!.length < 2
                                          ? _controlador.aluno!.avisos!.length
                                          : 2,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              child: Text(
                                                  " - ${_controlador.aluno!.avisos!.reversed.toList()[index].toString()}",
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      fontFamily: 'NunitoSans',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12)),
                                            )),
                                      ],
                                    );
                                  }),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      // traz um diálogo em cima da tela
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Card(
                                                  margin: EdgeInsets.all(16),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            28.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text("Avisos",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF0380E3),
                                                                  fontFamily:
                                                                      'NunitoSans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                        Divider(),
                                                        Column(
                                                          children: [
                                                            ListView.builder(
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    _controlador
                                                                        .aluno!
                                                                        .avisos!
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Row(
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.7,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 7),
                                                                          child:
                                                                              Container(
                                                                            child: Text(" - ${_controlador.aluno!.avisos![index].toString()}",
                                                                                textAlign: TextAlign.justify,
                                                                                style: TextStyle(fontFamily: 'NunitoSans', fontWeight: FontWeight.w500, fontSize: 13)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        ElevatedButton(
                                                          child: Text("Fechar"),
                                                          style: ElevatedButton.styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              primary: Color(
                                                                  0XFF0380E3)),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text("Ver mais ...",
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //card contratos
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(12),
                      title: Text("Contratos",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text("Contrato",
                                    style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13)),
                              ),
                              Container(
                                child: Text("Início - Fim",
                                    style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13)),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text("Situação",
                                    style: TextStyle(
                                        fontFamily: 'NunitoSans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13)),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _controlador.contratos!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10),
                                  child: GestureDetector(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                              "${_controlador.contratos![index].codContrato} ",
                                              style: TextStyle(
                                                  fontFamily: 'NunitoSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13)),
                                        ),
                                        Container(
                                          child: Text(
                                              "${_controlador.contratos![index].vigenciaDe} - ${_controlador.contratos![index].vigenciaAteAjustada}",
                                              style: TextStyle(
                                                  fontFamily: 'NunitoSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13)),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              Situacao(
                                                tipo: _controlador
                                                    .contratos![index]
                                                    .situacao!,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      showDialog(
                                        // traz um diálogo em cima da tela
                                        context: context,
                                        builder: (context) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Card(
                                                    margin: EdgeInsets.all(16),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                                "Contrato",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0XFF0380E3),
                                                                    fontFamily:
                                                                        'NunitoSans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14)),
                                                          ),
                                                          Divider(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                // Text(
                                                                //     "Responsável Lançamento Contrato: ",
                                                                //     style: TextStyle(
                                                                //         fontFamily:
                                                                //             'NunitoSans',
                                                                //         fontWeight:
                                                                //             FontWeight
                                                                //                 .w800,
                                                                //         fontSize:
                                                                //             13)),
                                                              ],
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                // Text(
                                                                //     "PACTO - MÉTODO DE GESTÃO",
                                                                //     style: TextStyle(
                                                                //         color: Colors
                                                                //             .red,
                                                                //         fontFamily:
                                                                //             'NunitoSans',
                                                                //         fontSize:
                                                                //             13)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          // Divider(
                                                          //   indent: 100,
                                                          //   endIndent: 100,
                                                          //   color: Colors.grey,
                                                          // ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  "Valor Contrato: ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          13)),
                                                              Text(
                                                                  " R\$ ${_controlador.contratos![index].valorContrato!.toStringAsFixed(2)}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontSize:
                                                                          13)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text("Duracão: ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          13)),
                                                              Text(
                                                                  "${_controlador.contratos![index].duracao} Meses",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontSize:
                                                                          13)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text("Plano: ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          13)),
                                                              Text(
                                                                  "${_controlador.contratos![index].nomePlano}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontSize:
                                                                          13)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              // Text(
                                                              //     "Tipo de Contrato: ",
                                                              //     style: TextStyle(
                                                              //         fontFamily:
                                                              //             'NunitoSans',
                                                              //         fontWeight:
                                                              //             FontWeight
                                                              //                 .w800,
                                                              //         fontSize:
                                                              //             13)),
                                                              // Text("ESPONTÂNEO",
                                                              //     style: TextStyle(
                                                              //         color: Colors
                                                              //             .red,
                                                              //         fontFamily:
                                                              //             'NunitoSans',
                                                              //         fontSize:
                                                              //             13)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Divider(
                                                            indent: 100,
                                                            endIndent: 100,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  "Modalidades: ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          13)),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  "${_controlador.contratos![index].modalidadesNome}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontSize:
                                                                          13))
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  "${_controlador.contratos![index].modalidadesNrVezesSemana}X / SEMANA ",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'NunitoSans',
                                                                      fontSize:
                                                                          13))
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 16,
                                                          ),
                                                          ElevatedButton(
                                                            child:
                                                                Text("Fechar"),
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                primary: Color(
                                                                    0XFF0380E3)),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              }),
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
                                              "- ${_controlador.aluno!.observacoes![index].toString()}",
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
