import 'package:app_consultor/componentes/ButtonPadrao.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorPlano.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TelaDetalhePlano extends StatefulWidget {
  TelaDetalhePlano({Key? key}) : super(key: key);

  @override
  _TelaDetalhePlanoState createState() => _TelaDetalhePlanoState();
}

class _TelaDetalhePlanoState extends State<TelaDetalhePlano> {
  ControladorPlano _controladorPlano = GetIt.I.get<ControladorPlano>();
  ControladorCarrinho _controladorCarrinho = GetIt.I.get<ControladorCarrinho>();
  String str = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon:
                new Icon(Icons.arrow_back_ios, color: Colors.black, size: 24)),
        title: Text("DETALHES DO PLANO",
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 16,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          child: Text(
                            "${_controladorPlano.plano!.descricao}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: "NunitoSans"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Container(
                          width: 190,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(38)),
                          child: Center(
                            child: Text(
                              "R\$  ${_controladorPlano.plano!.valorPlanoMensal.toStringAsFixed(2)}  Mensal",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "NunitoSans",
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 150,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: Row(
                                  children: [
                                    Text(
                                      "Dados Básicos",
                                      style: TextStyle(
                                          color: Color(0XFF0380E3),
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: Row(
                                  children: [
                                    Text("Valor Mensalidade",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        "R\$  ${_controladorPlano.plano!.valorPlanoMensal.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 19, right: 19),
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
                                  Text(
                                      "${_controladorPlano.plano!.fidelidadeDuracaoPlano} MESES ",
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 19, right: 19),
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
                                  Text(
                                      "R\S  ${_controladorPlano.plano!.taxaAdesao.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontSize: 12))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 19, right: 19),
                              ),
                              if (_controladorPlano.plano!.valorAnuidade !=
                                  null)
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
                                    Text(
                                        "${_controladorPlano.plano!.valorAnuidade!.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontSize: 12))
                                  ],
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
                        borderRadius: BorderRadius.circular(8)),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(12),
                      title: Text("Modalidades",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _controladorPlano
                                      .plano!.modalidades.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Text("Modalidade",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                              "   ${_controladorPlano.plano!.modalidades[index].nome.toString()}  ",
                                              style: TextStyle(
                                                  fontFamily: 'NunitoSans',
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    );
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _controladorPlano
                                      .plano!.modalidades.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Text("Repetições na semana",
                                            style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12)),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                                "   ${_controladorPlano.plano!.modalidades[index].numeroVezes.toString() + "x"}  ",
                                                style: TextStyle(
                                                    fontFamily: 'NunitoSans',
                                                    fontSize: 12))),
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
                        borderRadius: BorderRadius.circular(8)),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(10),
                      title: Text("Horários",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Text("Horário",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12)),
                              SizedBox(
                                width: 5,
                              ),
                              Text("${_controladorPlano.plano!.horario}",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Row(children: [
                            Text(
                              "Valor",
                              style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "R\$ ${_controladorPlano.plano!.horarioValorEspecifico!.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'NunitoSans',
                                  fontWeight: FontWeight.w400),
                            )
                          ]),
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
                        borderRadius: BorderRadius.circular(8)),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(10),
                      title: Text("Produtos e Serviços",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Text("Nome",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  "${_controladorPlano.plano!.produtoDescricao}",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          child: Row(
                            children: [
                              Text("Valor no plano",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  "R\$  ${_controladorPlano.plano!.valorProdutoMensal.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          child: Row(
                            children: [
                              Text("Obrigatório",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  "${str = _controladorPlano.plano!.obrigatorio ? "SIM" : "NÃO"}",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
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
                        borderRadius: BorderRadius.circular(8)),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: EdgeInsets.all(10),
                      title: Text("Dados Contratuais",
                          style: TextStyle(
                              color: Color(0XFF0380E3),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Text("Percentual da multa de cancelamento",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  "R\$ ${_controladorPlano.plano!.percentualMultaCancelamento.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
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
                value: " ADICIONAR AO CARRINHO",
                onTap: () {
                  _controladorCarrinho.plano = _controladorPlano.plano;
                  Navigator.pushReplacementNamed(context, "/telaCarrinho");
                }),
          ),
        ),
      ),
    );
  }
}
