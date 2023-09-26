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
        home: CounterPage()
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  double sldieValue = 0;
  @override
  Widget build(BuildContext context) {
    print("Je suis reconstruit avec les valeurs $_counter et $sldieValue");
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text(_counter.toString()),
          Slider(value: sldieValue,max: 1,
            divisions: 5,
            onChanged: (valueSlide){
              setState(() {
                sldieValue = valueSlide;
              });
            },
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _counter++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
