import 'dart:convert';

import 'package:app_consultor/modelos/Unidade.dart';

class RetornoApiOAMD {
  String key;
  String nome;
  String urlFoto;
  String userName;
  String codigoColaborador;

  List<Unidade> listaUnidades;
  RetornoApiOAMD({
    required this.key,
    required this.nome,
    required this.urlFoto,
    required this.userName,
    required this.listaUnidades,
    required this.codigoColaborador,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'nome': nome,
      'urlFoto': urlFoto,
      'userName': userName,
      'codigoColaborador': codigoColaborador,
    };
  }

  factory RetornoApiOAMD.fromMap(
      Map<String, dynamic> map, Iterable<Unidade> listMap) {
    return RetornoApiOAMD(
      key: map['key'],
      nome: map['nome'],
      urlFoto: map['urlFoto'],
      userName: map['userName'],
      codigoColaborador: map['codigo'].toString(),

      listaUnidades: listMap.toList(),
      //.map<Unidade>((resp)=> Unidade.fromMap(resp)
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiOAMD.fromJson(String source) {
    dynamic responseMap = jsonDecode(source);
    dynamic returnMap = jsonDecode(responseMap['return']);
    dynamic listMap = returnMap['grupo'][0]['empresas'][0]['unidades']
        .map<Unidade>((resp) => Unidade.fromMap(resp));
    return RetornoApiOAMD.fromMap(returnMap['grupo'][0], listMap);
  }
}
