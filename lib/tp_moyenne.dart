extension Sum on List{
  num sum(){
    return reduce((value, element) => value+element);
  }
}
extension AffichageFR on DateTime{
  String afficheHM(){
    return "$hour h $minute m";
  }
}
void main(){
  final francais = Matiere("francais",[12.5,65.2,12.3,32.1,12.0]);
  final math =  Matiere("math",[12.5,65.2,12.3,32.1,12]);
  final info =  Matiere("info",[12.5,65.2,12.3,32.1,12]);
  DateTime(2023);
  calculMoyenne([francais,math,info]);
}
class Matiere{
  List<double> listNotes;
  String libelle;
  Matiere(this.libelle,this.listNotes);
}

double calculMoyenne(List<Matiere> listMatieres){
  double moyenne = 0;
  List<double> moyennes = [];
  listMatieres.forEach((matiere) {
    moyenne = matiere.listNotes.reduce((value, element) => value+element)/
        matiere.listNotes.length;
    print("La moyenne ${matiere.libelle} est de  ${moyenne}");
    moyennes.add(moyenne);
  });
  print("La moyenne générale est de  ${moyennes.sum() / moyennes.length}");

  return moyenne;
}