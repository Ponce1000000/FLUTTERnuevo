import 'package:appjared/screens/llenado_screen.dart';
import 'package:flutter/material.dart';

class FormularioLogin extends StatefulWidget {
  const FormularioLogin({Key? key}) : super(key: key);

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final GlobalKey<FormState> _formularioestado = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formularioestado,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: TextFormField(
                validator: (value) {
                  if (!value!.contains("@")) {
                    return "El correo no es valido";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Password", border: InputBorder.none),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (!value!.contains("@")) {
                    return "El correo no es valido";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Username", border: InputBorder.none),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LlenadoScreen()),
                    );
                  },
                  child: Text("Sign In")),
            )
          ],
        ),
      ),
    );
  }
}
