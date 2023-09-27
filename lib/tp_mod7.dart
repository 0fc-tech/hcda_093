

import 'package:flutter/material.dart';
import 'package:tp_cours/demo_mod6.dart';

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
        home: const TwitterPage());
  }
}

class TwitterPage extends StatelessWidget {

  const TwitterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Twitter",style: TextStyle(color: Colors.white),),
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor:Colors.lightBlue,
      ),
      body:  Column(
        children: [
          const TopNavigationTwitter(),
          FormConnexion(),
          FutureBuilder<String>(
            future: Future.delayed(const Duration(seconds: 1),()=> ""),
            builder: (context, snapshot) {
              switch(snapshot.connectionState){
                case ConnectionState.done:
                  return Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context,index)=>const TweetWithButtons())
                  );
                default : return  const CircularProgressIndicator();
              }
            }
          ),
        ],
      ),
      bottomNavigationBar:  const BottomNavigationTwitter(),
    );
  }
}

class FormConnexion extends StatefulWidget {
  const FormConnexion({
    super.key,
  });

  @override
  State<FormConnexion> createState() => _FormConnexionState();
}

class _FormConnexionState extends State<FormConnexion> {

  final _keyForm = GlobalKey<FormState>();
  final textEditContID = TextEditingController();
  final textEditContPWD = TextEditingController();
  var switchRemember = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _keyForm,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("Connexion à Twitter"),
          TextFormField(
            controller: textEditContID,
            decoration: const InputDecoration(hintText: "Identifiant"),
            validator: (val){
              if(val == null || val.isEmpty){
                return "Veuillez remplir le champ";
              }
              if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z.]{2,6}$").hasMatch(val)){
                return "Vérifier le format (ex: john@kennedy.gov)";
              }
              return null;
            },
          ),
          TextFormField(
            controller: textEditContPWD,
            decoration: const InputDecoration(hintText: "Mot de passe"),
            validator: (val){
              if(val == null || val.isEmpty){
                return "Veuillez remplir le champ";
              }
              return null;
            },
          ),
          SwitchListTile(controlAffinity: ListTileControlAffinity.leading,
            value: switchRemember,
            onChanged: (val){
              setState(() {
                switchRemember = val;

              });
            },
            title: Text("Mémoriser mes informations"),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
                onPressed: (){
                  if(_keyForm.currentState?.validate() == true){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Bienvenu ${textEditContID.text}")
                        )
                    );
                  }
                }, icon: Icon(Icons.login
            ),
            label: Text("Connexion")),
          )
        ],),
      ),
    );
  }
}

class TweetWithButtons extends StatelessWidget {
  const TweetWithButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Tweet(DateTime(2023,12,3,12,50,12)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ButtonTweetBar(),
          )
        ],
      ),
    );
  }
}

class Tweet extends StatelessWidget {
  final DateTime dateTime;
  Tweet(this.dateTime,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Image.network("https://picsum.photos/150",width: 125,height: 125,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("LaCrevette@Chocolate",
                        style: Theme.of(context).textTheme.titleSmall),
                    Text("${dateTime.minute}m",
                      style: const TextStyle(color: Colors.grey),),
                  ],
                ),
                const SizedBox(height: 8,),
                const Text("latine euismod nulla mauris corrumpit scripserit unum causae justo pellentesque scripta justo ius elitr orci")
              ],
            ),
          ),
        )
      ]
    );
  }
}

class ButtonTweetBar extends StatefulWidget {

  const ButtonTweetBar({
    super.key,
  });

  @override
  State<ButtonTweetBar> createState() => _ButtonTweetBarState();
}

class _ButtonTweetBarState extends State<ButtonTweetBar> {
  bool _isLiked = false;
  bool _isRT = false;
  void _changeLike(){
    //Je signale à Flutter que _ButtonTweetBarState est dirty et donc que l'on
    //doit redéclencher un build().
    setState(() {
      _isLiked = !_isLiked;
    });
  }
  void _changeRT(){
    //Je signale à Flutter que _ButtonTweetBarState est dirty et donc que l'on
    //doit redéclencher un build().
    setState(() {
      _isRT = !_isRT;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Répondre"),
        _isRT ?
          IconButton(icon: Icon(Icons.repeat, color: Colors.blue,),onPressed: ()=>_changeRT(),)
            :
          IconButton(icon: Icon(Icons.repeat),onPressed: ()=>_changeRT(),),
        _isLiked ?
          IconButton(icon: Icon(Icons.favorite, color: Colors.red,),onPressed: ()=>_changeLike(),)
            :
          IconButton(icon: Icon(Icons.favorite_border),onPressed: ()=>_changeLike(),)
      ],
    );
  }
}

class TopNavigationTwitter extends StatelessWidget {
  const TopNavigationTwitter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(0xFF,0x58,0xB0,0xF0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){}, icon:const Icon(Icons.edit,color: Colors.white),),
            TextButton(onPressed: (){}, child: const Text("Accueil",
              style: TextStyle(color: Colors.white),)),
            IconButton(onPressed: (){}, icon:const Icon(Icons.search,color: Colors.white),),
        ],),
      ),
    );
  }
}

class BottomNavigationTwitter extends StatelessWidget {
  const BottomNavigationTwitter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(onPressed: (){}, child: const Text("Fil",
          style: TextStyle(color: Colors.blue),)),
        TextButton(onPressed: (){}, child: const Text("Notification",
          style: TextStyle(color: Colors.grey),)),
        TextButton(onPressed: (){}, child: const Text("Messages",
          style: TextStyle(color: Colors.grey),)),
        TextButton(onPressed: (){}, child: const Text("Moi",
          style: TextStyle(color: Colors.grey),)),
      ],
    );
  }
}















