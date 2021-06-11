import 'package:flutter/material.dart';

Widget imagem({double pixelBottom = 80, double pixelTop = 80}) {
  return Padding(
    padding: EdgeInsets.only(top: pixelTop, bottom: pixelBottom),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image.asset(
          "assets/intro.jpeg",
          fit: BoxFit.contain,
          height: 200,
        ),
      ),
    ),
  );
}
