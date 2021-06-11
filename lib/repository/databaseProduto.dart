import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:integradoras_setimo/models/produto.dart';

class ProdutoRepository{
  CollectionReference collection = Firestore.instance.collection("produtos");

  Stream<QuerySnapshot> getStream(){
    return collection.snapshots();
  }

  Future<DocumentReference> addproduto(Produto produto){
    return collection.add(produto.toJson());
  }
  
  updateproduto(Produto produto) async {
    await collection.document(produto.reference.documentID).updateData(produto.toJson());
  }

  deleteproduto(Produto produto) async {
    await collection.document(produto.reference.documentID).delete();
  }
}