import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/controladores/ControladorLancarDiaria.dart';
import 'package:app_consultor/controladores/ControladorPagamento.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:app_consultor/modelos/Venda.dart';
import 'package:app_consultor/servicos/ServicoVenda.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class TelaFechamentoDiaria extends StatefulWidget {
  TelaFechamentoDiaria({Key? key}) : super(key: key);

  @override
  _TelaFechamentoDiariaState createState() => _TelaFechamentoDiariaState();
}

class _TelaFechamentoDiariaState extends State<TelaFechamentoDiaria> {
  ControladorLancarDiaria _controladorDiaria =
      GetIt.I.get<ControladorLancarDiaria>();

  Usuario usuario = GetIt.I.get<ControladorUsuario>().usuario;
  ControladorLancarDiaria _controladorLancarDiaria =
      GetIt.I.get<ControladorLancarDiaria>();
  double totalProdutosPlano = 0;
  String str = "";

  var dataNascimento;

  get diaVencimento => null;

  get email => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("FECHAMENTO DA DIÁRIA",
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
                          backgroundImage: _controladorDiaria.aluno!.imageUri ==
                                  null
                              ? null
                              : NetworkImage(_controladorDiaria.aluno!.imageUri
                                  .toString()),
                          child: _controladorDiaria.aluno!.imageUri == null
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
                                _controladorDiaria.aluno!.nome.toString(),
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
                                "Matrícula: ${_controladorDiaria.aluno!.matricula}",
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
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Data de Início ",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        "${formatDate(_controladorLancarDiaria.lancamento!, [
                              dd,
                              '-',
                              mm,
                              '-',
                              yyyy
                            ])}",
                        style:
                            TextStyle(fontFamily: 'NunitoSans', fontSize: 16),
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
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Lançamento ",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        "${formatDate(_controladorLancarDiaria.dataInicio!, [
                              dd,
                              '-',
                              mm,
                              '-',
                              yyyy
                            ])}",
                        style:
                            TextStyle(fontFamily: 'NunitoSans', fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Descrição",
                              style: TextStyle(
                                color: Color(0XFF0380E3),
                                fontFamily: "NunitoSans",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16, right: 2, left: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Text(
                                  "${_controladorLancarDiaria.produto!.descricao}",
                                  // "XXXX XX",
                                  style: TextStyle(
                                    fontFamily: "NunitoSans",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Modalidade",
                              style: TextStyle(
                                color: Color(0XFF0380E3),
                                fontFamily: "NunitoSans",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16, right: 2, left: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: Text(
                                  "${_controladorDiaria.modalidade!.nome}",
                                  style: TextStyle(
                                    fontFamily: "NunitoSans",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
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
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 25, left: 13),
                                child: Text(
                                  "Valor da diária",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "NunitoSans",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 13, bottom: 25, right: 16),
                                child: Text(
                                  r"R$ " +
                                      "${_controladorLancarDiaria.produto!.valorFinal.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "NunitoSans",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(
                          //           bottom: 10, top: 10, left: 25),
                          //       child: Text(
                          //         "Desconto",
                          //         style: TextStyle(
                          //             color: Colors.black,
                          //             fontFamily: "NunitoSans",
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding:
                          //           const EdgeInsets.only(top: 10, right: 25),
                          //       child: Text(
                          //         "XX,XX",
                          //         style: TextStyle(
                          //             color: Colors.black,
                          //             fontFamily: "NunitoSans",
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.95,
                  color: Colors.transparent,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: new BoxDecoration(
                          color: Color(0XFF6F747B),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, right: 8, bottom: 8),
                                child: Text(
                                  "TOTAL",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'NunitoSans'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Text(
                                  r"R$ " +
                                      "${_controladorLancarDiaria.produto!.valorFinal.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "NunitoSans",
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ]),
                      )),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
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
                padding: const EdgeInsets.fromLTRB(24, 10, 10, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 16, left: 8, right: 2),
                          child: ButtonAlterarFechamentoVenda(
                            value: "ALTERAR",
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "/telaLancarDiaria");
                            },
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 16, left: 8),
                          child: ButtonConcluirFechamentoVenda(
                            value: "CONCLUIR",
                            onTap: () {
                              _controladorLancarDiaria.produto!.modalidade =
                                  _controladorLancarDiaria.modalidade!.codigo;

                              _controladorLancarDiaria.listaProdutos
                                  .add(_controladorLancarDiaria.produto!);
                              Venda venda = Venda(
                                  dataInicio: formatDate(
                                      _controladorLancarDiaria.dataInicio!,
                                      ["yyyy", '-', "mm", '-', "dd"]),
                                  dataLancamento: formatDate(
                                      _controladorLancarDiaria.lancamento!,
                                      ["yyyy", '-', "mm", '-', "dd"]),
                                  unidade: GetIt.I
                                      .get<ControladorUsuario>()
                                      .usuario
                                      .unidade!
                                      .codigo,
                                  plano: null,
                                  nome: _controladorLancarDiaria.aluno!.nome!,
                                  cpf: _controladorLancarDiaria.aluno!.cpf!,
                                  diaVencimento: null,
                                  nrVezesDividir: null,
                                  produtos:
                                      _controladorLancarDiaria.listaProdutos);
                              UtilCarregamento.exibirCarregamento(context);
                              ServicoVenda.concluirVenda(venda).then((value) {
                                GetIt.I.get<ControladorPagamento>().aluno =
                                    _controladorDiaria.aluno;

                                GetIt.I.get<ControladorPagamento>().total =
                                    _controladorDiaria.produto!.valorFinal;
                                GetIt.I.resetLazySingleton<
                                    ControladorLancarDiaria>();
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
                        ),
                      ],
                    ),
                    ButtonVoltarInicio(
                      value: "VOLTAR PARA O INÍCIO",
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/telaInicio");
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
