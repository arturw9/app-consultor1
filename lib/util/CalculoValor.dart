class CalculoValor {
  static double calcularValorPorOperacao(
      {required double valorBase,
      required double valorEspecifico,
      required double percentualDesconto,
      required String tipoOperacao,
      required String tipoValor}) {
    switch (tipoOperacao) {
      case "":
        return valorBase;
      case "EX":
        return valorEspecifico;
      case "RE":
        return tipoValor == 'PD'
            ? valorBase - (percentualDesconto / 100 * valorBase)
            : valorBase - valorEspecifico;
      case "AC":
        return tipoValor == 'PD'
            ? valorBase + (percentualDesconto / 100 * valorBase)
            : valorBase + valorEspecifico;

      default:
        return valorBase;
    }
  }
}
