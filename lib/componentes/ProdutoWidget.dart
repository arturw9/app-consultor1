import 'package:flutter/material.dart';
import 'package:app_consultor/modelos/Produto.dart';

class ProdutoWidget extends StatefulWidget {
  final Produto produto;
  final Function adicionarUm;
  final Function removerUm;
  const ProdutoWidget({
    Key? key,
    required this.produto,
    required this.adicionarUm,
    required this.removerUm,
  }) : super(key: key);

  @override
  _ProdutoWidgetState createState() => _ProdutoWidgetState();
}

class _ProdutoWidgetState extends State<ProdutoWidget> {
  void _incrementCounter() {
    setState(() {
      widget.adicionarUm();
      widget.produto.quantidade++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (widget.produto.quantidade > 0) {
        widget.removerUm();
        widget.produto.quantidade--;
      } else {
        widget.produto.quantidade = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.53,
            child: Column(
              //    mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.produto.descricao}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\R\$ ${(widget.produto.valorFinal).toStringAsFixed(2)}',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\cod. ${widget.produto.codigo}',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.42,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  color: Colors.grey,
                  tooltip: 'Decrement',
                  onPressed: _decrementCounter,
                  icon: Icon(
                    (Icons.remove),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    '${widget.produto.quantidade}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'NunitoSans',
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.blue,
                  tooltip: 'Increment',
                  onPressed: _incrementCounter,
                  icon: Icon(
                    (Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProdutoDiariaWidget extends StatelessWidget {
  final Produto produto;
  const ProdutoDiariaWidget({Key? key, required this.produto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.53,
            child: Column(
              //    mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${produto.descricao}',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\R\$ ${(produto.valorFinal).toStringAsFixed(2)}',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\cod. ${produto.codigo}',
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
