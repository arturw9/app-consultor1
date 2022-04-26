import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/componentes/CardDuracao.dart';
import 'package:app_consultor/componentes/CardModalidadePlano.dart';
import 'package:app_consultor/componentes/CardPacotePlano.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorPagamento.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Produto.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:app_consultor/modelos/Venda.dart';
import 'package:app_consultor/servicos/ServicoVenda.dart';

import 'package:app_consultor/util/FormatarData.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:date_format/date_format.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:app_consultor/componentes/CardHorario.dart';

class TelaFechamentoVenda extends StatefulWidget {
  TelaFechamentoVenda({Key? key}) : super(key: key);

  @override
  _TelaFechamentoVendaState createState() => _TelaFechamentoVendaState();
}

class _TelaFechamentoVendaState extends State<TelaFechamentoVenda> {
  String str = "";
  int _valorVezesPagar = 1;
  int _vencFatura = 1;
  ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
  Usuario usuario = GetIt.I.get<ControladorUsuario>().usuario;
  var _valorSelecionado;
  var dataNascimento;

  get diaVencimento => null;

  get email => null;

  @override
  void initState() {
    if (_controladorCarrinho.plano!.tipoPlano == "PLANO_CREDITO")
      _controladorCarrinho.plano!.modalidades
          .forEach((x) => x.selecionado = true);
    super.initState();
  }

