import 'dart:ui';
import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';

class TelaPagamento extends StatefulWidget {
  TelaPagamento({Key? key}) : super(key: key);

  @override
  _TelaPagamentoState createState() => _TelaPagamentoState();
}

ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
Usuario usuario = GetIt.I.get<ControladorUsuario>().usuario;

ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

class _TelaPagamentoState extends State<TelaPagamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PAGAMENTO",
          style: TextStyle(fontSize: 16, fontFamily: 'NunitoSans'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 90,
                width: double.infinity,
                color: Colors.transparent,
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Color(0XFF28AB45),
                        borderRadius: BorderRadius.all(
                          const Radius.circular(30.0),
                        )),
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Icon(Icons.check, color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  "Venda concluída",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'NunitoSans'),
                                ),
                              ),
                            ),
                          ]),
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pagamento",
                        style: TextStyle(
                          color: Color(0XFF0380E3),
                          fontSize: 18,
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                              "Se o aluno já tiver um cartão cadastrado, a venda será cobrada no próximo ciclo da academia. Caso seja necessário cadastrar um cartão, clique no botão abaixo e compartilhe o link para o aluno cadastrar o cartão no sistema. ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'NunitoSans'),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                height: 50,
                width: 500,
                child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.send_outlined,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      size: 18,
                    ),
                    onPressed: () {
                      // K é a chave que retorna na autenticação, UN é o codigo da empresa e CLIENTE é o código do cliente
                      Share.share(
                          'https://vendas.online.sistemapacto.com.br/pagamento?un=${_controladorUsuario.usuario.key}&k=${_controladorUsuario.usuario.token}&cliente=${_controladorCarrinho.aluno!.codigo}');
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0XFF0380E3))),
                    label: Text(' ENVIAR LINK DE CADASTRO',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: "NunitoSans",
                          fontSize: 14,
                        ))),
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text(
                          "Resumo da venda",
                          style: TextStyle(
                            color: Color(0XFF0380E3),
                            fontSize: 18,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 52,
                                backgroundImage:
                                    _controladorCarrinho.aluno!.imageUri == null
                                        ? null
                                        : NetworkImage(_controladorCarrinho
                                            .aluno!.imageUri
                                            .toString()),
                                child:
                                    _controladorCarrinho.aluno!.imageUri == null
                                        ? SvgPicture.asset(
                                            "assets/images/fotoPadrao.svg",
                                            allowDrawingOutsideViewBox: true,
                                            height: 160,
                                          )
                                        : null,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        top: 20,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Text(
                                          _controladorCarrinho.aluno!.nome
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "NunitoSans",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Matrícula: ${_controladorCarrinho.aluno!.matricula}",
                                      //   "Matrícula: ${_controladorCarrinho.plano!.modalidades[0].codigo}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Text(
                                "Total do contrato",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Spacer(),
                              if (_controladorCarrinho.plano != null)
                                Text(
                                  " R\$ ${_controladorCarrinho.plano!.valorFinal!.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              Text(
                                "Produtos",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Spacer(),
                              Text(
                                  " R\$ ${_controladorCarrinho.totalProdutos.toStringAsFixed(2)}  ",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 500,
                          color: Colors.transparent,
                          child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: new BoxDecoration(
                                  color: Color(0XFF6F747B),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Row(children: [
                                  Text(
                                    "TOTAL",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'NunitoSans'),
                                  ),
                                  Spacer(),
                                  Text(
                                    _controladorCarrinho.plano != null
                                        ? "R\$ ${(_controladorCarrinho.totalProdutos + _controladorCarrinho.plano!.valorFinal!).toStringAsFixed(2)}"
                                        : "R\$ ${_controladorCarrinho.totalProdutos.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'NunitoSans',
                                    ),
                                  ),
                                ]),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
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
                    ButtonVoltarInicio(
                      value: "VOLTAR PARA O INÍCIO",
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/telaInicio");
                        GetIt.I.get<ControladorCarrinho>().limparCarrinho();
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
