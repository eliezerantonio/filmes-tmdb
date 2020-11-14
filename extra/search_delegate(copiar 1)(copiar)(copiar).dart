import 'package:filmes/src/models/filmes_model.dart';
import 'package:filmes/src/providers/filmes_provider.dart';
import 'package:flutter/material.dart';

class DataSerach extends SearchDelegate {
  final filmes = [
    'SpiderMan',
    'Aquaman',
    'Batman',
    'Capitao america',
  ];
  final filmesRecentes = [
    'SpiderMan',
    'Capitao america',
  ];
  String selecao = '';
  final filmesProvider = new FilmesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    //limpar
    //acoes do noso app bar

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //voltar
    //icon a esquerda do appbar

    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //cria os resultado que vamos mostrar

    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selecao),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: filmesProvider.busarFilme(query),
        builder: (BuildContext context, AsyncSnapshot<List<Filme>> snaphot) {
          if (snaphot.hasData) {
            final filmes = snaphot.data;

            return ListView(
                children: filmes.map(
              (filme) {
                return ListTile(
                  leading: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(filme.getPosterImg()),
                      width: 50.0,
                      fit: BoxFit.contain),
                  title: Text(filme.title),
                  subtitle: Text(filme.originalTitle),
                  onTap: () {
                    close(context, null); //encerrar busca ao clicar
                    Navigator.pushNamed(context, 'detalhe', arguments: filme);
                    filme.uiniqueId = '';
                  },
                );
              },
            ).toList());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }

/*
  @override
  Widget buildSuggestions(BuildContext context) {
//mostrar sugoestpes ao escrever

    final listaSugerida = (query.isEmpty)
        ? filmesRecentes
        : filmes
            .where(
              (filme) => filme.toLowerCase().startsWith(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            selecao = listaSugerida[i];
            showResults(context);
          },
        );
      },
    );
  }*/
}
