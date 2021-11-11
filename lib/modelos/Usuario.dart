import 'dart:convert';

import 'Unidade.dart';

class Usuario {
  //Atributos
  String email;
  String senha;
  String? telefone;
  String? unidadeNome;
  String? token;
  String? userName;
  String? key;
  String? nome;
  String? urlFoto;
  List<Unidade>? listaUnidades;
  Unidade? unidade;

//Contrutores
  Usuario(
      {required this.email,
      required this.senha,
      this.telefone,
      this.unidadeNome,
      this.token,
      this.userName,
      this.key,
      this.nome,
      this.urlFoto,
      this.listaUnidades,
      this.unidade});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senha': senha,
      'telefone': telefone,
      'token': token,
      'userName': userName,
      'key': key,
      'nome': nome,
      'urlFoto': urlFoto,
      'listaUnidades': listaUnidades,
      'unidade': unidade
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
        email: map['email'],
        senha: map['senha'],
        telefone: map['telefone'],
        token: map['token'],
        userName: map['userName'],
        key: map['key'],
        nome: map['nome'],
        urlFoto: map['urlFoto'],
        unidade: Unidade.fromJson(map['unidade']),
        listaUnidades: map['listaUnidades']
            .map<Unidade>((resp) => Unidade.fromMap(json.decode(resp)))
            .toList());
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));
}
