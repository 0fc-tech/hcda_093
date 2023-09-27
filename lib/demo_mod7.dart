
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const DemoFormWidget());
  }
}

class DemoFormWidget extends StatefulWidget {
  const DemoFormWidget({super.key});

  @override
  State<DemoFormWidget> createState() => _DemoFormWidgetState();
}

class _DemoFormWidgetState extends State<DemoFormWidget> {
  final textControllerEmail = TextEditingController();
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: textControllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "E-mail",
                          hintText: "john@kennedy.gov.com"),
                      validator: (valueEmail){
                        if(valueEmail == null || valueEmail.isEmpty == true){
                          return "Merci de compléter ce champ";
                        }
                        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z.]{2,6}$").hasMatch(valueEmail)){
                          return "Vérifier le format (ex: john@kennedy.gov)";
                        }
                        return null;
                      },
                  ),
                  Switch(

                      value: rememberMe,onChanged: (isEnabled){
                    setState(() {
                      rememberMe = !rememberMe;
                    });
                  }),
                  ElevatedButton(
                  onPressed: (){
                    print(textControllerEmail.text);
                    print(rememberMe);
                    if(_formKey.currentState?.validate() == true){
                      print("Formulaire correcte");

                    }else{
                      print("Formulaire incorrecte");
                    }

                  },
                  child: Text("Valider"))
              ],)
          ),
        ),
      ),
    );
  }

}