  @override
  void dispose() {
    _controladorCarrinho.plano!.modalidades.forEach((element) {
      element.selecionado = false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("FECHAMENTO DA VENDA",
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 16,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 52,
                        backgroundImage: _controladorCarrinho.aluno!.imageUri ==
                                null
                            ? null
                            : NetworkImage(_controladorCarrinho.aluno!.imageUri
                                .toString()),
                        child: _controladorCarrinho.aluno!.imageUri == null
                            ? SvgPicture.asset(
                                "assets/images/fotoPadrao.svg",
                                allowDrawingOutsideViewBox: true,
                                height: 160,
                              )
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              _controladorCarrinho.aluno!.nome.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              "Matrícula: ${_controladorCarrinho.aluno!.matricula}",
                              //   "Matrícula: ${_controladorCarrinho.plano!.modalidades[0].codigo}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Início contrato ",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  Text(
                    "${FormatarData.formatarData(_controladorCarrinho.plano!.vigenciaDe)}",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Data término ",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  Text(
                    "${FormatarData.formatarData(_controladorCarrinho.plano!.vigenciaAte)}",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Lançamento ",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      "${formatDate(_controladorCarrinho.lancamento!, [
                            dd,
                            '/',
                            mm,
                            '/',
                            yyyy
                          ])}",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Data de inicio ",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      "${formatDate(_controladorCarrinho.datainicio!, [
                            dd,
                            '/',
                            mm,
                            '/',
                            yyyy
                          ])}",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      child: Text(
                        "Empresa ",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "${usuario.unidade!.nome}",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "NunitoSans",
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Valor Mensalidade ",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  Text(
                    "R\$  ${_controladorCarrinho.plano!.valorPlanoMensal.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Fidelidade ",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  Text(
                    "${_controladorCarrinho.plano!.fidelidadeDuracaoPlano} MESES ",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Taxa de Adesão ",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  Text(
                    "R\$  ${_controladorCarrinho.plano!.taxaAdesao.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              if (_controladorCarrinho.plano!.valorAnuidade != null)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Anuidade ",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      ),
                    ),
                    Text(
                      "${_controladorCarrinho.plano!.valorAnuidade!.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ],
                ),
              SizedBox(height: 10),
              if (_controladorCarrinho.plano!.pacotes != null)
                CardPacotePlano(
                    controladorCarrinho: _controladorCarrinho,
                    atualizar: () => setState(() {})),
              CardModalidadePlano(
                  atualizar: () => setState(() {}),
                  controladorCarrinho: _controladorCarrinho,
                  selecionar: (valor) => setState(() {
                        if (_valorSelecionado != null)
                          _controladorCarrinho
                              .plano!
                              .modalidades[_valorSelecionado]
                              .selecionado = false;
                        _controladorCarrinho
                            .plano!.modalidades[valor!].selecionado = true;
                        _valorSelecionado = valor;
                      })),
              SizedBox(height: 10),
              CardDuracao(
                controladorCarrinho: _controladorCarrinho,
              ),
              CardHorario(
                controladorCarrinho: _controladorCarrinho,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    childrenPadding: EdgeInsets.all(12),
                    title: Text("Produtos",
                        style: TextStyle(
                            color: Color(0XFF0380E3),
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Text("Nome",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Text("Qtd",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            alignment: Alignment.centerRight,
                            child: Text("Valor",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          )
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                _controladorCarrinho.listaProdutos.length,
                            itemBuilder: (context, index) {
                              final Produto produto =
                                  _controladorCarrinho.listaProdutos[index];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Text("${produto.descricao}",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                    child: Text("${produto.quantidade}  ",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13)),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        " R\$ ${produto.valorFinal.toStringAsFixed(2)}  ",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TOTAL",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                            Text(
                                " R\$ ${_controladorCarrinho.totalProdutos.toStringAsFixed(2)}  ",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
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
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    childrenPadding: EdgeInsets.all(12),
                    title: Text("Produtos do Plano",
                        style: TextStyle(
                            color: Color(0XFF0380E3),
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Text("Nome",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Text("Qtd",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            alignment: Alignment.centerRight,
                            child: Text("Valor",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          )
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                _controladorCarrinho.plano!.produtos!.length,
                            itemBuilder: (context, index) {
                              final Produto produtoPlano =
                                  _controladorCarrinho.plano!.produtos![index];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Text("${produtoPlano.descricao}",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                    child: Text("${produtoPlano.quantidade}  ",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13)),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        " R\$ ${produtoPlano.valorFinal.toStringAsFixed(2)}  ",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13)),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TOTAL",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                            Text(
                                " R\$ ${_controladorCarrinho.totalProdutosPlano.toStringAsFixed(2)}  ",
                                style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Total do contrato",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                  ),
                  Text(
                      " R\$ ${_controladorCarrinho.totalContrato.toStringAsFixed(2)}",
                      // " R\$ ${_controladorCarrinho.plano!.valorFinal!.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Produtos",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                  ),
                  Text(
                      "R\$ ${_controladorCarrinho.totalProdutos.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24),
              ),
              Center(
                child: Container(
                    height: 40,
                    width: 500,
                    decoration: new BoxDecoration(
                        color: Color(0XFF6F747B),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TOTAL",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'NunitoSans'),
                            ),
                            Text(
                              "R\$ ${(_controladorCarrinho.totalFechamento).toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                fontFamily: 'NunitoSans',
                              ),
                            ),
                          ]),
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      child: Text(
                        "Parcele em (x) vezes",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // decoration: ShapeDecoration(
                    //     shape: RoundedRectangleBorder(
                    //         side: BorderSide(
                    //             width: 0.5,
                    //             style: BorderStyle.solid,
                    //             color: Colors.blue),
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(10.0)))),
                    child: DropdownButton<int>(
                        autofocus: true,
                        borderRadius: BorderRadius.circular(20),
                        alignment: Alignment.centerRight,
                        value: _valorVezesPagar,
                        items: List<int>.generate(
                            _controladorCarrinho.plano!.maximoVezesParcelar!,
                            (i) => i + 1).map((int value) {
                          return new DropdownMenuItem<int>(
                            value: value,
                            child: new Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _valorVezesPagar = value!;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      child: Text(
                        "Dia vencimento da fatura ",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: DropdownButton<int>(
                        autofocus: true,
                        borderRadius: BorderRadius.circular(20),
                        alignment: Alignment.centerRight,
                        value: _vencFatura,
                        items: _controladorCarrinho
                            .plano!.diasVencimentoProrata!
                            .map((int value) {
                          return new DropdownMenuItem<int>(
                            value: value,
                            child: new Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _vencFatura = value!;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  color: Colors.black,
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonAlterarFechamentoVenda(
                      value: "ALTERAR",
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, "/telaCarrinho");
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    ButtonConcluirFechamentoVenda(
                      value: "CONCLUIR",
                      onTap: () {
                        GetIt.I.get<ControladorPagamento>().aluno =
                            _controladorCarrinho.aluno;
                        GetIt.I.get<ControladorPagamento>().plano =
                            _controladorCarrinho.plano;
                        GetIt.I.get<ControladorPagamento>().total =
                            _controladorCarrinho.totalProdutos;
                        Venda venda = Venda(
                            unidade: 1,
                            dataInicio: formatDate(
                                _controladorCarrinho.datainicio!,
                                ["yyyy", '-', "mm", '-', "dd"]),
                            dataLancamento: formatDate(
                                _controladorCarrinho.lancamento!,
                                ["yyyy", '-', "mm", '-', "dd"]),
                            plano: _controladorCarrinho.plano!.codigo,
                            nome: _controladorCarrinho.aluno!.nome.toString(),
                            cpf: _controladorCarrinho.aluno!.cpf.toString(),
                            diaVencimento: diaVencimento,
                            nrVezesDividir: _valorVezesPagar,
                            produtos: _controladorCarrinho.listaProdutos);
                        UtilCarregamento.exibirCarregamento(context);
                        ServicoVenda.concluirVenda(venda).then((value) {
                          GetIt.I.get<ControladorPagamento>().aluno =
                              _controladorCarrinho.aluno;
                          GetIt.I.get<ControladorPagamento>().plano =
                              _controladorCarrinho.plano;
                          GetIt.I.get<ControladorPagamento>().total =
                              _controladorCarrinho.totalProdutos;
                          GetIt.I.resetLazySingleton<ControladorCarrinho>();
                          Navigator.of(context).pop();
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/telaPagamento",
                              (Route<dynamic> route) => false);
                        }).catchError((erro) {
                          Navigator.of(context).pop();
                          UtilDialog.exibirInformacoes(context,
                              titulo: "Ops!", mensagem: erro);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
