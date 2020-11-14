import 'package:filmes/src/pages/filme_detalhe.dart';
import 'package:filmes/src/pages/home_page.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Filmes',
      initialRoute: '/',//rota principa
      routes: {
        '/':(BuildContext context)=>HomePage(),
        'detalhe':(BuildContext contex)=>FilmeDetalhe(),
      },
    );
  }
}