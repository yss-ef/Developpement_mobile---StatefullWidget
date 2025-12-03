import 'package:flutter/material.dart';

void main() => runApp(const Myapp());

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  // Contrôleur pour récupérer le texte saisi
  final TextEditingController _controller = TextEditingController();

  // Variable pour afficher le résultat
  String result = "";

  // Taux de change fixes
  final double tauxDollar = 0.1;
  final double tauxEuro = 0.095;
  final double tauxLivre = 0.079;

  // Fonction de conversion
  void convertir(double taux, String symbole) {
    // Fermer le clavier
    FocusManager.instance.primaryFocus?.unfocus();

    if (_controller.text.isEmpty) {
      setState(() {
        result = "";
      });
      return;
    }

    double? montantMAD = double.tryParse(_controller.text);

    if (montantMAD != null) {
      double montantConverti = montantMAD * taux;
      setState(() {
        // .toStringAsFixed(2) permet de garder 2 chiffres après la virgule
        result = "${montantConverti.toStringAsFixed(3)} $symbole";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Monnaie"),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Champ de saisie
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "MAD",
                  hintText: "Entrez le montant",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 20),

              // Rangée de boutons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Bouton Euro
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => convertir(tauxEuro, "€"),
                    child: const Text("€", style: TextStyle(fontSize: 24)),
                  ),
                  // Bouton Dollar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => convertir(tauxDollar, "\$"),
                    child: const Text("\$", style: TextStyle(fontSize: 24)),
                  ),
                  // Bouton Livre Sterling
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => convertir(tauxLivre, "£"),
                    child: const Text("£", style: TextStyle(fontSize: 24)),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Affichage du résultat
              Text(
                result,
                style: const TextStyle(
                  color: Colors.blue, // Couleur bleue comme sur l'image
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}