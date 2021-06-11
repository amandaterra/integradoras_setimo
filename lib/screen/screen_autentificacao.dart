import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:integradoras_setimo/screen/screen_inicio.dart';

class ScreenAutentication extends StatefulWidget {
  @override
  _ScreenAutenticationState createState() => _ScreenAutenticationState();
}

class _ScreenAutenticationState extends State<ScreenAutentication> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _email = new TextEditingController();
  TextEditingController _senha = new TextEditingController();

  Future signInEmailPasswd(String email, String passwd) async {
    try {
      final FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: passwd))
          .user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future createEmailPasswd(String email, String passwd) async {
    try {
      final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
              email: email, password: passwd))
          .user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.account_circle_rounded,
                color: Colors.yellow[900], size: 100),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                  labelText: "Digite seu email", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _senha,
              decoration: InputDecoration(
                  labelText: "Digite a senha", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            _botaoConectar(),
            _botaoCriarConta(),
          ],
        ),
      ),
    );
  }

  Widget _botaoConectar() {
    return ElevatedButton(
      child: Text("CONECTAR"),
      onPressed: () async {
        dynamic resultado = await signInEmailPasswd(_email.text, _senha.text);
        if (resultado != null)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScreenInicio()));
      },
      style: ElevatedButton.styleFrom(primary: Colors.yellow[900]),
    );
  }

  Widget _botaoCriarConta() {
    return ElevatedButton(
      child: Text("CRIAR CONTA", style: TextStyle(fontSize: 11.5)),
      onPressed: () {
        TextEditingController _emailC = TextEditingController();
        TextEditingController _senhaC = TextEditingController();
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("CRIANDO SUA CONTA",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                TextField(
                  controller: _emailC,
                  decoration: InputDecoration(
                      labelText: "Digite seu email",
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _senhaC,
                  decoration: InputDecoration(
                      labelText: "Digite a senha",
                      border: OutlineInputBorder()),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                child: Text("Confirmar"),
                onPressed: () {
                  createEmailPasswd(_emailC.text, _senhaC.text);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(primary: Colors.yellow[900]),
              ),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        );
      },
      style: ElevatedButton.styleFrom(primary: Colors.yellow[900]),
    );
  }
}
