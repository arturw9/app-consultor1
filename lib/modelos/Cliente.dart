import 'dart:convert';

class Cliente {
  String? imageUri;
  String? nome;
  String? cpf;
  String? celular;
  String? email;
  DateTime? dataNascimento;
  String? cep;
  int? empresa;

  Cliente(
      {this.imageUri,
      this.nome,
      this.cpf,
      this.celular,
      this.email,
      this.dataNascimento,
      this.cep,
      this.empresa});

  Map<String, dynamic> toMap() {
    return {
      'imageUri': imageUri,
      'nome': nome,
      'cpf': cpf,
      'celular': celular,
      'email': email,
      'dataNascimento': dataNascimento?.millisecondsSinceEpoch,
      'cep': cep,
      'empresa': empresa,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      imageUri: map['imageUri'],
      nome: map['nome'],
      cpf: map['cpf'],
      celular: map['celular'],
      email: map['email'],
      dataNascimento:
          DateTime.fromMillisecondsSinceEpoch(map['dataNascimento']),
      cep: map['cep'],
      empresa: map['empresa'],
    );
  }

  dynamic toJson() => json.encode(toMap());

  factory Cliente.fromJson(String source) =>
      Cliente.fromMap(json.decode(source));
}
