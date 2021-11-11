import 'dart:convert';

class RetornoAutenticacao {
  String token;
  RetornoAutenticacao({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory RetornoAutenticacao.fromMap(Map<String, dynamic> map) {
    return RetornoAutenticacao(
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoAutenticacao.fromJson(String source) =>
      RetornoAutenticacao.fromMap(jsonDecode(source)['content']);
}
