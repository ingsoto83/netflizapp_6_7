import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _mAuth = FirebaseAuth.instance;
  String? correo = '';
  String? password ='';
  bool passVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Iniciar Sesión",),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FlutterLogo(size: 150,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: TextFormField(
                validator: (value) => value!.isEmpty ? 'Escribe tu correo electrónico...!' : null,
                onSaved: (value)=> correo = value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Correo Electrónico",
                  labelStyle: TextStyle(color: Colors.blue),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                      gapPadding: 10
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                      gapPadding: 10
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child:TextFormField(
                validator: (value) => value!.isEmpty ? 'Escribe tu contraseña...!' : value.length < 6 ? 'Contraseña debe ser mínimo de 8 cars...!' : null,
                onSaved: (value)=> password = value,
                obscureText: passVisible ? false : true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          passVisible = !passVisible;
                        });
                      },
                      child: Icon(passVisible ? Icons.visibility_off : Icons.visibility)
                  ),
                  labelText: "Contraseña",
                  labelStyle: TextStyle(color: Colors.blue),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                      gapPadding: 10
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                      gapPadding: 10
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){
                      _formKey.currentState!.reset();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, foregroundColor: Colors.white),
                    child: Text("Limpiar")
                ),
                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        login();
                        /*ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              duration: Duration(seconds: 3),
                              showCloseIcon: true,
                              backgroundColor: Colors.green,
                              content: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text("Información guardada con éxito!!!"))
                                ],
                              )
                          )
                        );*/
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> TravelPlacePage()));
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
                    child: Text("Guardar")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void login() async{
  try {
      final credential = await _mAuth.signInWithEmailAndPassword(
        email: correo??'',
        password: password??''
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
  }
}
}

