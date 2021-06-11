import 'package:flutter/material.dart';
import 'package:integradoras_setimo/screen/screen_doacoesfeitas.dart';
import 'package:integradoras_setimo/screen/screen_estoque.dart';
import 'package:integradoras_setimo/widgets/botao.dart';
import 'package:integradoras_setimo/widgets/images.dart';

class ScreenInicio extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            imagem(),
            botao(context, "ESTOQUE", Estoque()),
            SizedBox(height: 25),
            botao(context, "DOAÇÕES", DoacaoFeitas()),
            Container(),
          ],
        ),
      ),
    );
  }
}
