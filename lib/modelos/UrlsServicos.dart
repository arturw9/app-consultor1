import 'dart:convert';

class UrlsServicos {
  String? alunoMsUrl;
  String? loginMsUrl;
  String? colaboradorMsUrl;
  String? graduacaoMsUrl;
  String? treinoApiUrl;
  String? treinoUrl;
  String? loginAppUrl;
  String? oamdUrl;
  String? zwUrl;
  String? personagemMsUrl;
  String? autenticacaoUrl;
  String? frontPersonal;
  String? planoMsUrl;
  String? produtoMsUrl;
  String? relatorioFull;
  String? sinteticoMsUrl;
  String? pactoPayDashUrl;
  String? cadastroAuxiliarUrl;
  UrlsServicos({
    this.alunoMsUrl,
    this.loginMsUrl,
    this.colaboradorMsUrl,
    this.graduacaoMsUrl,
    this.treinoApiUrl,
    this.treinoUrl,
    this.loginAppUrl,
    this.oamdUrl,
    this.zwUrl,
    this.personagemMsUrl,
    this.autenticacaoUrl,
    this.frontPersonal,
    this.planoMsUrl,
    this.produtoMsUrl,
    this.relatorioFull,
    this.sinteticoMsUrl,
    this.pactoPayDashUrl,
    this.cadastroAuxiliarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'alunoMsUrl': alunoMsUrl,
      'loginMsUrl': loginMsUrl,
      'colaboradorMsUrl': colaboradorMsUrl,
      'graduacaoMsUrl': graduacaoMsUrl,
      'treinoApiUrl': treinoApiUrl,
      'treinoUrl': treinoUrl,
      'loginAppUrl': loginAppUrl,
      'oamdUrl': oamdUrl,
      'zwUrl': zwUrl,
      'personagemMsUrl': personagemMsUrl,
      'autenticacaoUrl': autenticacaoUrl,
      'frontPersonal': frontPersonal,
      'planoMsUrl': planoMsUrl,
      'produtoMsUrl': produtoMsUrl,
      'relatorioFull': relatorioFull,
      'sinteticoMsUrl': sinteticoMsUrl,
      'pactoPayDashUrl': pactoPayDashUrl,
      'cadastroAuxiliarUrl': cadastroAuxiliarUrl,
    };
  }

  factory UrlsServicos.fromMap(Map<String, dynamic> map) {
    return UrlsServicos(
      alunoMsUrl: map['alunoMsUrl'],
      loginMsUrl: map['loginMsUrl'],
      colaboradorMsUrl: map['colaboradorMsUrl'],
      graduacaoMsUrl: map['graduacaoMsUrl'],
      treinoApiUrl: map['treinoApiUrl'],
      treinoUrl: map['treinoUrl'],
      loginAppUrl: map['loginAppUrl'],
      oamdUrl: map['oamdUrl'],
      zwUrl: map['zwUrl'],
      personagemMsUrl: map['personagemMsUrl'],
      autenticacaoUrl: map['autenticacaoUrl'],
      frontPersonal: map['frontPersonal'],
      planoMsUrl: map['planoMsUrl'],
      produtoMsUrl: map['produtoMsUrl'],
      relatorioFull: map['relatorioFull'],
      sinteticoMsUrl: map['sinteticoMsUrl'],
      pactoPayDashUrl: map['pactoPayDashUrl'],
      cadastroAuxiliarUrl: map['cadastroAuxiliarUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UrlsServicos.fromJson(String source) =>
      UrlsServicos.fromMap(json.decode(source)['content']['serviceUrls']);
}
