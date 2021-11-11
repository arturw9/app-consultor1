import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Produto.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class TelaFechamentoVendaProdutos extends StatefulWidget {
  TelaFechamentoVendaProdutos({Key? key}) : super(key: key);

  @override
  _TelaFechamentoVendaProdutosState createState() =>
      _TelaFechamentoVendaProdutosState();
}

ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
Usuario usuario = GetIt.I.get<ControladorUsuario>().usuario;

class _TelaFechamentoVendaProdutosState
    extends State<TelaFechamentoVendaProdutos> {
  String str = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              "Matrícula: ${_controladorCarrinho.aluno!.matricula}",
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
              Padding(
                padding: EdgeInsets.only(bottom: 12),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Empresa ",
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "${usuario.unidade!.nome}",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
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
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 16),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Produtos",
              //         style: TextStyle(
              //             fontFamily: 'NunitoSans',
              //             fontWeight: FontWeight.w700,
              //             fontSize: 14)),
              //     Text(
              //         " R\$ ${_controladorCarrinho.totalProdutos.toStringAsFixed(2)}  ",
              //         style: TextStyle(
              //             fontFamily: 'NunitoSans',
              //             fontWeight: FontWeight.w700,
              //             fontSize: 14)),
              //   ],
              // ),
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
                              " R\$ ${_controladorCarrinho.totalProdutos.toStringAsFixed(2)}  ",
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
                height: 150,
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
                        Navigator.pushNamed(context, "/telaCarrinho");
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    ButtonConcluirFechamentoVenda(
                      value: "CONCLUIR",
                      onTap: () {
                        Navigator.pushNamed(context, "/telaPagamento");
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
