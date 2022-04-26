import 'dart:convert';
import 'HorarioAcesso.dart';
import 'Unidade.dart';

class Usuario {
  //Atributos
  String email;
  String senha;
  String? codigoColaborador;
  String? telefone;
  String? unidadeNome;
  String? token;
  String? userName;
  String? key;
  String? nome;
  String? urlFoto;
  List<HorarioAcesso>? horarioAcesso;
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
      this.codigoColaborador,
      this.unidade,
      this.horarioAcesso});

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
      'horarioAcesso': horarioAcesso,
      'listaUnidades': listaUnidades,
      'unidade': unidade,
      'codigoColaborador': codigoColaborador
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
        codigoColaborador: map['codigoColaborador'],
        urlFoto: map['urlFoto'],
        unidade: Unidade.fromJson(map['unidade']),
        listaUnidades: map['listaUnidades']
            .map<Unidade>((resp) => Unidade.fromMap(json.decode(resp)))
            .toList(),
        horarioAcesso: map['horarioAcesso']
            .map<HorarioAcesso>(
                (resp) => HorarioAcesso.fromMap(json.decode(resp)))
            .toList());
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));
}
