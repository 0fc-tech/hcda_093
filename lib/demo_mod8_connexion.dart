import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                labelText: "E-mail",
                hintText: "john@kennedy.gov.com"),
          ),
          ElevatedButton(
              onPressed: (){
                //Empiler manuellement les routes
                //context.push("/page2");
                //On suit l'ordre des routes prévues dans le router
                context.go("/page2");
              },
              child: const Text("Valider"))
        ],),
    );
  }
}
