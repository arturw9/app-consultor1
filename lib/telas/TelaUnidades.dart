import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/telas/TelaInicio.dart';
import 'package:app_consultor/util/UtilCarregamento.dart';
import 'package:app_consultor/util/UtilDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_consultor/modelos/Unidade.dart';
import 'package:get_it/get_it.dart';

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
  var listaUnidades = _controlador.usuario.listaUnidades!.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(2, 106, 188, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Selecione uma unidade:",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "NunitoSans",
                color: Colors.white),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              child: Container(
                height: listaUnidades.length < 4
                    ? listaUnidades.length * 52
                    : 4, //muda o tamanho da lista de acordo com o numero de unidades(MAX:4)
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xff0380e3),
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 2,
                      color: Color.fromRGBO(2, 106, 188, 1),
                    ),
                    itemCount: listaUnidades.length,
                    itemBuilder: (context, index) {
                      final Unidade unidade = listaUnidades[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        height: 50,
                        child: ListTile(
                          onTap: () {
                            UtilCarregamento.exibirCarregamento(context);
                            _controlador.usuario.unidade = unidade;
                            _controlador.autenticarUsuario(erro: (mensagem) {
                              Navigator.pop(context);
                              UtilDialog.exibirInformacoes(context,
                                  titulo: "Ops!", mensagem: mensagem);
                            }, sucesso: () {
                              Navigator.of(context).pushAndRemoveUntil(//retira as telas anteriores
                                  MaterialPageRoute(
                                      builder: (context) => TelaInicio()),
                                  (Route<dynamic> route) => false);
                            });
                          },
                          title: Text(
                            unidade.nome,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(2, 106, 188, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
