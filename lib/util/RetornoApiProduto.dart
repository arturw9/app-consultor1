import 'dart:convert';

import 'package:app_consultor/modelos/Produto.dart';

class RetornoApiProduto {
  int totalPages;
  List<Produto>? listaProdutos;
  RetornoApiProduto({
    required this.totalPages,
    this.listaProdutos,
  });

  Map<String, dynamic> toMap() {
    return {
      'listaProdutos': listaProdutos?.map((x) => x.toMap()).toList(),
    };
  }

  factory RetornoApiProduto.fromMap(Map<String, dynamic> map) {
    return RetornoApiProduto(
      totalPages: map['totalPages'],
      listaProdutos:
          List<Produto>.from(map['content']?.map((x) => Produto.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RetornoApiProduto.fromJson(String source) {
    return RetornoApiProduto.fromMap(json.decode(source));
  }
}
