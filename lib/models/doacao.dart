import 'package:integradoras_setimo/models/produto.dart';

class Doacao {
  String idDoacao;
  String identDoaca;
  List<int> quantidadeDoada;
  List<Produto> listProdutos;

  Doacao({this.idDoacao, this.identDoaca, this.quantidadeDoada, this.listProdutos});

  Doacao.fromJson(Map<String, dynamic> json){
    idDoacao = json['idDoacao'];
    identDoaca = json['identDoaca'];
    quantidadeDoada = json['quantidadeDoada'];
    listProdutos = json['listProdutos'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> doacao = new Map<String, dynamic>();
    doacao['idDoacao'] = this.idDoacao;
    doacao['identDoaca'] = this.identDoaca;
    doacao['quantidadeDoada'] = this.quantidadeDoada;
    doacao['listProdutos'] = this.listProdutos;
    return doacao;
  }

}