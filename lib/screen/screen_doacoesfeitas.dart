import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:integradoras_setimo/models/doacao.dart';
import 'package:integradoras_setimo/models/produto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoacaoFeitas extends StatefulWidget {
  @override
  _DoacaoFeitasState createState() => _DoacaoFeitasState();
}

class _DoacaoFeitasState extends State<DoacaoFeitas> {
  Doacao ultimaDoacao = new Doacao(listProdutos: [],quantidadeDoada: []);
  int count = 0;

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var doacao = prefs.getString('doacao');

    if (doacao != null) {
      var decoded = jsonDecode(doacao);

      ultimaDoacao.idDoacao = decoded["idDoacao"];
      ultimaDoacao.identDoaca = decoded["identDoaca"];
      for (var quant in decoded["quantidadeDoada"]) {
        ultimaDoacao.quantidadeDoada.add(quant);
      }
      for (var item in decoded["listProdutos"]) {
        Produto produtoAux = Produto();
        produtoAux.nome = item["nome"];
        produtoAux.produtoID = item["produtoID"];
        produtoAux.quantidade = item["quantidade"];
        ultimaDoacao.listProdutos.add(produtoAux);
      }
      setState(() {
        ultimaDoacao = ultimaDoacao;
        count = ultimaDoacao.listProdutos.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Toque Solidário",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Ultima doação feita: ", style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          _itemUltimaDoacao(),
          Container(),
        ],
      ),
    );
  }

  Widget _itemUltimaDoacao() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(width: 2.5),
      ),
      elevation: 5.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            heightFactor: 1.87,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Text("Local da doação: ${ultimaDoacao.identDoaca}",
                  style: TextStyle(fontSize: 17)),
            ),
          ),
          Divider(
              color: Colors.black26,
              thickness: 1.0,
              height: 0,
              indent: 10,
              endIndent: 10),
          Container(
            height: 250,
            child: ListView.builder(
              itemCount: count,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow[900],
                  ),
                  child: ListTile(
                    title: Text("${ultimaDoacao.listProdutos[i].nome}",
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text("${ultimaDoacao.listProdutos[i].produtoID}",
                        style: TextStyle(color: Colors.white)),
                    trailing: Text(
                        "Quantidade doada: ${ultimaDoacao.quantidadeDoada[i]}",
                        style: TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
