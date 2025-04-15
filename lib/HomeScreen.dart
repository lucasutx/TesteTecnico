import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
 const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB3E5FC),
              Color(0xFFECE9E9),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Icon(
                    Icons.pets,
                    size: 100,
                    color: Colors.blueGrey,
                  ),
                 SizedBox(height: 24),
                 Text(
                    "Gerência de Hotel para Pets",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(221, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                 SizedBox(height: 70),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/manager');
                    },
                    label: Text(
                      "Cadastre novos pets no hotel",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold ,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                    ),
                  ),
                  SizedBox(height: 70,),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/listagem');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 75, 202, 141),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                  ),
                  child: const Text(
                    'Ver lista de pets cadastrados',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
