import 'package:filmes/src/providers/filmes_provider.dart';
import 'package:filmes/src/search/search_delegate.dart';
import 'package:filmes/widgets/card_swiper_widget.dart';
import 'package:filmes/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final filmesProvider = new FilmesProvider();
  @override
  Widget build(BuildContext context) {
    filmesProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Filmes em cinema",
        ),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSerach(), query: '');
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCartoes(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCartoes() {
    return FutureBuilder(
      future: filmesProvider.getEnCine(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            filmes: snapshot.data,
          );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child:
                Text('Populares', style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: filmesProvider.popularesStream, //vindo do filme provider
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  filmes: snapshot.data,
                  paginaSeguinte: filmesProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
