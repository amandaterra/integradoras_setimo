import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integradoras_setimo/models/produto.dart';
import 'package:integradoras_setimo/models/doacao.dart';
import 'package:integradoras_setimo/repository/databaseProduto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenDoacao extends StatefulWidget {
  @override
  _ScreenDoacaoState createState() => _ScreenDoacaoState();
}

class _ScreenDoacaoState extends State<ScreenDoacao> {
  ProdutoRepository repositoryProduto = ProdutoRepository();
  Doacao doacao = Doacao(quantidadeDoada: []);
  TextEditingController _nomeLocal = new TextEditingController();
  List<Produto> listaP = [];

  _save() async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("doacao", jsonEncode(doacao));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Doação",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _row("Nome do local:", _nomeLocal),
          Expanded(child: _listaDeProdutos()),
          ElevatedButton(
            child: Text("Doar",style: TextStyle(fontSize: 18)),
            onPressed: () {
              setState(() {
                doacao.identDoaca = _nomeLocal.text;
                doacao.listProdutos = listaP;
                _save();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(primary: Colors.yellow[900]),
          ),
          SizedBox(height: 10),
          Container(),
        ],
      ),
    );
  }

  Widget _row(String titulo, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Text("Nome do local: ", style: TextStyle(fontSize: 18)),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listaDeProdutos() {
    //CADA PRODUTO DO FIREBASE
    Widget _item(DocumentSnapshot snapshot) {
      final produto = Produto.fromSnapshot(snapshot);
      TextEditingController _controller = TextEditingController();

      if (produto == null) return Container();

      return Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 2.5),
        ),
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child: ListTile(
            title: Text(produto.nome),
            subtitle: Text("Quantidade: ${produto.quantidade.toString()}"),
            trailing: Container(
              width: 100,
              height: 60,
              child: TextField(
                decoration: InputDecoration(labelText: "Qtd a ser doada:"),
                keyboardType: TextInputType.number,
                controller: _controller,
                onEditingComplete: () {
                  setState(() {
                    produto.quantidade -= int.parse(_controller.text);
                    repositoryProduto.updateproduto(produto);
                    doacao.quantidadeDoada.add(int.parse(_controller.text));
                    listaP.add(produto);
                  });
                },
              ),
            ),
          ),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: repositoryProduto.getStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return ListView(
          children: snapshot.data.documents.map((e) => _item(e)).toList(),
        );
      },
    );
  }
}
