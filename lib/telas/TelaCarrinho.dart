import 'dart:ui';

import 'package:app_consultor/servicos/ServicosPlano.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get_it/get_it.dart';

import 'package:app_consultor/componentes/ModalPesquisa.dart';
import 'package:app_consultor/componentes/ProdutoWidget.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorPesquisaAlunos.dart';
import 'package:app_consultor/controladores/ControladorPesquisaPlanos.dart';
import 'package:app_consultor/controladores/ControladorPesquisaProdutos.dart';
import 'package:app_consultor/modelos/Plano.dart';
import 'package:app_consultor/modelos/Produto.dart';

class TelaCarrinho extends StatefulWidget {
  TelaCarrinho({
    Key? key,
  }) : super(key: key);

  @override
  _TelaCarrinhoState createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  ServicosPlano _servicosPlano = ServicosPlano();
  ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
  ControladorPesquisaProdutos controladorPesquisaProdutos =
      ControladorPesquisaProdutos();
  ControladorPesquisaAluno controladorPesquisaAluno =
      ControladorPesquisaAluno();
  ControladorPesquisaPlanos controladorPesquisaPlanos =
      ControladorPesquisaPlanos();
  ScrollController scrollController = ScrollController();
  final textController = TextEditingController();
  double total = 0;

  @override
  Widget build(BuildContext context) {
    double soma = 0;
    _controladorCarrinho.listaProdutos.forEach((element) {
      soma += element.valorFinal * element.quantidade;
      total = soma;
      _controladorCarrinho.totalProdutos = total;
    });
    _controladorCarrinho.numProd.value =
        _controladorCarrinho.listaProdutos.length;
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:
                new Icon(Icons.arrow_back_ios, color: Colors.black, size: 24)),
        backgroundColor: Colors.white,
        title: Text(
          "NOVA VENDA",
          style: TextStyle(
              fontFamily: "NunitoSans", fontSize: 16, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              BotaoPesquisaAluno(
                  aluno: _controladorCarrinho.aluno,
                  context: context,
                  controladorPesquisaAluno: controladorPesquisaAluno,
                  textController: textController,
                  onTap: (aluno) {
                    Navigator.pop(context);
                    setState(() {
                      _controladorCarrinho.aluno = aluno;
                    });
                  }),
              Container(
                padding: EdgeInsets.all(2),
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 18, bottom: 10),
                        child: Text(
                          "Plano",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "NunitoSans",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0380E3)),
                        ),
                      ),
                      if (_controladorCarrinho.plano != null)
                        CardPlano(plano: _controladorCarrinho.plano),
                      Container(
                        child: Row(
                          mainAxisAlignment: _controladorCarrinho.plano != null
                              ? MainAxisAlignment.spaceAround
                              : MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: _controladorCarrinho.plano != null
                                  ? null
                                  : EdgeInsets.symmetric(horizontal: 17),
                              width: _controladorCarrinho.plano != null
                                  ? MediaQuery.of(context).size.width * 0.45
                                  : MediaQuery.of(context).size.width - 38,
                              height: 50,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  primary: Color(0XFF0380E3),
                                ),
                                icon: _controladorCarrinho.plano == null
                                    ? Icon(Icons.add_rounded)
                                    : Icon(Icons.autorenew_rounded),
                                onPressed: () {
                                  DialogoBusca.dialogoBuscaPlanos(
                                      context,
                                      _controladorCarrinho,
                                      controladorPesquisaPlanos,
                                      textController, (plano) {
                                    Navigator.pop(context);
                                    setState(() {
                                      _controladorCarrinho.plano = plano;
                                    });
                                  });
                                },
                                label: Text(
                                  _controladorCarrinho.plano == null
                                      ? "NOVO PLANO"
                                      : "ALTERAR PLANO",
                                  style: TextStyle(
                                      fontFamily: "NunitoSans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            if (_controladorCarrinho.plano != null)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: 50,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    primary: Colors.red,
                                  ),
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _controladorCarrinho.plano = null;
                                    setState(() {});
                                  },
                                  label: Text(
                                    _controladorCarrinho.plano == null
                                        ? "NOVO PLANO"
                                        : "EXCLUIR PLANO",
                                    style: TextStyle(
                                        fontFamily: "NunitoSans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffe4e5e6),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                          color: Color(0xfffafafa),
                        ),
                        // child: Container(
                        //   width: 166,
                        //   height: 50,
                        //   child: ElevatedButton.icon(
                        //       icon: Icon(Icons.autorenew_rounded,
                        //           color: Color.fromRGBO(27, 65, 102, 1)),
                        //       onPressed: () {},
                        //       style: ButtonStyle(
                        //           shape: MaterialStateProperty.all<
                        //                   RoundedRectangleBorder>(
                        //               RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(8),
                        //           )),
                        //           backgroundColor:
                        //               MaterialStateProperty.all<Color>(
                        //                   Colors.white)),
                        //       label: Text('RENOVAÇÃO',
                        //           style: TextStyle(
                        //             color: Color.fromRGBO(27, 65, 102, 1),
                        //             fontFamily: "NunitoSans",
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.bold,
                        //           ))),
                        // ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        indent: 15,
                        endIndent: 15,
                        color: Colors.grey[600],
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 18),
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
                                icon: Icon(Icons.add_rounded,
                                    color: Colors.white),
                                onPressed: () {
                                  DialogoBusca.dialogoBuscaProdutos(
                                      context,
                                      controladorPesquisaProdutos,
                                      textController, () {
                                    controladorPesquisaProdutos =
                                        new ControladorPesquisaProdutos();
                                    Navigator.pop(context);
                                    setState(() {});
                                  }, () {
                                    controladorPesquisaProdutos =
                                        new ControladorPesquisaProdutos();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                    top: 20,
                                  ),
                                  child: Text(
                                    "Nome",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "NunitoSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Qtd",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "NunitoSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 24),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: 84,
                                    child: Text(
                                      "Valor",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "NunitoSans",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount:
                                  _controladorCarrinho.listaProdutos.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Produto produto =
                                    _controladorCarrinho.listaProdutos[index];
                                return GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (builder) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight:
                                                      Radius.circular(16)),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 25),
                                              child: ProdutoWidget(
                                                  produto: produto,
                                                  adicionarUm: () {},
                                                  removerUm: () {
                                                    if (produto.quantidade ==
                                                        1) {
                                                      _controladorCarrinho
                                                          .listaProdutos
                                                          .remove(produto);
                                                      _controladorCarrinho
                                                              .numProd.value =
                                                          _controladorCarrinho
                                                              .listaProdutos
                                                              .length;
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    }
                                                  }),
                                            ),
                                          );
                                        }).whenComplete(() => setState(() {}));
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 16,
                                          top: 20,
                                        ),
                                        child: Container(
                                          width: 210,
                                          child: Text(
                                            "${produto.descricao}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "NunitoSans",
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 20,
                                          child: Text(
                                            "${produto.quantidade}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "NunitoSans",
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 20),
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          width: 70,
                                          child: Text(
                                            r"R$ " +
                                                "${produto.valorFinal.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "NunitoSans",
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            ),
                            Divider(
                              indent: 13,
                              endIndent: 13,
                              color: Colors.grey[600],
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("TOTAL",
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  Text(
                                      " R\$ ${_controladorCarrinho.totalProdutos.toStringAsFixed(2)}  ",
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 17),
        height: 77,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
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
              onPressed: _controladorCarrinho.aluno != null &&
                      (_controladorCarrinho.plano != null ||
                          (_controladorCarrinho.listaProdutos.isNotEmpty))
                  ? () {
                      if (_controladorCarrinho.plano != null) {
                        UtilCarregamento.exibirCarregamento(context);
                        _servicosPlano
                            .fecharVenda(_controladorCarrinho.plano!.codigo)
                            .then((plano) {
                          _controladorCarrinho.plano!.nrParcelas =
                              plano.nrParcelas;
                          _controladorCarrinho.plano!.valorFinal =
                              plano.valorFinal;
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, "/telaFechamentoVenda");
                        });
                      } else
                        Navigator.pushNamed(
                            context, "/telaFechamentoVendaProdutos");
                    }
                  : null,
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
        ),
      ),
    );
  }
}

class CardPlano extends StatelessWidget {
  final Plano? plano;
  const CardPlano({Key? key, required this.plano}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Descrição: ",
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w800,
                              fontSize: 12))),
                  Row(children: [
                    Container(
                      width: 220,
                      child: Text(
                        plano!.descricao,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: "NunitoSans",
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Text("Valor Mensalidade",
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w800,
                              fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("R\$  ${plano!.valorPlanoMensal.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 19, right: 19),
                  ),
                  Row(
                    children: [
                      Text("Fidelidade",
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w800,
                              fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("${plano!.fidelidadeDuracaoPlano} MESES ",
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 19, right: 19),
                  ),
                  Row(
                    children: [
                      Text("Taxa de Adesão",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'NunitoSans',
                              fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("R\S  ${plano!.taxaAdesao.toStringAsFixed(2)}",
                          style:
                              TextStyle(fontFamily: 'NunitoSans', fontSize: 12))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 19, right: 19),
                  ),
                  Row(
                    children: [
                      Text("Anuidade",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'NunitoSans',
                              fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("${plano!.valorAnuidade.toStringAsFixed(2)}",
                          style:
                              TextStyle(fontFamily: 'NunitoSans', fontSize: 12))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
