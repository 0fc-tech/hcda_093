import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnexionPage extends StatelessWidget {
  ConnexionPage({super.key});
  final tecEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: tecEmail,
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
                //context.go("/page2/${tecEmail.text}");
                context.go("/page2",extra: tecEmail.text);
              },
              child: const Text("Valider"))
        ],),
    );
  }
}
