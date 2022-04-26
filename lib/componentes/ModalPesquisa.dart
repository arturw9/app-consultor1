import 'dart:ui';

import 'package:app_consultor/componentes/ListaMolidades.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorPesquisaAlunos.dart';
import 'package:app_consultor/controladores/ControladorPesquisaPlanos.dart';
import 'package:app_consultor/controladores/ControladorPesquisaProdutos.dart';
import 'package:app_consultor/controladores/controladorPesquisaModalidades.dart';
import 'package:app_consultor/modelos/Aluno.dart';
import 'package:app_consultor/modelos/Modalidade.dart';
import 'package:app_consultor/modelos/Plano.dart';
import 'package:app_consultor/modelos/Produto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'ListaAlunos.dart';
import 'ListaPlanos.dart';
import 'ListaProdutos.dart';
import 'PesquisaBarra.dart';
import 'Situacao.dart';

class BotaoPesquisaAluno extends StatelessWidget {
  final Aluno? aluno;
  final BuildContext context;
  final ControladorPesquisaAluno controladorPesquisaAluno;
  final TextEditingController textController;
  final Function(Aluno aluno) onTap;
  const BotaoPesquisaAluno(
      {Key? key,
      required this.aluno,
      required this.context,
      required this.controladorPesquisaAluno,
      required this.textController,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return aluno != null
        ? CardAluno(
            onTap: () {
              DialogoBusca.dialogoBuscaAlunos(
                  context, controladorPesquisaAluno, textController, onTap);
            },
            aluno: aluno)
        : Container(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(0, 12),
                  blurRadius: 24,
                  color: Color(0xFFE4E5E6),
                ),
              ]),
              margin: EdgeInsets.symmetric(horizontal: 17),
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  primary: Color(0XFF0380E3),
                ),
                icon: Icon(Icons.person_add_alt_outlined),
                onPressed: () {
                  DialogoBusca.dialogoBuscaAlunos(
                      context, controladorPesquisaAluno, textController, onTap);
                },
                label: Text(
                  'SELECIONAR ALUNO',
                  style: TextStyle(
                      fontFamily: "NunitoSans",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          );
  }
}

class BotaoPesquisaAlunoDiaria extends StatelessWidget {
  final Aluno? aluno;
  final BuildContext context;
  final ControladorPesquisaAluno controladorPesquisaAluno;
  final TextEditingController textController;
  final Function(Aluno aluno) onTap;
  const BotaoPesquisaAlunoDiaria(
      {Key? key,
      required this.aluno,
      required this.context,
      required this.controladorPesquisaAluno,
      required this.textController,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return aluno != null
        ? CardAluno(
            onTap: () {
              DialogoBusca.dialogoBuscaAlunos(
                  context, controladorPesquisaAluno, textController, onTap);
            },
            aluno: aluno)
        : Row(
            children: [
              Container(
                width: 170,
                height: 50,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      primary: Color(0XFF0380E3),
                    ),
                    onPressed: () {
                      DialogoBusca.dialogoBuscaAlunos(context,
                          controladorPesquisaAluno, textController, onTap);
                    },
                    icon: Icon(Icons.search),
                    label: Text(
                      "BUSCAR ALUNO",
                      style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 170,
                height: 50,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      primary: Color(0XFFFAFAFA),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.add_rounded,
                        color: Color.fromRGBO(27, 65, 102, 1)),
                    label: Text("NOVO ALUNO",
                        style: TextStyle(
                          color: Color.fromRGBO(27, 65, 102, 1),
                          fontFamily: "NunitoSans",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))),
              )
            ],
          );
  }
}

class BotaoPesquisaModalidades extends StatelessWidget {
  final Modalidade? modalidade;
  final BuildContext context;
  final ControladorPesquisaModalidades controladorPesquisaModalidades;
  final TextEditingController textController;
  final Function(Modalidade modalidade) onTap;
  const BotaoPesquisaModalidades(
      {Key? key,
      required this.context,
      required this.textController,
      required this.onTap,
      required this.controladorPesquisaModalidades,
      this.modalidade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return modalidade != null
        ? CardModalidade(
            onTap: onTap,
            textController: textController,
            modalidade: modalidade,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
                color: Colors.transparent,
                height: 45,
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Selecione uma Modalidade",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "NunitoSans",
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            //Icons.autorenew_sharp
                            Icons.add_rounded,
                            color: Colors.black,
                            size: 25,
                          ),
                        ]),
                  ),
                  onPressed: () {
                    ControladorPesquisaModalidades controlador =
                        ControladorPesquisaModalidades();
                    DialogoBusca.dialogoBuscaModalidades(
                        context, controlador, textController, onTap);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFFFAFAFA),
                      side: BorderSide(width: 2, color: Color(0XFF0380E3))),
                )),
          );
  }
}

