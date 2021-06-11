import 'package:flutter/material.dart';

Widget campoDeTexto(TextEditingController controller, String label) {
  return Expanded(
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: '$label',
      ),
    ),
  );
}
