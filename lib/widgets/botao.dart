import 'package:flutter/material.dart';

Widget botao(BuildContext context, String nome, proximaPagina) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => proximaPagina));
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 10),
        FittedBox(fit: BoxFit.fitHeight, child: Text(nome)),
        SizedBox(width: 10),
        Icon(Icons.arrow_forward_ios_rounded, size: 20),
      ],
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.black,
      textStyle: TextStyle(fontSize: 18),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      minimumSize: Size(200, 60),
    ),
  );
}