class DialogoBusca {
  static void dialogoBuscaAlunos(
    BuildContext context,
    ControladorPesquisaAluno controladorPesquisaAluno,
    TextEditingController textController,
    Function(Aluno aluno) onTap, {
    String? titulo,
    String? mensagem,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.85,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PesquisaBarra(
                    onClear: () => Navigator.of(context).pop(),
                    onSubmitted: (text) {
                      controladorPesquisaAluno.pesquisaAluno(
                          aluno: text.toString());
                    },
                    onChanged: (text) {
                      controladorPesquisaAluno.pesquisaAluno(
                          aluno: text.toString());
                    },
                    textController: textController),
                body: DraggableScrollableSheet(
                    initialChildSize: 1,
                    builder: (_, scrollController) {
                      return ListaAlunos(
                          onTap: onTap,
                          scrollController: scrollController,
                          controlador: controladorPesquisaAluno);
                    }),
              ),
            ),
          );
        });
  }

  static void dialogoBuscaModalidades(
    BuildContext context,
    ControladorPesquisaModalidades controladorModalidades,
    TextEditingController textController,
    Function(Modalidade modalidade) onTap, {
    String? titulo,
    String? mensagem,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.85,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PesquisaBarra(
                    onClear: () => Navigator.of(context).pop(),
                    onSubmitted: (text) {
                      controladorModalidades.pesquisaModalidade(
                          modalidade: textController.text);
                    },
                    onChanged: (text) {
                      controladorModalidades.pesquisaModalidade(
                          modalidade: textController.text);
                    },
                    textController: textController),
                body: DraggableScrollableSheet(
                    initialChildSize: 1,
                    builder: (_, scrollController) {
                      return ListaModalidades(
                        controlador: controladorModalidades,
                        onTap: onTap,
                      );
                    }),
              ),
            ),
          );
        });
  }

  static void dialogoBuscaPlanos(
    BuildContext context,
    ControladorCarrinho controladorCarrinho,
    ControladorPesquisaPlanos controladorPesquisaPlanos,
    TextEditingController textController,
    Function(Plano plano) onTap, {
    String? titulo,
    String? mensagem,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.85,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PesquisaBarra(
                    onClear: () => Navigator.of(context).pop(),
                    onSubmitted: (text) {
                      controladorPesquisaPlanos.pesquisaPlano(
                          plano: textController.text);
                    },
                    onChanged: (text) {
                      controladorPesquisaPlanos.pesquisaPlano(
                          plano: text.toString());
                    },
                    textController: textController),
                body: DraggableScrollableSheet(
                    initialChildSize: 1,
                    builder: (_, scrollController) {
                      return ListaPlanos(
                          onTap: onTap,
                          scrollController: scrollController,
                          controlador: controladorPesquisaPlanos);
                    }),
              ),
            ),
          );
        });
  }

  static void dialogoBuscaProdutos(
    BuildContext context,
    ControladorPesquisaProdutos controladorPesquisaProdutos,
    TextEditingController textController,
    Function(Produto proututo) ontap,
    Function onClose, //executa quando a modal é fechada apertando botão
    Function onComplete, //executa quando a modal é fechada sem apertar o botão
  ) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.85,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PesquisaBarra(
                    onClear: () => Navigator.of(context).pop(),
                    onSubmitted: (text) {
                      controladorPesquisaProdutos.pesquisaProdutos(
                          produto: textController.text);
                    },
                    onChanged: (text) {
                      controladorPesquisaProdutos.pesquisaProdutos(
                          produto: textController.text);
                    },
                    textController: textController),
                body: DraggableScrollableSheet(
                    initialChildSize: 1,
                    builder: (_, scrollController) {
                      return ListaProdutos(
                          onTap: ontap,
                          onClose: onClose,
                          scrollController: scrollController,
                          controlador: controladorPesquisaProdutos);
                    }),
              ),
            ),
          );
        }).whenComplete(() => onComplete());
  }
}

class CardAluno extends StatelessWidget {
  final Function() onTap;
  final Aluno? aluno;
  const CardAluno({
    Key? key,
    required this.onTap,
    required this.aluno,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                backgroundImage: aluno!.imageUri == null
                    ? null
                    : NetworkImage(aluno!.imageUri.toString()),
                child: aluno!.imageUri == null
                    ? SvgPicture.asset("assets/images/fotoPadrao.svg")
                    : null),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        aluno!.nome.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    InkWell(
                        child: Container(
                            height: 35,
                            width: 35,
                            child: Icon(Icons.swap_horiz)),
                        onTap: onTap)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Matrícula: ${aluno!.matricula}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.normal,
                          fontSize: 13),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    // Text(
                    //   "Último acesso: 00/00/00",
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontFamily: 'NunitoSans',
                    //       fontWeight: FontWeight.normal,
                    //       fontSize: 13),
                    // )
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textDirection: TextDirection.rtl,
                    children: [
                      if (aluno!.situacaoContrato != null)
                        Situacao(tipo: aluno!.situacaoContrato!),
                      if (aluno!.situacao != null)
                        Situacao(tipo: aluno!.situacao!),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardModalidade extends StatelessWidget {
  final dynamic Function(Modalidade modalidade) onTap;
  final Modalidade? modalidade;
  final TextEditingController textController;

  const CardModalidade(
      {Key? key,
      required this.onTap,
      required this.modalidade,
      required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          color: Colors.transparent,
          height: 45,
          child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        modalidade!.nome.toString(),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontFamily: "NunitoSans",
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.autorenew_sharp,
                        //Icons.add_rounded,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ]),
            ),
            onPressed: () {
              ControladorPesquisaModalidades controlador =
                  ControladorPesquisaModalidades();
              DialogoBusca.dialogoBuscaModalidades(
                  context, controlador, textController, onTap);
            },
            style: ElevatedButton.styleFrom(
                primary: Color(0XFFFAFAFA),
                side: BorderSide(width: 2, color: Color(0XFF2EC750))),
          )),
    );
  }
}
