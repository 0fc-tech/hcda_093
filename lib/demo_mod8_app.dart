import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_cours/demo_mod8_connexion.dart';
import 'package:tp_cours/demo_mod8_page2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final goRouter = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            builder: (context,state)=> ConnexionPage(),

        ),
        GoRoute(
          path: '/page2/:email',
          builder: (context,state)=> SecondPage(
              state.pathParameters["email"] ?? ""
          ),
        ),
        GoRoute(
          path: '/page2',
          builder: (context,state){
            if(state.extra != null && state.extra is String) {
              return SecondPage(
                  state.extra as String
              );
            } else{
              return SecondPage("");
            }
          }
        ),
      ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text("Mhh... Ca ne sert à rien")),
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Mod 8 Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}