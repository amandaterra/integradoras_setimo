import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:integradoras_setimo/models/produto.dart';
import 'package:integradoras_setimo/repository/databaseProduto.dart';
import 'package:integradoras_setimo/screen/screen_doacao.dart';
import 'package:integradoras_setimo/widgets/botao.dart';
import 'package:integradoras_setimo/widgets/texto.dart';

class Estoque extends StatefulWidget {
  @override
  _EstoqueState createState() => _EstoqueState();
}

class _EstoqueState extends State<Estoque> {
  ProdutoRepository repository = ProdutoRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Estoque",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(child: _carregarListaProdutos()),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _botaoAdicionar(),
              SizedBox(height: 15),
              botao(context, "Doar", ScreenDoacao()),
              SizedBox(height: 15),
            ],
          ),
          Container(),
        ],
      ),
    );
  }

  Widget _carregarListaProdutos() {
    return StreamBuilder<QuerySnapshot>(
      stream: repository.getStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              CircularProgressIndicator(
                color: Colors.green[900],
              ),
              Text("Procurando dados!"),
            ],
          );
        }
        return _listaProdutos(snapshot.data.documents);
      },
    );
  }

  Widget _listaProdutos(List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _item(data)).toList(),
    );
  }

  Widget _item(DocumentSnapshot snapshot) {
    final produto = Produto.fromSnapshot(snapshot);

    if (produto == null) return Container();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(width: 2.5),
      ),
      child: ListTile(
        title: Text(produto.nome),
        subtitle: Text("Quantidade: ${produto.quantidade.toString()}"),
        trailing: GestureDetector(
          child: Icon(Icons.edit, color: Colors.yellow[900]),
          onTap: () async {
            //EDITA O PRODUTO
            TextEditingController quantidadeController =
                new TextEditingController();
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(produto.nome),
                content: Row(
                  children: [
                    Text("Quantidade: "),
                    campoDeTexto(quantidadeController, "${produto.quantidade}"),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    child: Text("Confimar"),
                    onPressed: () {
                      setState(() {
                        produto.quantidade =
                            int.parse(quantidadeController.text);
                        repository.updateproduto(produto);
                      });
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(primary: Colors.yellow[900]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _botaoAdicionar() {
    TextEditingController _nomeProdutoController = new TextEditingController();
    TextEditingController _produtoIDController = new TextEditingController();
    TextEditingController _quantidadeController = new TextEditingController();

    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 10),
          FittedBox(fit: BoxFit.fitHeight, child: Text("Adicionar")),
          SizedBox(width: 10),
          Icon(Icons.arrow_forward_ios_rounded, size: 20),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        textStyle: TextStyle(fontSize: 18),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        minimumSize: Size(200, 60),
      ),
      onPressed: () async {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Criar um novo produto"),
            content: Container(
              height: 200,
              child: Column(
                children: [
                  campoDeTexto(_nomeProdutoController, "Nome do Produto:"),
                  campoDeTexto(_produtoIDController, "ID do Produto:"),
                  campoDeTexto(_quantidadeController, "Quantidade:"),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: Text("Confirmar"),
                onPressed: () {
                  Produto produto = new Produto(
                      nome: _nomeProdutoController.text,
                      produtoID: _produtoIDController.text,
                      quantidade: int.parse(_quantidadeController.text));
                  repository.addproduto(produto);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(primary: Colors.yellow[900]),
              ),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        );
      },
    );
  }
}
