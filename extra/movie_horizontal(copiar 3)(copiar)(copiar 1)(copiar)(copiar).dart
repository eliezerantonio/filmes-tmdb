import 'package:filmes/src/models/filmes_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Filme> filmes;
  final Function paginaSeguinte;

  MovieHorizontal({@required this.filmes, @required this.paginaSeguinte});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        paginaSeguinte();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cartoes(context),
        itemCount: filmes.length,
        itemBuilder: (context, i) {
          return _cartao(context, filmes[i]);
        },
      ),
    );
  }

  Widget _cartao(BuildContext context, Filme filme) {

    filme.uiniqueId  = '${filme.id}-poster';
    final cartao = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
              tag: filme.uiniqueId
              ,
              
              child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(
                  filme.getPosterImg(),
                ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(filme.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption)
        ],
      ),
    );

    //para click

    return GestureDetector(
      child: cartao,
      onTap: () {
        //passando dados e indo para outra tela

        Navigator.pushNamed(context, 'detalhe',arguments: filme);
      },
    );
  }
}
