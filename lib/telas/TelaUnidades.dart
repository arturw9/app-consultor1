import 'package:app_consultor/componentes/PesquisaBarra.dart';
import 'package:app_consultor/controladores/ControladorCarrinho.dart';
import 'package:app_consultor/controladores/ControladorLancarDiaria.dart';
import 'package:app_consultor/controladores/ControladorPagamento.dart';
import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/telas/TelaInicio.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_consultor/modelos/Unidade.dart';
import 'package:get_it/get_it.dart';
import 'package:diacritic/diacritic.dart';

ControladorUsuario _controlador = GetIt.I.get<
    ControladorUsuario>(); //chama o controlador para obter dados do usuario e listar as unidades

class TelaUnidades extends StatefulWidget {
  TelaUnidades({
    Key? key,
  }) : super(key: key);

  @override
  _TelaUnidadesState createState() => _TelaUnidadesState();
}

class _TelaUnidadesState extends State<TelaUnidades> {
  // List de API de Unidades FICA AQUI EM CIMA
  final List<Unidade> _listaUnidades = _controlador.usuario.listaUnidades!;
  final textController = TextEditingController();

  List<Unidade> _listaFiltrada = [];
  @override
  initState() {
    _listaFiltrada = _listaUnidades;
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _runFilter(String texto, Function() terminouPesquisar) {
    if (texto.isEmpty) {
      _listaFiltrada = _listaUnidades;
    } else {
      _listaFiltrada = _listaUnidades
          .where((empresa) => removeDiacritics(empresa.nome.toLowerCase())
              .contains(removeDiacritics(texto.toLowerCase())))
          .toList();
    }
    terminouPesquisar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(2, 106, 188, 1),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              PesquisaBarra(
                  textController: textController,
                  onSubmitted: (value) => _runFilter(value!, () {
                        setState(() {});
                      }),
                  onChanged: (value) => _runFilter(value!, () {
                        setState(() {});
                      }),
                  hintText: 'Busque pelo nome da unidade'),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Selecione uma unidade:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NunitoSans",
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: _listaFiltrada.isNotEmpty
                    ? ListView.builder(
                        itemCount: _listaFiltrada.length,
                        itemBuilder: (context, index) {
                          final Unidade unidade = _listaUnidades[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            height: 50,
                            child: ListTile(
                              onTap: () {
                                limparGetIt();
                                UtilCarregamento.exibirCarregamento(context);
                                _controlador.usuario.unidade = unidade;
                                _controlador.autenticarUsuario(
                                    erro: (mensagem) {
                                  Navigator.pop(context);
                                  UtilDialog.exibirInformacoes(context,
                                      titulo: "Ops!", mensagem: mensagem);
                                }, sucesso: () {
                                  _controlador.estaDentroDoHorario(
                                      dentroHorario: (() {
                                    limparGetIt();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        //retira as telas anteriores
                                        MaterialPageRoute(
                                            builder: (context) => TelaInicio()),
                                        (Route<dynamic> route) => false);
                                  }));
                                });
                              },
                              title: Text(
                                _listaFiltrada[index].nome,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(2, 106, 188, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        })
                    : const Text(
                        'Nenhum resultado encontrado',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void limparGetIt() {
    GetIt.I.unregister<ControladorLancarDiaria>();
    GetIt.I.registerLazySingleton<ControladorLancarDiaria>(
        () => ControladorLancarDiaria());
    GetIt.I.unregister<ControladorCarrinho>();
    GetIt.I.registerLazySingleton<ControladorCarrinho>(
        () => ControladorCarrinho());
    GetIt.I.unregister<ControladorPagamento>();
    GetIt.I.registerLazySingleton<ControladorPagamento>(
        () => ControladorPagamento());
  }
}
