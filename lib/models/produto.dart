import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String produtoID;
  String nome;
  int quantidade;
  DocumentReference reference;

  Produto({this.produtoID, this.nome, this.quantidade, this.reference});

  Produto.fromMap(Map<String, dynamic> map, {this.reference})
    : produtoID = map['produtoID'],
      nome = map['nome'],
      quantidade = map['quantidade'];

  Produto.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference:snapshot.reference);

  Map<String, dynamic> toJson() => _ProdutoToJson(this);

}

Map<String, dynamic> _ProdutoToJson(Produto instance) => <String, dynamic>{
  'produtoID': instance.produtoID,
  'nome': instance.nome,
  'quantidade': instance.quantidade,
};